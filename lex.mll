{
open Parse
open Lexing

let incr_lineno lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <- { pos with
    pos_lnum = pos.pos_lnum + 1;
    pos_bol = pos.pos_cnum;
  }
}

let cr='\013'
let nl='\010'
let eol=(cr nl|nl|cr)
let ws=('\012'|'\t'|' ')*

let alpha = ['a'-'z' 'A'-'Z']
let digit=['0'-'9'] 
let alphanum = alpha | digit | '_'
let identifier = alpha alphanum*


rule lexer = parse
| eol { incr_lineno lexbuf; lexer lexbuf }
| digit+ as num { INT(int_of_string num) }
| ws+ { lexer lexbuf }
| "for" { FOR }
| "return" { RETURN }
| "if" { IF }
| "else" { ELSE }
| "while" { WHILE }
| '+' { PLUS }
| '-' { MINUS }
| '*' { TIMES }
| "&&" { AND }
| "||" { OR }
| '/' { DIV }
| ">" { GT }
| "<" { LT }
|"<=" { LTE }
|">=" { GTE }
| "==" { EQ }  (* Add this line for the "==" operator *)
| "!=" { NEQ }  (* Add this line for the "==" operator *)
| '=' { ASSIGN }
| ';' { SEMI }
| '(' { LPAREN }
| ')' { RPAREN }
| '{' { LBRACE }
| '}' { RBRACE }
(* | "/_" { comment lexbuf } (* Handle comments *) *)
| "/*" { comment lexbuf } (* Handle comments *)
| "!" { NOT }  (* Add this line for the "==" operator *)
| identifier as var { VAR(var) } (* Add this line to recognize variables *)
| eof { EOF }  (* Add this line to handle EOF *)
(* | ',' { COMMA } *)

and comment = parse
(* | "_/" { lexer lexbuf } (* End comment mode and return to main lexer *) *)
| "*/" { lexer lexbuf } (* End comment mode and return to main lexer *)
| _ { comment lexbuf } (* Ignore everything within comments *)
| eof { failwith "Comment not terminated" }
