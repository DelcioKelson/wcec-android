open Abs
open Lexing
open Printf
open List
exception SyntaxError of string

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf method_file =
  let() = print_string method_file in
  try Parser.file Lexer.token lexbuf with
  | SyntaxError msg ->
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    exit (-1)
  | Parser.Error -> Sskip
  (*let() = print_string method_file in
    fprintf stderr "%a: file_to_analyse syntax error in file\n" print_position lexbuf;*)

(*let print_abs a = 
    match a with
    | Abot -> print_string "Abot"
    | Ainter (x1,x2) ->   Printf.printf "Ainter: %i: %i\n%!" x1 x2
    | Aposinf x ->   Printf.printf "Aposinf: %i" x
    | Aneginf x ->   Printf.printf "Aneginf %i" x
    | Anegposinf ->   Printf.printf "Anegposinf"
*)

let loop_bounds method_file =
  let file = open_in method_file in
  let lexbuf = Lexing.from_channel file in
  let blocks = parse_with_error lexbuf method_file in
  let bounds = get_bounds blocks in 
  let () = close_in file in
  bounds

let get_bounds () = 
  let files_path = "files_to_analyse/" in 
  let method_files_list = Sys.readdir files_path in 
  let method_bounds = Hashtbl.create (Array.length method_files_list) in
  let () = Array.iter (fun file_name -> let bounds = loop_bounds (String.concat files_path [""; file_name]) in 
  if (Hashtbl.length bounds)!=0 then (Hashtbl.add method_bounds file_name bounds))  method_files_list   in
  method_bounds

  