open Lexing
open Printf
open Ast
open List
exception SyntaxError of string


let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.file Lexer.read lexbuf with
  | SyntaxError msg ->
    printf "%a: %s\n" print_position lexbuf msg;
    exit (-1)
  | Parser.Error ->
    printf "%a: cg syntax error\n" print_position lexbuf;
    exit (-1)


let rec load s = 
  match s with
  | Cg (Edge (from_node,to_node)::l) -> (from_node,to_node) :: (load (Cg (l))) 
  | Cg ([]) | _-> []
  

let load_cg cg_file =
  let file = open_in cg_file in
  let lexbuf = Lexing.from_channel file in
  let blocks = parse_with_error lexbuf in
  let edges = load blocks in 
  let () = close_in file in
   edges