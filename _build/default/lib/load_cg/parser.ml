
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | STRING of (
# 5 "lib/load_cg/parser.mly"
       (string)
# 15 "lib/load_cg/parser.ml"
  )
    | EQUAL
    | EOF
  
end

include MenhirBasics

# 1 "lib/load_cg/parser.mly"
  
  open Ast

# 28 "lib/load_cg/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState0 : ('s, _menhir_box_file) _menhir_state
    (** State 0.
        Stack shape : .
        Start symbol: file. *)

  | MenhirState7 : (('s, _menhir_box_file) _menhir_cell1_edge, _menhir_box_file) _menhir_state
    (** State 7.
        Stack shape : edge.
        Start symbol: file. *)


and ('s, 'r) _menhir_cell1_edge = 
  | MenhirCell1_edge of 's * ('s, 'r) _menhir_state * (Ast.edge)

and _menhir_box_file = 
  | MenhirBox_file of (Ast.edge) [@@unboxed]

let _menhir_action_1 =
  fun from_node to_node ->
    (
# 22 "lib/load_cg/parser.mly"
        (Edge (from_node , to_node) )
# 53 "lib/load_cg/parser.ml"
     : (Ast.edge))

let _menhir_action_2 =
  fun cg ->
    (
# 17 "lib/load_cg/parser.mly"
                               ( Cg cg )
# 61 "lib/load_cg/parser.ml"
     : (Ast.edge))

let _menhir_action_3 =
  fun x ->
    (
# 218 "<standard.mly>"
    ( [ x ] )
# 69 "lib/load_cg/parser.ml"
     : (Ast.edge list))

let _menhir_action_4 =
  fun x xs ->
    (
# 220 "<standard.mly>"
    ( x :: xs )
# 77 "lib/load_cg/parser.ml"
     : (Ast.edge list))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | STRING _ ->
        "STRING"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_4 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let cg = _v in
      let _v = _menhir_action_2 cg in
      MenhirBox_file _v
  
  let rec _menhir_goto_nonempty_list_edge_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState7 ->
          _menhir_run_8 _menhir_stack _v
      | MenhirState0 ->
          _menhir_run_4 _menhir_stack _v
  
  and _menhir_run_8 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_edge -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let MenhirCell1_edge (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_4 x xs in
      _menhir_goto_nonempty_list_edge_ _menhir_stack _v _menhir_s
  
  let rec _menhir_run_1 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (to_node, from_node) = (_v_0, _v) in
              let _v = _menhir_action_1 from_node to_node in
              (match (_tok : MenhirBasics.token) with
              | STRING _v_0 ->
                  let _menhir_stack = MenhirCell1_edge (_menhir_stack, _menhir_s, _v) in
                  _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState7
              | EOF ->
                  let x = _v in
                  let _v = _menhir_action_3 x in
                  _menhir_goto_nonempty_list_edge_ _menhir_stack _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let rec _menhir_run_0 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState0
      | _ ->
          _eRR ()
  
end

let file =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_file v = _menhir_run_0 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
