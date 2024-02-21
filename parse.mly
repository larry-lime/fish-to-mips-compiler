%{
open Ast
open Lexing
let rhs n =
  let pos = Parsing.rhs_start_pos n in
  pos.pos_lnum
let parse_error s =
  let pos = Parsing.symbol_end_pos () in
  let l = pos.pos_lnum in
  print_string ("line "^(string_of_int l)^": "^s^"\n")
%}

%start program

%type <Ast.program> program
%type <Ast.stmt> stmt

%token <int> INT
%token <string> VAR
%token PLUS MINUS TIMES DIV
%token AND OR NOT EQ NEQ LT LTE GT GTE
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token IF ELSE WHILE FOR RETURN NOELSE
%token EOF
%token LCOMMENT RCOMMENT

%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT LTE GT GTE
%left PLUS MINUS
%left TIMES DIV
%right NOT
%%

program:
  stmt EOF { $1 }

stmt:
  | FOR LPAREN exp SEMI exp SEMI exp RPAREN LBRACE stmt RBRACE { For($3, $5, $7, $10), rhs 1 }
  | FOR LPAREN exp SEMI exp SEMI exp RPAREN stmt %prec NOELSE { For($3, $5, $7, $9), rhs 1 } /* Modified rule for for loop without braces */
  | FOR LPAREN exp SEMI exp SEMI exp RPAREN stmt stmt { Seq((For($3, $5, $7, $9),rhs 1), $10), rhs 1 }
  | WHILE LPAREN exp RPAREN LBRACE stmt RBRACE { While($3, $6), rhs 1 }
  | WHILE LPAREN exp RPAREN stmt { While($3, $5), rhs 1 }
  | IF LPAREN exp RPAREN LBRACE stmt RBRACE ELSE stmt stmt { Seq((If($3, $6, $9), rhs 1), $10), rhs 1 }
  | IF LPAREN exp RPAREN LBRACE stmt RBRACE ELSE stmt { If($3, $6, $9), rhs 1 }
  | IF LPAREN exp RPAREN LBRACE stmt RBRACE %prec NOELSE { If($3, $6, (skip, 0)), rhs 1 }
  | IF LPAREN exp RPAREN stmt ELSE stmt stmt { Seq((If($3, $5, $7), rhs 1), $8), rhs 1 }
  | exp SEMI { Exp($1), rhs 1 }
  | RETURN exp SEMI { Return($2), rhs 1 }
  | stmt stmt { Seq($1, $2), rhs 1 }
  | { Return((Int 0,0)), rhs 0 }
  | LBRACE stmt RBRACE { $2 }


exp:
  | VAR ASSIGN exp { Assign($1, $3), rhs 2 }
  | exp LT exp { Binop($1, Lt, $3), rhs 2 }
  | exp PLUS exp { Binop($1, Plus, $3), rhs 2 }
  | INT { Int($1), rhs 1 }
  | VAR { Var($1), rhs 1 }
  | exp AND exp { And($1, $3), rhs 2 }
  | exp OR exp { Or($1, $3), rhs 2 }
  | exp MINUS exp { Binop($1, Minus, $3), rhs 2 }
  | exp TIMES exp { Binop($1, Times, $3), rhs 2 }
  | exp DIV exp { Binop($1, Div, $3), rhs 2 }
  | exp EQ exp { Binop($1, Eq, $3), rhs 2 }
  | exp NEQ exp { Binop($1, Neq, $3), rhs 2 }
  | exp LTE exp { Binop($1, Lte, $3), rhs 2 }
  | exp GT exp { Binop($1, Gt, $3), rhs 2 }
  | exp GTE exp { Binop($1, Gte, $3), rhs 2 }
  | MINUS exp { Binop((Int(-1), rhs 1), Times, $2), rhs 1 }
  | NOT exp { Not($2), rhs 1 }
  | LPAREN exp RPAREN { $2 }
