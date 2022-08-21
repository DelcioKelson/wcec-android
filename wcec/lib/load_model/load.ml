open Lexer
open Lexing
open Parser
open Printf
open Ast
open List
exception Error of string


let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.file Lexer.read lexbuf with
  | SyntaxError msg ->
    printf "%a: %s\n" print_position lexbuf msg;
    exit (-1)
  | Parser.Error ->
    printf "%a: syntax error\n" print_position lexbuf;
    exit (-1)

let model = Hashtbl.create 200;;

let rec load s = 
  match s with
  | Inst (inst,v) -> Hashtbl.add model inst v
  | Sline (s1::l) -> load s1; load (Sline (l)) 
  | Sline ([]) -> ()
  

let load_model model_file =
  let inx = open_in model_file in
  let lexbuf = Lexing.from_channel inx in
  let blocks = parse_with_error lexbuf in
  let () = load blocks in 
   let () = close_in inx in
   model