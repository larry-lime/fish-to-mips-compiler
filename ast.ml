open Sexplib.Std

(* The abstract syntax for our little subset of Fortran *)
type var = string [@@deriving sexp]
type pos = int [@@deriving sexp] (* position is line number in source file *)

type binop =
  | Plus
  | Minus
  | Times
  | Div (* +, -, *, /           *)
  | Eq
  | Neq
  | Lt
  | Lte
  | Gt
  | Gte
[@@deriving sexp]
(* ==, !=, <, <=, >, >= *)

type rexp =
  | Int of int
  | Var of var
  | Binop of exp * binop * exp
  | Not of exp (* !x *)
  | And of exp * exp (* x < y && y < z *)
  | Or of exp * exp (* x < y || x < z *)
  | Assign of var * exp (* x = y+42 *)

(* every expression comes with its position *)
and exp = rexp * pos [@@deriving sexp]

type rstmt =
  | Exp of exp (* x = 3+4; *)
  | Seq of stmt * stmt (* x = 2*9; y = 42; *)
  | If of exp * stmt * stmt (* if (x == y) x = 42 else y = 43 *)
  | While of exp * stmt (* while (x < y) x = x + 1; *)
  | For of exp * exp * exp * stmt (* for (x=0; x<y; x=x+1) y=y*42; *)
  | Return of exp (* return e; *)

(* every statement comes with its position *)
and stmt = rstmt * pos [@@deriving sexp]

let skip : rstmt = Exp (Int 0, 0) (* simulate a skip statement *)

type program = stmt [@@deriving sexp]

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
