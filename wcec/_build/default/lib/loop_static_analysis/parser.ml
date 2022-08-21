
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | TIMES
    | PLUS
    | NEWLINE
    | MOD
    | MINUS
    | IF
    | IDENT of (
# 6 "lib/loop_static_analysis/parser.mly"
       (string)
# 21 "lib/loop_static_analysis/parser.ml"
  )
    | GOTO
    | EQUAL
    | EOF
    | DIV
    | CST of (
# 5 "lib/loop_static_analysis/parser.mly"
       (int)
# 30 "lib/loop_static_analysis/parser.ml"
  )
    | COLON
    | BNEQ
    | BLT
    | BLE
    | BGT
    | BGE
    | BEQ
  
end

include MenhirBasics

# 1 "lib/loop_static_analysis/parser.mly"
  
  open Ast

# 48 "lib/loop_static_analysis/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_file) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: file. *)

  | MenhirState02 : (('s, _menhir_box_file) _menhir_cell1_stmt, _menhir_box_file) _menhir_state
    (** State 02.
        Stack shape : stmt.
        Start symbol: file. *)

  | MenhirState05 : (('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 05.
        Stack shape : ident.
        Start symbol: file. *)

  | MenhirState09 : (('s, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 09.
        Stack shape : expr.
        Start symbol: file. *)

  | MenhirState11 : (('s, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 11.
        Stack shape : expr.
        Start symbol: file. *)

  | MenhirState13 : (('s, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 13.
        Stack shape : expr.
        Start symbol: file. *)

  | MenhirState15 : (('s, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 15.
        Stack shape : expr.
        Start symbol: file. *)

  | MenhirState17 : (('s, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 17.
        Stack shape : expr.
        Start symbol: file. *)

  | MenhirState20 : (('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 20.
        Stack shape : ident.
        Start symbol: file. *)

  | MenhirState22 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 22.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState24 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 24.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState26 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 26.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState28 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 28.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState30 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 30.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState32 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 32.
        Stack shape : ident ident.
        Start symbol: file. *)

  | MenhirState35 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 35.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState37 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 37.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState39 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 39.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState41 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 41.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState43 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 43.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState45 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_expr, _menhir_box_file) _menhir_state
    (** State 45.
        Stack shape : ident expr.
        Start symbol: file. *)

  | MenhirState48 : ((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_cond, _menhir_box_file) _menhir_state
    (** State 48.
        Stack shape : ident cond.
        Start symbol: file. *)

  | MenhirState49 : (((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_cond, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_state
    (** State 49.
        Stack shape : ident cond ident.
        Start symbol: file. *)

  | MenhirState51 : ((((('s, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_cond, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_nonempty_list_stmt_, _menhir_box_file) _menhir_state
    (** State 51.
        Stack shape : ident cond ident nonempty_list(stmt).
        Start symbol: file. *)


and ('s, 'r) _menhir_cell1_cond = 
  | MenhirCell1_cond of 's * ('s, 'r) _menhir_state * (Ast.cond)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_ident = 
  | MenhirCell1_ident of 's * ('s, 'r) _menhir_state * (string)

and ('s, 'r) _menhir_cell1_nonempty_list_stmt_ = 
  | MenhirCell1_nonempty_list_stmt_ of 's * ('s, 'r) _menhir_state * (Ast.stmt list)

and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and _menhir_box_file = 
  | MenhirBox_file of (Ast.stmt) [@@unboxed]

let _menhir_action_01 =
  fun e id ->
    (
# 45 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Beq, id, e) )
# 195 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_02 =
  fun e id ->
    (
# 47 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Bneq, id, e) )
# 203 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_03 =
  fun e id ->
    (
# 49 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Beq, id, e) )
# 211 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_04 =
  fun e id ->
    (
# 51 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Blt, id, e) )
# 219 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_05 =
  fun e id ->
    (
# 53 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Ble, id, e) )
# 227 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_06 =
  fun e id ->
    (
# 55 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Bgt, id, e) )
# 235 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_07 =
  fun e id ->
    (
# 57 "lib/loop_static_analysis/parser.mly"
    ( Cmpl (Bge, id, e) )
# 243 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_08 =
  fun e id ->
    (
# 60 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Beq, e, id) )
# 251 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_09 =
  fun e id ->
    (
# 62 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Bneq, e, id) )
# 259 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_10 =
  fun e id ->
    (
# 64 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Beq, e, id) )
# 267 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_11 =
  fun e id ->
    (
# 66 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Blt, e, id) )
# 275 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_12 =
  fun e id ->
    (
# 68 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Ble, e, id) )
# 283 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_13 =
  fun e id ->
    (
# 70 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Bgt, e, id) )
# 291 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_14 =
  fun e id ->
    (
# 72 "lib/loop_static_analysis/parser.mly"
    ( Cmpr (Bge, e, id) )
# 299 "lib/loop_static_analysis/parser.ml"
     : (Ast.cond))

let _menhir_action_15 =
  fun c ->
    (
# 28 "lib/loop_static_analysis/parser.mly"
    ( Ecst c )
# 307 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_16 =
  fun id ->
    (
# 30 "lib/loop_static_analysis/parser.mly"
    ( Eident id )
# 315 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_17 =
  fun e1 e2 ->
    (
# 32 "lib/loop_static_analysis/parser.mly"
    ( Ebinop (Badd, e1, e2) )
# 323 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_18 =
  fun e1 e2 ->
    (
# 34 "lib/loop_static_analysis/parser.mly"
    ( Ebinop (Bsub, e1, e2) )
# 331 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_19 =
  fun e1 e2 ->
    (
# 36 "lib/loop_static_analysis/parser.mly"
    ( Ebinop (Bmul, e1, e2) )
# 339 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_20 =
  fun e1 e2 ->
    (
# 38 "lib/loop_static_analysis/parser.mly"
    ( Ebinop (Bdiv, e1, e2) )
# 347 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_21 =
  fun e1 e2 ->
    (
# 40 "lib/loop_static_analysis/parser.mly"
    ( Ebinop (Bmod, e1, e2) )
# 355 "lib/loop_static_analysis/parser.ml"
     : (Ast.expr))

let _menhir_action_22 =
  fun b ->
    (
# 23 "lib/loop_static_analysis/parser.mly"
                              ( Sblock b )
# 363 "lib/loop_static_analysis/parser.ml"
     : (Ast.stmt))

let _menhir_action_23 =
  fun id ->
    (
# 85 "lib/loop_static_analysis/parser.mly"
             ( id )
# 371 "lib/loop_static_analysis/parser.ml"
     : (string))

let _menhir_action_24 =
  fun x ->
    (
# 218 "<standard.mly>"
    ( [ x ] )
# 379 "lib/loop_static_analysis/parser.ml"
     : (Ast.stmt list))

let _menhir_action_25 =
  fun x xs ->
    (
# 220 "<standard.mly>"
    ( x :: xs )
# 387 "lib/loop_static_analysis/parser.ml"
     : (Ast.stmt list))

let _menhir_action_26 =
  fun e2 id ->
    (
# 77 "lib/loop_static_analysis/parser.mly"
    (Sassign (id,e2) )
# 395 "lib/loop_static_analysis/parser.ml"
     : (Ast.stmt))

let _menhir_action_27 =
  fun c golabel id2 id3 s ->
    (
# 81 "lib/loop_static_analysis/parser.mly"
        (Sgoto (golabel,c,Sblock s) )
# 403 "lib/loop_static_analysis/parser.ml"
     : (Ast.stmt))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | BEQ ->
        "BEQ"
    | BGE ->
        "BGE"
    | BGT ->
        "BGT"
    | BLE ->
        "BLE"
    | BLT ->
        "BLT"
    | BNEQ ->
        "BNEQ"
    | COLON ->
        "COLON"
    | CST _ ->
        "CST"
    | DIV ->
        "DIV"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | GOTO ->
        "GOTO"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | MINUS ->
        "MINUS"
    | MOD ->
        "MOD"
    | NEWLINE ->
        "NEWLINE"
    | PLUS ->
        "PLUS"
    | TIMES ->
        "TIMES"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_53 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _v _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let b = _v in
          let _v = _menhir_action_22 b in
          MenhirBox_file _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_ident (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let id = _v_0 in
                _menhir_action_23 id
              in
              let id = _v_1 in
              let _v = _menhir_action_16 id in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState05 _tok
          | CST _v_3 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let c = _v_3 in
              let _v = _menhir_action_15 c in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState05 _tok
          | _ ->
              _eRR ())
      | COLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IF ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_5 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v_6 =
                    let id = _v_5 in
                    _menhir_action_23 id
                  in
                  (match (_tok : MenhirBasics.token) with
                  | BNEQ ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_7 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_8 =
                            let id = _v_7 in
                            _menhir_action_23 id
                          in
                          let id = _v_8 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
                      | CST _v_10 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_10 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
                      | _ ->
                          _eRR ())
                  | BLT ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_12 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_13 =
                            let id = _v_12 in
                            _menhir_action_23 id
                          in
                          let id = _v_13 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState24 _tok
                      | CST _v_15 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_15 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState24 _tok
                      | _ ->
                          _eRR ())
                  | BLE ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_17 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_18 =
                            let id = _v_17 in
                            _menhir_action_23 id
                          in
                          let id = _v_18 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState26 _tok
                      | CST _v_20 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_20 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState26 _tok
                      | _ ->
                          _eRR ())
                  | BGT ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_22 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_23 =
                            let id = _v_22 in
                            _menhir_action_23 id
                          in
                          let id = _v_23 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
                      | CST _v_25 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_25 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
                      | _ ->
                          _eRR ())
                  | BGE ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_27 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_28 =
                            let id = _v_27 in
                            _menhir_action_23 id
                          in
                          let id = _v_28 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState30 _tok
                      | CST _v_30 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_30 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState30 _tok
                      | _ ->
                          _eRR ())
                  | BEQ ->
                      let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState20, _v_6) in
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | IDENT _v_32 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let _v_33 =
                            let id = _v_32 in
                            _menhir_action_23 id
                          in
                          let id = _v_33 in
                          let _v = _menhir_action_16 id in
                          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState32 _tok
                      | CST _v_35 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let c = _v_35 in
                          let _v = _menhir_action_15 c in
                          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState32 _tok
                      | _ ->
                          _eRR ())
                  | DIV | MINUS | MOD | PLUS | TIMES ->
                      let _v_37 =
                        let id = _v_6 in
                        _menhir_action_16 id
                      in
                      _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v_37 MenhirState20 _tok
                  | _ ->
                      _eRR ())
              | CST _v_38 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let c = _v_38 in
                  let _v = _menhir_action_15 c in
                  _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF | GOTO | IDENT _ ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_26 e2 id in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let id = _v in
            _menhir_action_23 id
          in
          let id = _v in
          let _v = _menhir_action_16 id in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let c = _v in
          let _v = _menhir_action_15 c in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_19 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState20 ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState28 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState26 ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState24 ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState22 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState15 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState13 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState11 ->
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState09 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState05 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_34 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BNEQ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let id = _v_0 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_1, _v) in
              let _v = _menhir_action_09 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BLT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_3 =
                let id = _v_2 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_3, _v) in
              let _v = _menhir_action_11 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BLE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_4 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_5 =
                let id = _v_4 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_5, _v) in
              let _v = _menhir_action_12 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BGT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_6 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_7 =
                let id = _v_6 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_7, _v) in
              let _v = _menhir_action_13 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BGE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_8 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_9 =
                let id = _v_8 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_9, _v) in
              let _v = _menhir_action_14 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | BEQ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_10 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_11 =
                let id = _v_10 in
                _menhir_action_23 id
              in
              let (id, e) = (_v_11, _v) in
              let _v = _menhir_action_08 e id in
              _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let id = _v in
            _menhir_action_23 id
          in
          let id = _v in
          let _v = _menhir_action_16 id in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState11 _tok
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let c = _v in
          let _v = _menhir_action_15 c in
          _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState11 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BEQ | BGE | BGT | BLE | BLT | BNEQ | EOF | GOTO | IDENT _ | MINUS | PLUS ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_17 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let id = _v in
            _menhir_action_23 id
          in
          let id = _v in
          let _v = _menhir_action_16 id in
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let c = _v in
          let _v = _menhir_action_15 c in
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_21 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_15 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let id = _v in
            _menhir_action_23 id
          in
          let id = _v in
          let _v = _menhir_action_16 id in
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let c = _v in
          let _v = _menhir_action_15 c in
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_20 e1 e2 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_expr -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let id = _v in
            _menhir_action_23 id
          in
          let id = _v in
          let _v = _menhir_action_16 id in
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let c = _v in
          let _v = _menhir_action_15 c in
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState17 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BEQ | BGE | BGT | BLE | BLT | BNEQ | EOF | GOTO | IDENT _ | MINUS | PLUS ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_18 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_cond : type  ttv_stack. ((ttv_stack, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_cond (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | GOTO ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let id = _v_0 in
                _menhir_action_23 id
              in
              let _menhir_stack = MenhirCell1_ident (_menhir_stack, MenhirState48, _v_1) in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_2 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_2 in
                  let _v = _menhir_action_23 id in
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState49 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_01 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_07 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_06 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_05 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_04 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_23 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_ident as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GOTO ->
          let MenhirCell1_ident (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_02 e id in
          _menhir_goto_cond _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_23 id in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02 _tok
      | EOF | GOTO ->
          let x = _v in
          let _v = _menhir_action_24 x in
          _menhir_goto_nonempty_list_stmt_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_nonempty_list_stmt_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_file) _menhir_state -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_53 _menhir_stack _v _tok
      | MenhirState49 ->
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState02 ->
          _menhir_run_03 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_50 : type  ttv_stack. (((ttv_stack, _menhir_box_file) _menhir_cell1_ident, _menhir_box_file) _menhir_cell1_cond, _menhir_box_file) _menhir_cell1_ident -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | GOTO ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let id = _v_0 in
                _menhir_action_23 id
              in
              let MenhirCell1_ident (_menhir_stack, _, id2) = _menhir_stack in
              let MenhirCell1_cond (_menhir_stack, _, c) = _menhir_stack in
              let MenhirCell1_ident (_menhir_stack, _menhir_s, golabel) = _menhir_stack in
              let (id3, s) = (_v_1, _v) in
              let _v = _menhir_action_27 c golabel id2 id3 s in
              _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_03 : type  ttv_stack. (ttv_stack, _menhir_box_file) _menhir_cell1_stmt -> _ -> _ -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_25 x xs in
      _menhir_goto_nonempty_list_stmt_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_file =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v in
          let _v = _menhir_action_23 id in
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | _ ->
          _eRR ()
  
end

let file =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_file v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
