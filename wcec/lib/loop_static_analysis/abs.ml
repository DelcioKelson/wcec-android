(*the condition operations are translated in reverse in jimple. eg: '==' is translated to '!=' *
 Thus, is cneg is applied in reverse*)
open Ast
exception Varible of string

type val_abs = 
  | Abot
  | Ainter of int * int
  | Aposinf of int
  | Aneginf of int 
  | Anegposinf

type side =
  | R
  | L
  
 (*global complete variables*)
 
let binop o v1 v2 = 
 match o with
 | Badd -> v1 + v2
 | Bsub -> v1 - v2 
 | Bmul-> v1 * v2 
 | Bdiv -> v1 / v2
 | _ -> 0

let rec sem_expr e = 
  match e with
  | Ecst n -> n
  | Eident _ -> 20
  | Ebinop (o, e0, e1) ->
    binop o 
        (sem_expr e0)
        (sem_expr e1) 
 
 let val_bot = Abot

 let read var m = try Hashtbl.find m var with Not_found -> Anegposinf
 
let write var abs_value m =
  let ctx' = Hashtbl.copy m in  
  let () = Hashtbl.replace ctx' var abs_value in
  ctx'
        
let val_cst n = Ainter (n,n)

let incl_interval a0 a1 =
  match a0,a1 with
  | Ainter (x1,x2),Ainter (y1,y2) -> x1>y1 && x2<y2 
  | Aneginf x, Aneginf y -> x<y
  | Aposinf x, Aposinf y -> x>y
  | _ ,_ -> false
 
let val_incl a0 a1 = a0 = 
  Abot || a1=Anegposinf || incl_interval a0 a1 || a0 = a1
 
 (*over aproximate the effect condition tests*)
let val_sat side o n v = 
  match side, o, v with
  |_,_,Abot -> Abot
  |_, Beq,_ -> Ainter (n,n)
  |_, Bneq, Ainter (x1,x2) -> if x1<=n && x2>=n then Abot else Ainter(x1,x2) 
  |_, Bneq, Aposinf x -> if x>=n then Abot else Aposinf x
  |_, Bneq, Aneginf x -> if x<=n then Abot else Aneginf x
  |_, Bneq, Anegposinf ->  Abot

  |R, Bgt, Ainter (x1,x2) |R, Bge, Ainter (x1,x2) -> if x2<n then Abot 
    else if x1 <= n && n<=x2 then Ainter(n,x2) else v
  |R, Bgt, Aposinf x  |R, Bge, Aposinf x -> if x<n then Abot else Ainter(x,n)
  |R, Bgt, Aneginf x  |R, Bge, Aneginf x -> if x>n then Abot else Ainter(n,x)
  |R, Bgt, Anegposinf |R, Bge, Anegposinf -> Aposinf n

  |R, Blt, Ainter (x1,x2) |R, Ble , Ainter (x1,x2) -> if x1>n  then Abot 
      else if x1 <= n && n<=x2 then Ainter(x1,n) else v
  |R, Blt, Aposinf x      |R, Ble, Aposinf x-> if x>n then Abot else Ainter(x,n)
  |R, Blt, Aneginf x      |R, Ble, Aneginf x -> if x<n then Abot else Ainter(n,x)
  |R, Blt, Anegposinf     |R, Ble, Anegposinf ->  Aneginf (n)

  |L, Blt , Ainter (x1,x2) |L, Ble, Ainter (x1,x2) -> if x2<n then Abot 
    else if x1 <= n && n<=x2 then Ainter(n,x2) else v
  |L, Blt, Aposinf x      |L, Ble, Aposinf x -> if x<n then Abot else Ainter(x,n)
  |L, Blt, Aneginf x      |L, Ble, Aneginf x -> if x>n then Abot else Ainter(n,x)
  |L, Blt, Anegposinf     |L, Ble , Anegposinf -> Aposinf n

  |L, Bgt, Ainter (x1,x2) |L, Bge , Ainter (x1,x2) -> if x1>n  then Abot 
      else if x1 <= n && n<=x2 then Ainter(x1,n) else v
  |L, Bgt, Aposinf x  |L, Bge, Aposinf x-> if x>n then Abot else Ainter(x,n)
  |L, Bgt, Aneginf x  |L, Bge, Aneginf x -> if x<n then Abot else Ainter(n,x)
  |L, Bgt, Anegposinf |L, Bge, Anegposinf ->  Aneginf (n)
  
let val_join a0 a1 = 
  match a0,a1 with
  | Abot, a | a, Abot -> a
  | Anegposinf, _ | _, Anegposinf | Aneginf _ ,Aposinf _ | Aposinf _, Aneginf _-> Anegposinf
  | (Aposinf x), (Ainter (y1 , y2)) | (Ainter (y1 , y2)),(Aposinf x)  -> if x>y1 then Aposinf y1 else Aposinf x
  | (Aneginf x), (Ainter (y1 , y2)) | (Ainter (y1 , y2)),(Aneginf x)  -> if x<y1 then Aposinf y1 else Aposinf x
  | (Ainter (x1,x2)), (Ainter (y1 , y2)) -> 
      if x1<=y1 && x2 >= y2 then Ainter(x1,x2) else Ainter(y1,y2)
  | Aneginf x, Aneginf y -> if x<y then Aneginf y else Aneginf x
  | Aposinf x, Aposinf y -> if x>y then Aposinf y else Aposinf x
 
   
 let val_binop o v0 v1 =
   match o,v0,v1 with
   | _, Abot,_ | _,_,Abot -> Abot
   | Badd, Ainter(x1,x2), Ainter(y1,y2) -> Ainter (x1+y1,x2+y2)
   | Badd, Ainter(x1,x2), Aneginf y | Badd ,Aneginf y, Ainter (x1,x2) -> Aneginf (y+x2) 
   | Badd, Ainter(x1,x2), Aposinf x | Badd ,Aposinf x, Ainter (x1,x2) -> Aposinf (x1+x) 
   | Badd, Aposinf x, Aposinf y ->  Aposinf (x+y)
   | Badd, Aneginf x, Aneginf y  -> Aneginf (x+y)
   | Badd, Aposinf _, Aneginf _ | Badd, Aneginf _, Aposinf _  -> Anegposinf

   | Bsub, Ainter(x1,x2), Ainter(y1,y2) -> Ainter (x1-y2,x2-y1)
   | Bsub, Ainter(x1,x2), Aneginf y -> Aposinf (x1-y) 
   | Bsub, Aneginf y, Ainter(x1,x2) -> Aneginf (y-x1) 
   | Bsub, Ainter(x1,x2), Aposinf y -> Abot 
   | Bsub, Aposinf y, Ainter(x1,x2) -> Aposinf (y-x2) 
   | Bsub, Aposinf x, Aposinf y | Bsub, Aposinf x, Aneginf y  -> Anegposinf
   
   | Bsub, Aneginf x, Aneginf y  -> Anegposinf (*TODO*)
   | Bsub, Aneginf x, Aposinf y  -> Anegposinf (*TODO*)

   | Bmul, Ainter(x1,x2), Ainter(y1,y2) -> 
    Ainter (
    List.fold_left (fun x y  -> min x y) max_int [x1*y1; x1*y2;x2*y1;x2*y2;x1*y1], 
    List.fold_left (fun x y  -> max x y) min_int [x1*y1; x1*y2;x2*y1;x2*y2;x1*y1])
   
   | Bmul, Ainter(x,x2), Aneginf y | Bmul, Aneginf y, Ainter (x,x2)  -> Anegposinf 
   | Bmul ,Aneginf x, Aneginf y  | Bmul, Aneginf x, Aposinf y | Bmul, Aposinf y, Aneginf x  -> Anegposinf 
 
   | Bmul, Ainter(x,x2), Aposinf y | Bmul, Aposinf y, Ainter(x,x2) -> Aposinf (x*y)
   | Bmul, Aposinf x, Aposinf y -> Aposinf (x*y)

   | _, _, Anegposinf | _, Anegposinf , _ | _ ,_ ,_-> Anegposinf


let nr_bot aenv = 
Hashtbl.iter  (fun x a0 ->
  Hashtbl.replace aenv x (val_join a0 Abot)) aenv;
  aenv
 
 let nr_is_bot aenv = 
   let r = ref false in 
   Hashtbl.iter (fun x a -> r:= !r && a = val_bot) aenv;
     !r
 
 let nr_is_le aenv0 aenv1 =
   let r = ref true in 
   Hashtbl.iter
     (fun x a0 -> r:= !r && val_incl a0 (read x aenv1)) aenv0;
     !r
 
 let nr_join aenv0 aenv1 =
   Hashtbl.iter  (fun x a0 ->
     Hashtbl.replace aenv0 x (val_join a0 (read x aenv1))) aenv0
 
let rec ai_expr e aenv = 
  match e with
  | Ecst n -> val_cst n 
  | Eident x -> read x aenv
  | Ebinop (o ,e0, e1) ->
      val_binop o (ai_expr e0 aenv) (ai_expr e1 aenv)

 let ai_cond cond aenv= 
   match cond with
   | Cmpl (cmp, id,e)  -> let av = val_sat L cmp (sem_expr e) (read id aenv) in
     if av = val_bot then nr_bot aenv
     else write id av aenv
   | Cmpr (cmp,e,id) -> let av = val_sat R cmp (sem_expr e) (read id aenv) in
     if av = val_bot then nr_bot aenv
     else write id av aenv
   
 let cneg cond = 
   match cond with
   | Cmpl (Beq, id,e) -> Cmpl (Bneq, id,e)
   | Cmpl (Bneq, id,e) -> Cmpl (Beq, id,e)
   | Cmpl (Blt, id,e) -> Cmpl (Bge, id,e)
   | Cmpl (Bge, id,e) -> Cmpl (Blt, id,e)
   | Cmpl (Ble, id,e) -> Cmpl (Bgt, id,e)
   | Cmpl (Bgt, id,e) -> Cmpl (Ble, id,e)
 
   | Cmpr (Beq, id,e) -> Cmpr (Bneq, id,e)
   | Cmpr (Bneq, id,e)-> Cmpr (Beq, id,e)
   | Cmpr (Blt, id,e) -> Cmpr (Bge, id,e)
   | Cmpr (Bge, id,e) -> Cmpr (Blt, id,e)
   | Cmpr (Ble, id,e) -> Cmpr (Bgt, id,e)
   | Cmpr (Bgt, id,e) -> Cmpr (Ble, id,e)
 
let widening a0 a1 = 
  match a0,a1 with
  | Ainter (x1,x2),Ainter(y1,y2)  -> 
    if  x1<=y1 && x2>=y2 then Ainter(x1,x2)
    else if x1<=y1 && x2<y2 then Aposinf x1
    else if x1<y1 && x2>=y2  then Aneginf x2
    else Anegposinf
  | Ainter (x1, x2) , Aposinf y -> if y>x1 then Aposinf x1 else Anegposinf
  | Ainter (x1, x2) , Aneginf y -> if y<x1 then Aneginf x1 else Anegposinf
  | Aneginf y ,Ainter (x1, x2) -> if y>x1 then Aneginf y else Anegposinf
  | Aposinf y ,Ainter (x1, x2) -> if y<x1 then Aposinf y else Anegposinf
  | _, Anegposinf | Anegposinf, _  | Aneginf _ , Aposinf _ | Aposinf _,Aneginf _ -> Anegposinf
  | Abot, _ | _, Abot -> Abot
  | Aneginf x, Aneginf y -> if x>y then Aneginf x else Anegposinf
  | Aposinf x, Aposinf y -> if x <y then Aposinf x else Anegposinf
  
let widening_all aenv0 aenv1 = 
  Hashtbl.iter  (fun x a0 ->
    Hashtbl.replace aenv0 x (widening a0 (read x aenv1))) aenv0;
    aenv0  
 
let rec abs_iter f a = 
  let anext = f a in 
  if nr_is_le anext a then a
  else abs_iter f (widening_all a anext)
 
   (* Aux fun's loop bound*)
let get_id_cmp cond =
  match cond with
  | Cmpr (_,_,id) | Cmpl (_,id,_) -> id 
 
let rec total_increments id s  =
match s with
| Sassign (id1,e) -> if id = id1 then (sem_expr e) else 0
| Sblock(s1::sl) ->  (total_increments id s1) + (total_increments id (Sblock sl)) 
| Sblock([]) | _ -> 0
 
let rec number_acurr x1 x2 total_inc mod_result = 
  if x1 = x2 then 0 else 
  if ((x1 mod total_inc) = mod_result) then (1 + (number_acurr (x1+1) x2 total_inc mod_result )) 
  else (number_acurr (x1+1) x2 total_inc mod_result ) 
 
 let calc_loop_bound aenv_abs s start_value id =
     let id_abs_value = read id aenv_abs in
     let total_ins = total_increments id s in
     match id_abs_value with
     | Ainter(x1,x2) -> number_acurr x1 x2 (total_ins) (start_value mod total_ins)
     | _ -> max_int

(*static analysis*)
let rec ai_stmt  s aenv_abs loop_bounds = 
   if nr_is_bot aenv_abs then aenv_abs
   else 
     match s with
     | Sassign (x,e) -> write x (ai_expr e aenv_abs) aenv_abs
     | Sblock([]) | Sskip -> aenv_abs
     | Sblock (s1::sl) -> ai_stmt (Sblock sl) (ai_stmt s1 aenv_abs loop_bounds) loop_bounds
     | Sgoto (label,b, s) ->
       let id_cmp = get_id_cmp b in
       let start_value = read id_cmp aenv_abs in
       let f_loop = fun a -> ai_stmt s (ai_cond (cneg b) a) loop_bounds in
       let aenv = ai_cond b (abs_iter f_loop aenv_abs) in
       let () = match start_value with
       | Ainter(x,y) -> 
          Hashtbl.add loop_bounds label (calc_loop_bound aenv s (if x=y then x else (x-y)) id_cmp )
       | _ -> ()  in
       aenv 

let get_bounds s = 
  let loop_bounds = Hashtbl.create 10 in
  let aenv = Hashtbl.create 1000 in
  let _ = ai_stmt s aenv loop_bounds in
  loop_bounds