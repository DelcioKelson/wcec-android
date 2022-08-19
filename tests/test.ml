open Node_parser
open Lexing

type expr =
    | Const of int
    | Add   of expr * expr
    | Mul   of expr * expr

  (** Antes de escrever um analisador sintÃ¡ctico, escrevemos um pretty-printer *)

  open Format

  (* para comeÃ§ar na base, com parÃªntesis em todo o lado *)
  let rec print fmt = function
    | Const n      -> fprintf fmt "%d" n
    | Add (e1, e2) -> fprintf fmt "(%a + %a)" print e1 print e2
    | Mul (e1, e2) -> fprintf fmt "(%a * %a)" print e1 print e2

  let rec print fmt = function
    | Const n      -> fprintf fmt "%d" n
    | Add (e1, e2) -> fprintf fmt "(@[%a +@ %a@])" print e1 print e2
    | Mul (e1, e2) -> fprintf fmt "(@[%a *@ %a@])" print e1 print e2

  (* e depois, mais subtilmente, com parÃªntesis somente onde Ã© necessÃ¡rio *)
  let rec print_expr fmt = function
    | Add (e1, e2) -> fprintf fmt "%a +@ %a" print_expr e1 print_expr e2
    | e            -> print_term fmt e

  and print_term fmt = function
    | Mul (e1, e2) -> fprintf fmt "%a *@ %a" print_term e1 print_term e2
    | e            -> print_factor fmt e

  and print_factor fmt = function
    | Const n -> fprintf fmt "%d" n
    | e       -> fprintf fmt "(@[%a@])" print_expr e

  (* tests *)
  let e = Add (Const 2, Mul (Const 8, Const 5))
  let e = Add (e, Mul (e, e))
  let e = Add (e, Mul (e, e))
  let e = Add (e, Mul (e, e))
  let e = Add (e, Mul (e, e))
  let () = printf "e = @[%a@]@." print e
  let () = printf "e = @[%a@]@." print_expr e

  (** AnÃ¡lise sintÃ¡ctica (da entrada standard) *)

  (* funÃ§Ãµes auxiliares para a leitura dos lexemas *)

  let lb = from_channel stdin
  let t = ref EOF                  (* o proximo lexema por analisar *)
  let next () = t := token lb
  let () = next ()                 (* ler o primeiro lexema *)

  (* o pretty-printer ajudu-nos dinstinguido as somas, os produtos e
     os factores

     escrevemos assim trÃªs funÃ§Ãµes de anÃ¡lise sintÃ¡cticas,
     parse_expr, parse_term e parse_factor *)

  let error () = failwith "syntax error"

  let rec parse_expr () =
    let e = parse_term () in
    if !t = PLUS then begin next (); Add (e, parse_expr ()) end else e
  and parse_term () =
    let e = parse_factor () in
    if !t = TIMES then begin next (); Mul (e, parse_term ()) end else e
  and parse_factor () = match !t with
    | CONST n -> next (); Const n
    | LEFTPAR -> next ();
        let e = parse_expr () in if !t <> RIGHTPAR then error (); next (); e
    | _ -> error ()

  let e = parse_expr ()
  let () = if !t <> EOF then error ()

  let () = printf "e = @[%a@]@." print e
  let () = printf "e = @[%a@]@." print_expr e
