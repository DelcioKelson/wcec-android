

open Abs
open Ast
open Lexer
open Lexing
open Parser
open Printf
open List
exception Error of string

type ctx_abs = (ident, val_abs) Hashtbl.t


let filename = Sys.argv.(1)

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


let print_abs a = 
  match a with
  | Abot -> print_string "Abot"
  | Ainter (x1,x2) ->   Printf.printf "Ainter: %i: %i\n%!" x1 x2
  | Aposinf x ->   Printf.printf "Aposinf: %i" x
  | Aneginf x ->   Printf.printf "Aneginf %i" x
  | Anegposinf ->   Printf.printf "Anegposinf"


  (*let n = ai_com (1, Cseq ((0,Cassign (0,Esct 4)),(1, Cwhile((Cinfeq, 4, 0 ), (3,(Cassign (0, Esct 4 ))))))) aenv
*)

(*
let rec stmt_print s = 
  match s with
  | Sblock(Sassign(x1,x2)::l) -> printf "Sassign"; stmt_print (Sblock l)
  | Sblock(Sgoto(x1,x2)::l) -> printf "Sgoto"; stmt_print (Sblock l)
  | _ -> printf ""
*)
let result =
  let inx = open_in filename in
  let lexbuf = Lexing.from_channel inx in
  let blocks = parse_with_error lexbuf in
  let r = get_bounds blocks in 
  let () = close_in inx in
  r


let () = 
Hashtbl.iter  (fun x a0 ->print_string x; print_int a0) result