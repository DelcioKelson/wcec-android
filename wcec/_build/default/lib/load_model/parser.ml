
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VERTICALBAR
    | STRING of (
# 5 "lib/load_model/parser.mly"
       (string)
# 16 "lib/load_model/parser.ml"
  )
    | FLOAT of (
# 6 "lib/load_model/parser.mly"
       (float)
# 21 "lib/load_model/parser.ml"
  )
    | EOF
  
end

include MenhirBasics

# 1 "lib/load_model/parser.mly"
  
  open Ast

# 33 "lib/load_model/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_file) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: file. *)

  | MenhirState06 : (('s, _menhir_box_file) _menhir_cell1_stmt, _menhir_box_file) _menhir_state
    (** State 06.
        Stack shape : stmt.
        Start symbol: file. *)


and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and _menhir_box_file = 
  | MenhirBox_file of (Ast.stmt) [@@unboxed]

let _menhir_action_1 =
  fun b ->
    (
# 18 "lib/load_model/parser.mly"
                              ( Sline b )
# 58 "lib/load_model/parser.ml"
     : (Ast.stmt))

let _menhir_action_2 =
  fun x ->
    (
# 218 "<standard.mly>"
    ( [ x ] )
# 66 "lib/load_model/parser.ml"
     : (Ast.stmt list))

let _menhir_action_3 =
  fun x xs ->
    (
# 220 "<standard.mly>"
    ( x :: xs )
# 74 "lib/load_model/parser.ml"
     : (Ast.stmt list))

let _menhir_action_4 =
  fun inst p t ->
    (
# 23 "lib/load_model/parser.mly"
        (Inst (inst , p,t) )
# 82 "lib/load_model/parser.ml"
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
  
  let rec _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let b = _v in
      let _v = _menhir_action_1 b in
      MenhirBox_file _v
  
  let rec _menhir_goto_nonempty_list_stmt_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_08 _menhir_stack _v
      | MenhirState06 ->
          _menhir_run_07 _menhir_stack _v
  
  and _menhir_run_07 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_stmt -> _ -> _menhir_box_file =
    fun _menhir_stack _v ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_3 x xs in
      _menhir_goto_nonempty_list_stmt_ _menhir_stack _v _menhir_s
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VERTICALBAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FLOAT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VERTICALBAR ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | FLOAT _v_1 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let (t, p, inst) = (_v_1, _v_0, _v) in
                      let _v = _menhir_action_4 inst p t in
                      (match (_tok : MenhirBasics.token) with
                      | STRING _v_0 ->
                          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
                          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState06
                      | EOF ->
                          let x = _v in
                          let _v = _menhir_action_2 x in
                          _menhir_goto_nonempty_list_stmt_ _menhir_stack _v _menhir_s
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | _ ->
          _eRR ()
  
end

let file =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_file v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
