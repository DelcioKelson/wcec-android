open Ast
open Lexer
open Lexing
open Parser
open Printf
open List
exception Error of string
open Core

let args = Sys.get_argv()
let filename = args.(1)

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.file Lexer.token lexbuf with
  | SyntaxError msg ->
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    exit (-1)
  | Parser.Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)

let rec stmt_print s = 
  match s with
  | Sblock(Sassign(x1,x2)::l) -> printf "Sassign"; stmt_print (Sblock l)
  | Sblock(Sgoto(x1,x2)::l) -> printf "Sgoto"; stmt_print (Sblock l)
  | _ -> printf ""


let () =
  let inx = In_channel.create filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  stmt_print (parse_with_error lexbuf);
  In_channel.close inx