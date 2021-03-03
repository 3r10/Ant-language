(* File lexer.mll *)
{
open Parser        (* The type token is defined in parser.mli *)
exception LexerError of string
}

let integer = ['0'-'9']+
let id = ['a'-'z' 'A'-'Z' '_' ]['a'-'z' 'A'-'Z' '_' '0'-'9']*

rule token = parse
  | ['\n']          { EOL }
  | "@"             { CALL }
  | "+"             { PLUS }
  | "-"             { MINUS }
  | "=="            { EQ }
  | "!="            { NE }
  | ">="            { GE }
  | ">"             { GT }
  | "<="            { LE }
  | "<"             { LT }
  | ":="            { ASSIGN }
  | eof             { EOF }
  | "if "           { IF }
  | " then"         { THEN }
  | "else"          { ELSE }
  | "while "        { WHILE }
  | "for "          { FOR }
  | " in "          { IN }
  | ":"             { COLUMN }
  | " do"           { DO }
  | "end"           { END }
  | integer as lxm  { INT (int_of_string lxm) }
  | id as lxm       { ID (lxm) }
  | [' ' '\t']      { token lexbuf }     (* skip blanks *)
  | _ as c          {
    raise (LexerError (Printf.sprintf "unknown character '%c'" c ))
  }
