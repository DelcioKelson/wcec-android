open AST
let read x m = m.(x)

let write x n m = 
  let nm = Array.copy m in
  nm.(x) <- n;
  nm

type val_abs = 
  | Abot
  | Ainter of var * var
  | Aposinf of var
  | Aneginf of var 
  | Anegposinf

type nr_abs = val_abs array

let val_bot = Abot

let val_cst n = Ainter (n,n)

let incl_interval a0 a1 =
  match a0,a1 with
  | Ainter (x1,x2),Ainter (y1,y2) -> x1>y1 && x2<y2 
  | Aneginf x, Aneginf y -> x<y
  | Aposinf x, Aposinf y -> x>y
  | _ ,_ -> false


let val_incl a0 a1 = a0 = 
  Abot || a1=Anegposinf || incl_interval a0 a1 || a0 = a1


let val_sat o n v = 
    match o, v with
   |_,Abot -> Abot 
   | Csup, Ainter (x1,x2) -> if x1>n then Abot 
     else if x1 <= n && n<=x2 then Ainter(x1,n) else v
   | Csup, Aposinf x -> if x>n then Abot else Ainter(x,n)
   | Csup, Aneginf x -> if x<=n then Abot else Ainter(n,x)
   | Csup, Anegposinf ->  Aneginf n
   | Cinfeq, Ainter (x1,x2) -> if x2<=n then Abot 
   else if x1 <= n && n<=x2 then Ainter(n,x2) else v
   | Cinfeq, Aposinf x -> if x<n then Abot else Ainter(x,n)
   | Cinfeq, Aneginf x -> if x>=n then Abot else Ainter(n,x)
   | Cinfeq, Anegposinf -> Aposinf n
   

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
  | _, Aposinf x, Aposinf y -> if x>=y then Aposinf y else Aposinf x
  | _, Aneginf x, Aneginf y -> if x>=y then Aneginf x else Aneginf y
  | _, Anegposinf, _ | _, _, Anegposinf | _, Aposinf _,Aneginf _ |_ ,Aneginf _ , Aposinf _-> Anegposinf
  | _ , Ainter ( x1, x2) ,Aneginf y |_, Aneginf y , Ainter ( x1, x2)  ->  if x1<=y then Aneginf y else Aneginf x2
  | _ , Ainter ( x1, x2) ,Aposinf y |_, Aposinf y , Ainter ( x1, x2)  ->  if x1>=y then Aposinf y else Aposinf x1
  | _ , Ainter ( x1, x2) ,Ainter ( y1, y2)  -> 
    if x1<=y1 && x2 > y2 then Ainter(x1,x2) 
      else if (x1>=y1 && x2 < y2) then Ainter(y1,y2)
      else if (x1<=y1 && x2 < y2) then Ainter(x1,y2)
      else Ainter(y1,x2)

let nr_bot aenv = Array.map(fun _ -> Abot) aenv

let nr_is_bot aenv = 
  Array.exists (fun a -> a = val_bot) aenv

let nr_is_le aenv0 aenv1 =
  let r = ref true in 
  Array.iteri (fun x a0 -> r:= !r && val_incl a0 (read x aenv1)) aenv0;
    !r

let nr_join aenv0 aenv1 = 
  Array.mapi (fun x a0 -> val_join a0 (read x aenv1)) aenv0


let rec ai_expr e aenv = 
  match e with
  | Esct n -> val_cst n 
  | Eident x -> read x aenv
  | Ebinop (o ,e0, e1) ->
      val_binop o (ai_expr e0 aenv) (ai_expr e1 aenv)


let ai_cond (r, x,n) aenv = 
  let av = val_sat r n (read x aenv) in
  if av = val_bot then nr_bot aenv
  else write x av aenv
  

let cneg (r,v,c) = 
  match r with
  | Cinfeq -> (Csup, v,c)
  | Csup -> (Cinfeq, v, c)
  

let widening a0 a1 = 
  match a0,a1 with
  | Ainter (x1,x2),Ainter(y1,y2)  -> 
    if  x1<y1 && 2>=y2 then Ainter(x1,x2)
    else if x1>=y1 && x2<y2 then Anegposinf
    else if x1>=y1 then Aneginf x2
    else Aposinf x1
  | Ainter (x1, x2) , Aposinf y -> if y>x1 then Aposinf x1 else Anegposinf
  | Ainter (x1, x2) , Aneginf y -> if y<x1 then Aneginf x1 else Anegposinf
  | Aneginf y ,Ainter (x1, x2) -> if y>x1 then Aneginf y else Anegposinf
  | Aposinf y ,Ainter (x1, x2) -> if y<x1 then Aposinf y else Anegposinf
  | _, Anegposinf | Anegposinf, _  | Aneginf _ , Aposinf _ | Aposinf _,Aneginf _ -> Anegposinf
  | Abot, _ | _, Abot -> Abot
  | Aneginf x, Aneginf y -> if x>y then Aneginf x else Anegposinf
  | Aposinf x, Aposinf y -> if x <y then Aposinf x else Anegposinf
  
  let widening_all aenv0 aenv1 = 
    Array.mapi (fun x a0 -> widening a0 (read x aenv1)) aenv0
  

let rec abs_iter f a = 
  let anext = f a in 
  if nr_is_le anext a then a
  else abs_iter f (widening_all a anext)

let rec ai_com (l, c) aenv = 
  if nr_is_bot aenv then aenv
  else 
    match c with
    | Sassign (x,e) -> write x (ai_expr e aenv) aenv
    | Sgoto (b, s) ->
      let f_loop = fun a -> ai_com s (ai_cond b a) in
      ai_cond (cneg b) (abs_iter f_loop aenv)