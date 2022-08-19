open AST

type mem = const array

let read x m = m.(x)

let write x n m = 
  let nm = Array.copy m in
  nm.(x) <- n;
  nm

type state = label * mem


let binop o v1 v2 = 
  match o with
  | Badd -> v1 + v2
  | Bsub -> v1 - v2 
  | Bmul-> v1 * v2 

 
let rec sem_expr e m = 
  match e with
  | Esct n -> n
  | Evar x -> read x m
  | Ebop (o, e0, e1) ->
    binop o 
        (sem_expr e0 m)
        (sem_expr e1 m)

let relop c v0 v1 = 
  match c with
  | Cinfeq -> v0 <= v1
  | Csup -> v0 >v1

let sem_cond (c, x, n) m = 
  relop c (read x m) n

let rec sem_com (l, c) m = 
  match c with
  | Cskip -> m 
  | Cseq (c0, c1) -> sem_com c1 ( sem_com c0 m)
  | Cassign (x, e) -> write x (sem_expr e m) m
  | Cinput x -> write x (read_int()) m
  | Cif (b, c0, c1) ->
      if (sem_cond b m) then (sem_com c0 m)
      else sem_com c1 m 
  | Cwhile (b, c) ->
    if sem_cond b m then sem_com (l, Cwhile (b, c)) (sem_com c m)
    else m