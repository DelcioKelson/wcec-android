
(* The type of tokens. *)

type token = 
  | VERTICALBAR
  | STRING of (string)
  | FLOAT of (float)
  | EOF

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.stmt)
