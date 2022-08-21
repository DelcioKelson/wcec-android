open Str
open String
open Lexer
open Lexing
open Parser
open Printf
open Ast
open List
exception Error of string

let filename = Sys.argv.(1)
let filename2 = Sys.argv.(2)

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

let model = Hashtbl.create 1000;;

let rec load s = 
  match s with
  | Inst (inst,v) -> Hashtbl.add model inst v
  | Sline (s1::l) -> load s1; load (Sline (l)) 
  | Sline ([]) -> ()
  

let () =
  let inx = open_in filename in
  let lexbuf = Lexing.from_channel inx in
  let blocks = parse_with_error lexbuf in
  let () = load blocks in 
   close_in inx 

let rec read_file ch = match input_line ch with
    | x -> x ::(read_file ch)
    | exception End_of_file -> []

let contains s1 s2 =
  let re = Str.regexp_string s2
  in
      try ignore (Str.search_forward re s1 0); true
      with Not_found -> false


let get_value line =  
  let r = ref 1.0 in 
  let () = Hashtbl.iter (fun x y -> if (contains line x) then (r := y)
   else if (contains line ":") then r:=0.0)  model in
  !r

let label = Hashtbl.create 5
let () = Hashtbl.add label "label1" 3
let () = Hashtbl.add label "label3" 5

(*get the first element of the string*)
let get_loop_bound s = 
  let lb = trim (List.hd (Str.split (Str.regexp ":") s)) in
  Hashtbl.find label lb 

let rec apply_model lines times in_loop= 
  match lines with
  | l::ls -> 
    let energy_inst = Float.mul (get_value l) (float times) in
    if (energy_inst = 0.0 ) && in_loop then apply_model ls 1 false 
    else if (energy_inst = 0.0 ) then apply_model ls (get_loop_bound l) true
    else Float.add energy_inst  (apply_model ls times in_loop) 
  | [] -> 0.0


let () = print_float (apply_model (read_file (open_in filename2)) 1 false)  