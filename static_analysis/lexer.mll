{
  open Lexing
  open Parser

  exception SyntaxError of string

  let kwd_tbl = ["goto",GOTO; "if", IF]
  let id_or_kwd s = try List.assoc s kwd_tbl with _ -> IDENT s

}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let ident = letter (letter | digit)*
let integer = ['0'-'9']+
let space = [' ' '\t']

rule token = parse
  | '\n'   {new_line lexbuf; token lexbuf}
  | '"'     {token lexbuf}
  | space+  { token lexbuf }
  | ident as id { id_or_kwd id }
  | ';'     { SEMICOLON }
  | ':'     { COLON }
  | '+'     { PLUS }
  | '-'     { MINUS }
  | '*'     { TIMES }
  | "//"    { DIV }
  | '%'     { MOD }
  | "="     { EQUAL }
  | "=="    { BEQ }
  | "!="    { BNEQ }
  | "<"     { BLT}
  | "<="    { BLE}
  | ">"     { BGT}
  | ">="    { BGE}
  | integer as s { CST (int_of_string s)}
  | eof     { EOF }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
