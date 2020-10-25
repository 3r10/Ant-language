/* File parser.mly */

%{
open Ast
%}

%token PLUS MINUS
%token EQ NE GE GT LE LT
%token ASSIGN CALL
%token IF THEN ELSE WHILE DO FOR IN COLUMN END
%token EOL EOF

%token <int> INT
%token <string> ID

%start main             /* the entry point */
%type <Ast.program> main

%%
main:
    statements_opt EOF { Main($1) }
;

statements_opt:
  /* empty */ {
    []
  }
| EOL statements_opt {
    $2
  }
| statements {
    $1
  }
;

statements:
  statement_eol {
    [$1]
  }
| statement_eol statements {
    $1::$2
  }
;

statement_eol:
  statement EOL {
    $1
  }
;

statement:
  ID ASSIGN expr  {
    Assignment ($1,$3)
  }
| ID CALL value {
    Call ($1,$3)
}
| IF condition THEN EOL statements_opt END {
    Branch ($2,$5,[])
  }
| IF condition THEN EOL statements_opt ELSE EOL statements_opt END {
    Branch ($2,$5,$8)
  }
| WHILE condition DO EOL statements_opt END {
    While ($2,$5)
  }
| FOR ID IN expr COLUMN expr COLUMN expr DO EOL statements_opt END {
    For ($2,$4,$6,$8,$11)
  }
;

condition:
  expr EQ expr {
    Cond("==",$1,$3)
  }
| expr NE expr {
    Cond("!=",$1,$3)
  }
| expr GE expr {
    Cond(">=",$1,$3)
  }
| expr GT expr {
    Cond(">",$1,$3)
  }
| expr LE expr {
    Cond("<=",$1,$3)
  }
| expr LT expr {
    Cond("<",$1,$3)
  }
;

expr:
  value {
    Atom($1)
  }
| MINUS value {
    Neg($2)
  }
| expr PLUS value {
    BinOp("+",$1,$3)
  }
| expr MINUS value {
    BinOp("-",$1,$3)
  }
;

value:
  INT {
    Const ($1)
  }
| ID {
    Id ($1)
  }
;
