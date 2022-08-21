
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VERTICALBAR
    | STRING of (
# 5 "parser.mly"
       (string)
# 16 "parser.ml"
  )
    | FLOAT of (
# 6 "parser.mly"
       (float)
# 21 "parser.ml"
  )
    | EOF
  
end

include MenhirBasics

# 1 "parser.mly"
  
  open Ast

# 33 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState0 : ('s, _menhir_box_file) _menhir_state
    (** State 0.
        Stack shape : .
        Start symbol: file. *)

  | MenhirState4 : (('s, _menhir_box_file) _menhir_cell1_stmt, _menhir_box_file) _menhir_state
    (** State 4.
        Stack shape : stmt.
        Start symbol: file. *)


and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and _menhir_box_file = 
  | MenhirBox_file of (Ast.stmt) [@@unboxed]

let _menhir_action_1 =
  fun b ->
    (
# 18 "parser.mly"
                              ( Sline b )
# 58 "parser.ml"
     : (Ast.stmt))

let _menhir_action_2 =
  fun x ->
    (
# 218 "<standard.mly>"
    ( [ x ] )
# 66 "parser.ml"
     : (Ast.stmt list))

let _menhir_action_3 =
  fun x xs ->
    (
# 220 "<standard.mly>"
    ( x :: xs )
# 74 "parser.ml"
     : (Ast.stmt list))

let _menhir_action_4 =
  fun inst v ->
    (
# 23 "parser.mly"
        (Inst (inst , v) )
# 82 "parser.ml"
     : (Ast.stmt))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | FLOAT _ ->
        "FLOAT"
    | STRING _ ->
        "STRING"
    | VERTICALBAR ->
        "VERTICALBAR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_6 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let b = _v in
      let _v = _menhir_action_1 b in
      MenhirBox_file _v
  
  let rec _menhir_goto_nonempty_list_stmt_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState0 ->
          _menhir_run_6 _menhir_stack _v
      | MenhirState4 ->
          _menhir_run_5 _menhir_stack _v
  
  and _menhir_run_5 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_stmt -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_3 x xs in
      _menhir_goto_nonempty_list_stmt_ _menhir_stack _v _menhir_s
  
  let rec _menhir_run_1 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VERTICALBAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FLOAT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (v, inst) = (_v_0, _v) in
              let _v = _menhir_action_4 inst v in
              (match (_tok : MenhirBasics.token) with
              | STRING _v_0 ->
                  let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
                  _menhir_run_1 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState4
              | EOF ->
                  let x = _v in
                  let _v = _menhir_action_2 x in
                  _menhir_goto_nonempty_list_stmt_ _menhir_stack _v _menhir_s
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
