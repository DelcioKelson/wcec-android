exception Cyclic of string

let get_fst_3 (s1,_,_) = s1 
let get_snd_3 (_,s2,_) = s2 
let get_trd_3 (_,_,v) = v 

let get_snd_4 (_,s2,_,_) = s2 
let get_trd_4 (_,_,v,_) = v 
let get_fth_4 (_,_,_,d) = d


let successors n edges=
  let matching (s,_,_) = s = n in
  List.map get_snd_3 (List.filter matching edges);;

let anteccessors n edges=
  let matching (_,s,_) = s = n in
  List.map get_fst_3 (List.filter matching edges);;

let successors_edges n edges= 
  let matching (s,_,_) = s = n in
  List.filter matching edges;;

let tsort seed edges =
  let rec sort path visited = function
      [] -> visited
    | n::nodes ->
      if List.mem n path then raise (Cyclic n) else
      let v = if List.mem n visited then visited else
      n :: sort (n::path) visited (successors n edges)
      in sort path v nodes
    in
    sort [] [] [seed]      

(*shortest path(negative values)*)
let longest_path edges entry_node topologicalOrder = 
  let cg_paths_weights =  Hashtbl.create (List.length topologicalOrder) in
  let () = Hashtbl.add cg_paths_weights entry_node 0.0 in
  let () = List.iter (fun node -> 
    (List.iter (fun edge -> 
      let edge_to = get_snd_3 edge in
      let new_weight = Float.add (Hashtbl.find cg_paths_weights node)  (get_trd_3 edge) in 
       try let past = (Hashtbl.find cg_paths_weights edge_to) in 
      Hashtbl.replace cg_paths_weights edge_to (Float.min past new_weight) with Not_found -> 
        Hashtbl.add cg_paths_weights edge_to new_weight 
    ) (successors_edges node edges)
  )
  ) topologicalOrder
      in
    let () =  Hashtbl.iter  (fun x a0 -> Hashtbl.replace cg_paths_weights x (Float.mul a0 (-1.0))) cg_paths_weights
    in
    cg_paths_weights

(*let () = Hashtbl.iter  (fun x a0 -> print_string x; print_float a0) cg_paths_weights*)

let heaviest node_list cg_paths_weights= 
  List.fold_left (fun x y ->  if (Hashtbl.find cg_paths_weights x) < (Hashtbl.find cg_paths_weights y) then y else x) (List.hd node_list) node_list

let rec step_back visited edges cg_paths_weights = function
    [] -> visited
  | n::nodes -> step_back ((heaviest (n::nodes) cg_paths_weights)::visited)  edges cg_paths_weights (anteccessors n edges)

let cal_heaviest_path edges() = 
  let edges = 
  List.map (fun edge ->  
    ((get_fst_3 edge),(get_snd_3 edge), Float.mul (get_trd_3 edge) (-1.0) ))edges in 
  let entry_node =  get_fst_3 (List.hd edges) in
  let topologicalOrder = tsort entry_node edges in
  let cg_paths_weights = longest_path edges entry_node topologicalOrder in 
  let final_node = heaviest topologicalOrder cg_paths_weights in
  let () = print_endline "\nheaviest path:" in
  let () = Printf.printf " Initial" in
  let () = List.iter (fun name -> Printf.printf "==> %s\n" name) (step_back [] edges cg_paths_weights [final_node] ) in 
  let () = Printf.printf "\ntotal path weight : %f\n" (Hashtbl.find cg_paths_weights final_node) in 
  Printf.printf "\ntime, in seconds, used by the program: %f\n" (Sys.time())
