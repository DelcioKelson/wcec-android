open Abs
open AST

let aenv = Array.init 5 (fun _ -> Anegposinf)

let n = ai_com (1, Cseq ((0,Cassign (0,Esct 4)),(1, Cwhile((Cinfeq, 4, 0 ), (3,(Cassign (0, Esct 4 ))))))) aenv


let print_abs a = 
  match a with
  | Abot -> print_string "Abot"
  | Ainter (x1,x2) ->   Printf.printf "Ainter: %i: %i\n%!" x1 x2
  | Aposinf x ->   Printf.printf "Aposinf: %i" x
  | Aneginf x ->   Printf.printf "Aneginf %i" x
  | Anegposinf ->   Printf.printf "Anegposinf"

let () = print_abs n.(0)