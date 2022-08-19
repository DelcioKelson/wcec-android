
(* The type of tokens. *)

type token = 
  | TIMES
  | PLUS
  | NEWLINE
  | MOD
  | MINUS
  | IF
  | IDENT of (string)
  | GOTO
  | EQUAL
  | EOF
  | DIV
  | CST of (int)
  | COLON
  | BNEQ
  | BLT
  | BLE
  | BGT
  | BGE
  | BEQ

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.stmt)
