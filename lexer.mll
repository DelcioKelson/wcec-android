{
  open Lexing
  open Parser

  exception Lexing_error of char

  let kwd_tbl = ["label",LABEL; "goto",GOTO]
  let id_or_kwd s = try List.assoc s kwd_tbl with _ -> IDENT s

}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let ident = letter (letter | digit)*
let integer = ['0'-'9']+
let space = [' ' '\t']
let label = "label" integer

rule token = parse
  | '\n'    { new_line lexbuf; token lexbuf }
  | space+  { token lexbuf }
  | ident as id { id_or_kwd id }
  | "=="    { [Beq] }
  | "!="    { [Bneq] }
  | "<"     { [Blt] }
  | "<="    { [Ble] }
  | ">"     { [Bgt] }
  | ">="    { [Bge] }
  | '('     { [LP] }
  | ')'     { [RP] }
  | '['     { [LSQ] }
  | ']'     { [RSQ] }
  | ','     { [COMMA] }
  | '"'     { [APOST]}
  | ';'     { [COMPOINT]}
  | label   { token lexbuf}
  | integer as s
            { try [CST (Cint (int_of_string s))]
              with _ -> raise (Lexing_error ("constant too large: " ^ s)) }
  | eof     { [EOF] }
  | _ as c  { raise (Lexing_error ("illegal character: " ^ String.make 1 c)) }

and string = parse
  | '"'
      { let s = Buffer.contents string_buffer in
	Buffer.reset string_buffer;
	s }
  | "\\n"
      { Buffer.add_char string_buffer '\n';
	string lexbuf }
  | "\\\""
      { Buffer.add_char string_buffer '"';
	string lexbuf }
  | "label"
      {string lexbuf }
  | _ as c
      { Buffer.add_char string_buffer c;
	string lexbuf }
  | eof
      { raise (Lexing_error "unterminated string") }

{

  let next_token =
    let tokens = Queue.create () in (* próximos tokens por retornar *)
    fun lb ->
      if Queue.is_empty tokens then begin
	let l = next_tokens lb in
	List.iter (fun t -> Queue.add t tokens) l
      end;
      Queue.pop tokens
}
