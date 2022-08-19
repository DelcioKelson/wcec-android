{
  open Lexing

  type token =
    | CONST of int
    | PLUS
    | TIMES
    | LEFTPAR
    | RIGHTPAR
    | EOF

}

let white_space = [' ' '\t' '\n']+
let integer     = ['0'-'9']+

rule token = parse
  | white_space
      { token lexbuf }
  | integer as s
      { CONST (int_of_string s) }
  | '+'
      { PLUS }
  | '*'
      { TIMES }
  | '('
      { LEFTPAR }
  | ')'
      { RIGHTPAR }
  | eof
      { EOF }
  | _ as c
      { failwith ("illegal character" ^ String.make 1 c) }
