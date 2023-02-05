{
open Lexing
open Parser

exception SyntaxError of string
}

let digit = ['0'-'9']
let frac = '.' digit*
let float = digit* frac?+
let space = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read = parse
  | space+    { read lexbuf }
  | newline  { new_line lexbuf; read lexbuf }
  | float    { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | id       { STRING (Lexing.lexeme lexbuf) }
  | '|'       {VERTICALBAR }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }