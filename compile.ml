(* Compile Fish AST to MIPS AST *)
open Mips
open Ast

exception IMPLEMENT_EXPRESSION
exception IMPLEMENT_VAR_COLLECTION

(* The functions below are used to convert expressions and statements to strings. Useful for debugging *)
let rec binop2string = function
  | Plus -> "+"
  | Minus -> "-"
  | Times -> "*"
  | Div -> "/"
  | Eq -> "=="
  | Neq -> "!="
  | Lt -> "<"
  | Lte -> "<="
  | Gt -> ">"
  | Gte -> ">="

let rec exp2string ((exp, pos) : exp) : string =
  match exp with
  | Int n -> string_of_int n
  | Var v -> v
  | Binop (e1, op, e2) ->
      "(" ^ exp2string e1 ^ " " ^ binop2string op ^ " " ^ exp2string e2 ^ ")"
  | Not e -> "!(" ^ exp2string e ^ ")"
  | And (e1, e2) -> "(" ^ exp2string e1 ^ " && " ^ exp2string e2 ^ ")"
  | Or (e1, e2) -> "(" ^ exp2string e1 ^ " || " ^ exp2string e2 ^ ")"
  | Assign (v, e) -> v ^ " = " ^ exp2string e

let rec stmt2string ((s, pos) : stmt) : string =
  match s with
  | Exp e -> exp2string e
  | Seq (s1, s2) -> stmt2string s1 ^ "; " ^ stmt2string s2
  | If (e, s1, s2) ->
      "if " ^ exp2string e ^ " then " ^ stmt2string s1 ^ " else "
      ^ stmt2string s2
  | While (e, s1) -> "while " ^ exp2string e ^ " do " ^ stmt2string s1
  | For (e1, e2, e3, s1) ->
      "for " ^ exp2string e1 ^ "; " ^ exp2string e2 ^ "; " ^ exp2string e3
      ^ " do " ^ stmt2string s1
  | Return e -> "return " ^ exp2string e

type result = { code : Mips.inst list; data : Mips.label list }

(* generate fresh labels *)
let label_counter = ref 0

let new_int () =
  label_counter := !label_counter + 1;
  !label_counter

let new_label () = "L" ^ string_of_int (new_int ())

(* sets of variables -- Ocaml Set and Set.S *)
module VarSet = Set.Make (struct
  type t = Ast.var

  let compare = String.compare
end)

(* a table of variables that we need for the code segment *)
let variables : VarSet.t ref = ref VarSet.empty

(* generate a fresh temporary variable and store it in the variables set. *)
(*NOTE: Likely used in collect vars*)
let rec new_temp () =
  let t = "T" ^ string_of_int (new_int ()) in
  (* make sure we don't already have a variable with the same name! *)
  if VarSet.mem t !variables then new_temp ()
  else (
    variables := VarSet.add t !variables;
    t)

(* reset internal state *)
let reset () =
  label_counter := 0;
  variables := VarSet.empty

(* find all of the variables in a program and add them to
 * the set variables *)
(* NOTE: This return unit (which is like None) *)
let rec collect_vars (p : Ast.program) : unit =
  (* print_string ("Collected vars statement: " ^ stmt2string p ^ "\n"); *)
  (*************************************************************)
  ()

(*************************************************************)

(* compiles a Fish statement down to a list of MIPS instructions.
 * Note that a "Return" is accomplished by placing the resulting
 * value in R2 and then doing a Jr R31.
 *)
(* TODO: Compile Fish *)
let rec exp2mips ((e, p) : Ast.exp) : inst list =
  (* print_string ("Expression: " ^ exp2string (e, p) ^ "\n"); *)
  match e with
  | Int j -> [ Li (R2, Word32.fromInt j) ]
  | Var x -> [ La (R2, x); Lw (R2, R2, Word32.fromInt 0) ]
  | Binop (e1, b, e2) -> (
      let t = new_temp () in
      exp2mips e1
      @ [ La (R3, t); Sw (R2, R3, Word32.fromInt 0) ]
      @ exp2mips e2
      @ [ La (R3, t); Lw (R3, R3, Word32.fromInt 0) ]
      @
      match b with
      | Plus -> [ Add (R2, R2, Reg R3) ]
      | Minus -> [ Sub (R2, R3, R2) ]
      | Times -> [ Mul (R2, R2, R3) ]
      | Div -> [ Div (R2, R3, R2) ]
      | Eq -> [ Seq (R2, R3, R2) ]
      | Neq -> [ Sne (R2, R3, R2) ]
      | Lt -> [ Slt (R2, R3, R2) ]
      | Lte -> [ Sle (R2, R3, R2) ]
      | Gt -> [ Sgt (R2, R3, R2) ]
      | Gte -> [ Sge (R2, R3, R2) ])
  | Assign (x, e) -> exp2mips e @ [ La (R3, x); Sw (R2, R3, Word32.fromInt 0) ]
  | _ -> raise IMPLEMENT_EXPRESSION

let rec compile_stmt ((s, p) : Ast.stmt) : inst list =
  (*************************************************************)
  (* print_string ("Statement:" ^ stmt2string (s, p) ^ "\n"); *)
  match s with
  | Exp e -> exp2mips e
  | Seq (s1, s2) -> compile_stmt s1 @ compile_stmt s2
  | If (e, s1, s2) ->
      let else_l = new_label () in
      let end_l = new_label () in
      exp2mips e
      @ [ Beq (R2, R0, else_l) ]
      @ compile_stmt s1 @ [ J end_l; Label else_l ] @ compile_stmt s2
      @ [ Label end_l ]
  | While (e, s) ->
      let test_l = new_label () in
      let top_l = new_label () in
      [ J test_l; Label top_l ] @ compile_stmt s @ [ Label test_l ] @ exp2mips e
      @ [ Bne (R2, R0, top_l) ]
  (*TODO: Check that this is right*)
  | For (e1, e2, e3, s) ->
      compile_stmt
        (Seq ((Exp e1, 1), (While (e2, (Seq (s, (Exp e3, 1)), 1)), 1)), 1)
  | Return e -> exp2mips e @ [ Jr R31 ]

(* *********************************************************** *)

(* compiles Fish AST down to MIPS instructions and a list of global vars *)
let compile (p : Ast.program) : result =
  let _ = reset () in
  let _ = collect_vars p in
  let insts = Label "fish_main" :: compile_stmt p in
  { code = insts; data = VarSet.elements !variables }

(* converts the output of the compiler to a big string which can be 
 * dumped into a file, assembled, and run within the SPIM simulator
 * (hopefully). *)
let result2string ({ code; data } : result) : string =
  let strs = List.map (fun x -> Mips.inst2string x ^ "\n") code in
  let var2decl x = x ^ ":\t.word 0\n" in
  "\t.text\n" ^ "\t.align\t2\n" ^ "\t.globl printInt\n" ^ "\t.globl fish_main\n"
  ^ "\t.globl main\n\n" ^ "main:\n" ^ "\tmove $s8, $31\n" ^ "\tjal fish_main\n"
  ^ "\tmove $31, $s8\n" ^ "\tmove $a0, $2\n" ^ "\tj printInt\n\n"
  ^ "printInt:\n" ^ "\tadd $t0, $v0, $zero\n" ^ "\tli $v0, 1\n" ^ "\tsyscall\n"
  ^ "\tadd $v0, $t0, $zero\n" ^ "\tjr $ra\n\n" ^ String.concat "" strs ^ "\n\n"
  ^ "\t.data\n" ^ "\t.align 0\n"
  ^ String.concat "" (List.map var2decl data)
  ^ "\n"
