
open String
exception Cyclic of string

let _ = Sys.command "./prepare.sh"
   
let model_file = "resources/model.txt"
let method_files = "resources/method_files/"
let cg_file = "resources/cg.txt"
(*Loads*)
let methods_bounds = Bounds.get_bounds()

(**
let () = Hashtbl.iter (fun x a -> print_string x; 
Hashtbl.iter ( fun x1 v -> print_endline x1; print_int v) a
) methods_bounds  
*)

let model = Load_model.Load.load_model model_file

let method_files_list = Sys.readdir method_files

let energy_per_method = Hashtbl.create (Array.length method_files_list)

let rec read_file ch = match input_line ch with
    | x -> x ::(read_file ch)
    | exception End_of_file -> []

let contains s1 s2 =
  let re = Str.regexp_string s2
  in
      try ignore (Str.search_forward re s1 0); true
      with Not_found -> false

(*means that have a labal1: (loop)*)
let rec inst_value line model =
  if (contains line ": if" && not (contains line "null")) then 0.0 else 
  match model with
  | [] -> 1.0
  | x::m -> if (contains line (fst x)) then (snd x) else  (inst_value line m) 

(*get the first element of the string*)
let get_loop_bound s bounds = 
  let lb = trim (List.hd (Str.split (Str.regexp ":") s)) in
  try Hashtbl.find bounds lb with Not_found -> 1 

let rec apply_model method_name lines times in_loop=
match lines,in_loop with
| l::ls,false -> 
  let energy_inst = inst_value l model in
  if (energy_inst = 0.0 ) then 
    apply_model method_name ls (get_loop_bound l (Hashtbl.find methods_bounds method_name)) true 
  else
    Float.add energy_inst (apply_model method_name ls 1 false)

| l::ls,true -> if (contains l "goto") then (apply_model method_name ls 1 false) else
                Float.add (Float.mul (float times) (inst_value l model) )  (apply_model method_name ls 1 false)
| [],_ -> 0.0


let () =  
   Array.iter (
    fun method_file_name -> let file_path = (String.concat method_files [""; method_file_name]) in
    let method_name = Filename.remove_extension method_file_name in
    let file_channel = open_in file_path in
    let () = Hashtbl.add energy_per_method method_name (apply_model method_file_name (read_file (file_channel)) 1 false) in
    close_in file_channel    
    ) method_files_list


(*let () = Hashtbl.iter (fun x a -> print_string x; print_float a) energy_per_method  
*)

(*put the weights in the cg*)
let edges = 
  let cg_temp = Load_cg.Load.load_cg cg_file in
  List.map (fun edge ->  
    let edge_weight = try Hashtbl.find energy_per_method (snd edge) with Not_found -> 1.0  in
    ((fst edge),(snd edge), (Float.mul edge_weight (-1.0))))cg_temp

let get_fst (s1,_,_) = s1 
let get_snd (_,s2,_) = s2 
let get_trd (_,_,v) = v 

(*
let () = List.iter (fun edge ->  print_string (get_fst edge); print_string (get_snd edge); print_float (get_trd edge); print_endline"" )cg  
*)

let successors n =
  let matching (s,_,_) = s = n in
  List.map get_snd (List.filter matching edges);;

let anteccessors n =
  let matching (_,s,_) = s = n in
  List.map get_fst (List.filter matching edges);;

let successors_edges n = 
  let matching (s,_,_) = s = n in
  List.filter matching edges;;

let tsort seed =
  let rec sort path visited = function
      [] -> visited
    | n::nodes ->
      if List.mem n path then raise (Cyclic n) else
      let v = if List.mem n visited then visited else
      n :: sort (n::path) visited (successors n)
      in sort path v nodes
    in
    sort [] [] [seed]      
let entry_node =  get_fst (List.hd edges)
let topologicalOrder = tsort entry_node
let cg_paths_weights =  Hashtbl.create (List.length topologicalOrder)

(*shortest path(negative values)*)
let () = 
  let () = Hashtbl.add cg_paths_weights entry_node 0.0 in
  let () = List.iter (fun node -> 
    (List.iter (fun edge -> 
      let edge_to = get_snd edge in
      let new_weight = Float.add (Hashtbl.find cg_paths_weights node)  (get_trd edge) in 
       try let past = (Hashtbl.find cg_paths_weights edge_to) in 
      Hashtbl.replace cg_paths_weights edge_to (Float.min past new_weight) with Not_found -> 
        Hashtbl.add cg_paths_weights edge_to new_weight 
    ) (successors_edges node)
  )
  ) topologicalOrder
      in
      Hashtbl.iter  (fun x a0 -> Hashtbl.replace cg_paths_weights x (Float.mul a0 (-1.0))) cg_paths_weights

(*let () = Hashtbl.iter  (fun x a0 -> print_string x; print_float a0) cg_paths_weights*)

let heaviest node_list = 
  List.fold_left (
    fun x y ->  if (Hashtbl.find cg_paths_weights x) < (Hashtbl.find cg_paths_weights y) then y else x
    ) (List.hd node_list) node_list

let rec step_back visited = function
    [] -> visited
  | n::nodes -> step_back ((heaviest (n::nodes))::visited) (anteccessors n)

let () = 
  let final_node = heaviest topologicalOrder in
  let () = Printf.printf " Initial" in
  let () = List.iter (fun name -> Printf.printf "==> %s\n" name) (step_back [] [final_node]) in 
  let () = Printf.printf "\ntotal path weight : %f\n" (Hashtbl.find cg_paths_weights final_node) in 
  Printf.printf "\ntime, in seconds, used by the program: %f\n" (Sys.time())
