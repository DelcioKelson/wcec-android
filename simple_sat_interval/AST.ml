type label = int
type const = int
type var = int
type bop = Badd | Bsub | Bmul
type rel = Cinfeq | Csup
type expr = 
  | Esct of const
  | Evar of var
  | Ebop of bop * expr * expr
type cond =
  rel * var * const
type command = 
  | Cskip
  | Cseq of com * com
  | Cassign of var * expr
  | Cinput of var
  | Cif of cond * com * com
  | Cwhile of cond * com
and com = 
  label * command


