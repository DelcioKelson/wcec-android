
open String
(*let status = Sys.command "./prepare.sh"*)
let model_file = "resources/model.txt"

let method_files = "resources/method_files/"

let cg_file = "resources/cg.txt"

exception Cyclic of string

(*Loads*)
let methods_bounds = Bounds.get_bounds()

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


let get_value line =  
  let r = ref 1.0 in 
  let () = Hashtbl.iter (fun x y -> if (contains line x) then (r := y)
   else if (contains line ":") then r:=0.0)  model in
  !r

(*get the first element of the string*)
let get_loop_bound s bounds = 
  let lb = trim (List.hd (Str.split (Str.regexp ":") s)) in
  Hashtbl.find bounds lb 

let rec apply_model method_name lines times in_loop= 
  match lines with
  | l::ls -> 
    let energy_inst = Float.mul (get_value l) (float times) in
    if (energy_inst = 0.0 ) && in_loop then apply_model method_name ls 1 false 
    else if (energy_inst = 0.0 ) then apply_model method_name ls (get_loop_bound l (Hashtbl.find methods_bounds method_name)) true
    else Float.add energy_inst  (apply_model method_name ls times in_loop) 
  | [] -> 0.0


let () =  
   Array.iter (
    fun method_file_name -> let file_path = (String.concat method_files [""; method_file_name]) in
    let method_name = Filename.remove_extension method_file_name in
    Hashtbl.add energy_per_method method_name (apply_model method_file_name (read_file (open_in file_path)) 1 false)
    
    ) method_files_list


(*let () = Hashtbl.iter (fun x a -> print_string x; print_float a) energy_per_method  
*)

(*put the weights in the cg*)
let edges = 
  let cg_temp = Load_cg.Load.load_cg cg_file in
  let rec set_cg_weights cg_t = 
    match cg_t with
    | edge::l -> 
      let edge_weight = try Hashtbl.find energy_per_method (snd edge) with Not_found -> 1.0  in
      ((fst edge),(snd edge), (Float.mul edge_weight (-1.0)))::(set_cg_weights l)
    | _ -> [] 
    in
    set_cg_weights cg_temp  

let get_fst (s1,_,_) = s1 
let get_snd (_,s2,_) = s2 
let get_trd (_,_,v) = v 

(**
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


(*
let () = Hashtbl.iter  (fun x a0 -> print_string x; print_float a0) cg_paths_weights
*)

let heaviest node_list = 
  let r = ref 0.0 in
  let name = ref "" in
  let () = 
  List.iter (fun node -> 
    let max_two = Float.max !r (Hashtbl.find cg_paths_weights node) in
    if max_two > !r then name := node ; r:=max_two 
  ) node_list
  in
  !name


let rec step_back visited = function
    [] -> visited
  | n::nodes -> step_back ((heaviest (n::nodes))::visited) (anteccessors n)


let () = List.iter (fun name -> print_endline name) (step_back [] [heaviest topologicalOrder])
