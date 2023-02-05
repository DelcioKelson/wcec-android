type ident = string
type const = int

type baop =
  | Badd | Bsub | Bmul | Bdiv | Bmod    (* + - * // % *)

type cmp = 
| Beq | Bneq | Blt | Ble | Bgt | Bge  (* Compara��o estrural:  == != < <= > >= *)

type expr =
  | Ecst of const
  | Eident of ident
  | Ebinop of baop * expr * expr

type cond = 
  | Cmpl of cmp * ident * expr
  | Cmpr of cmp * expr  * ident


and stmt =
  | Sgoto of ident * cond * stmt
  | Sskip
  | Sassign of ident * expr
  | Sblock of stmt list
