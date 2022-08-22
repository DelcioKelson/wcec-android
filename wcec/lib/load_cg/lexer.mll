{
open Lexing
open Parser

exception SyntaxError of string

}


let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let id = [^'\n''=']*

rule read = parse
  | white    { read lexbuf }
  | newline  { new_line lexbuf; read lexbuf }
  | id       { STRING (Lexing.lexeme lexbuf) }
  | '='       {EQUAL }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }