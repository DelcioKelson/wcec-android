
(* The type of tokens. *)

type token = 
  | STRING of (string)
  | EQUAL
  | EOF

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.edge)
