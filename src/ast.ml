type atom =
    Const of int
  | Id of string

type expression =
    Atom of atom
  | Neg of atom
  | BinOp of string * expression * atom

type condition =
    Cond of string * expression * expression

type statement =
    Assignment of string * expression
  | Call of string * atom
  | Branch of condition * statement list * statement list
  | While of condition * statement list
  | For of string * expression * expression  * expression * statement list

type program = Main of statement list

(* AST display *)
let string_of_atom a = match a with
    Const (n) -> (string_of_int n)
  | Id (s) -> s

let rec string_of_expression e = match e with
    Atom (a) -> (string_of_atom a)
  | Neg (a) -> "-"^(string_of_atom a)
  | BinOp (op,expr,a) ->
    (string_of_expression expr)^op^(string_of_atom a)

let string_of_condition cond = match cond with
    Cond (op,expr1,expr2) ->
    (string_of_expression expr1)^op^(string_of_expression expr2)

let rec string_of_statement (stmt,prepend) = match stmt with
    Assignment (id,expr) ->
    "Assignment\n"
    ^prepend^"├i─"^id^"\n"
    ^prepend^"└─ "^string_of_expression(expr)^"\n"
  | Call (id,a) ->
    "Call\n"
    ^prepend^"├i─"^id^"\n"
    ^prepend^"└─ "^string_of_atom(a)^"\n"
  | Branch (cond,if_seq,else_seq) ->
    "Branch\n"
    ^prepend^"├c─"^string_of_condition(cond)^"\n"
    ^prepend^"├i─┐\n"
    ^string_of_sequence(if_seq,prepend^"│  ")
    ^prepend^"e\n"
    ^string_of_sequence(else_seq,prepend)
  | While (cond,seq) ->
    "While\n"
    ^prepend^"├c─"^string_of_condition(cond)^"\n"
    ^string_of_sequence(seq,prepend)
  | For (id,start_expr,step_expr,end_expr,seq) ->
    "For\n"
    ^prepend^"├i─"^id^"\n"
    ^prepend^"├r─"^string_of_expression(start_expr)^":"^string_of_expression(step_expr)^":"^string_of_expression(end_expr)^"\n"
    ^string_of_sequence(seq,prepend)

and string_of_sequence (seq,prepend) = match seq with
    [] -> ""
  | stmt::seq' ->
    match seq' with
      [] -> prepend^"└──"^string_of_statement(stmt,prepend^"   ")
    | _  -> prepend^"├──"^string_of_statement(stmt,prepend^"│   ")
            ^string_of_sequence(seq',prepend)

let string_of_program (prog,prepend) = match prog with
    Main (seq) -> (
      prepend^"Main\n"
      ^string_of_sequence (seq,prepend)
    )
