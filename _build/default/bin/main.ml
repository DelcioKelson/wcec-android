open String

let loop_bound_standard = 1000 
  
let _ =  ignore (Sys.command (" ./prepare.sh " ^ Sys.argv.(1) ^ " 2> /dev/null ")  )

let model_file = "model.txt"
let method_files = "/tmp/sootOutput/"
let cg_file = "/tmp/cg.txt"

(*Loads*)
let methods_bounds = Bounds.get_bounds()

let model = Load_model.Load.load_model model_file

let contains s1 s2 =
  let re = Str.regexp_string s2
  in try ignore (Str.search_forward re s1 0); true
      with Not_found -> false

(*means that have a labal1: (loop)*)
let rec inst_value line model =
  if (contains line ": if" && not (contains line "null")) then 0.0 else 
  match model with
  | [] -> 1.0
  | (instr, energy)::m -> if (contains line instr) then energy else  (inst_value line m) 

(*get the first element of the string*)
let get_loop_bound s bounds = 
  let lb = trim (List.hd (Str.split (Str.regexp ":") s)) in
  try Hashtbl.find bounds lb with Not_found -> 1 

let rec apply_model method_name ch times in_loop=
match input_line ch with
| l-> if in_loop then 
  if (contains l "goto") then (apply_model method_name ch 1 false) else
    Float.add (Float.mul (float times) (inst_value l model) )  (apply_model method_name ch 1 false)
  else
  let energy_inst = inst_value l model in
  if (energy_inst = 0.0 ) then 
    let times_try = try (get_loop_bound l (Hashtbl.find methods_bounds method_name)) with Not_found-> loop_bound_standard in 
    apply_model method_name ch times_try true 
  else
    Float.add energy_inst (apply_model method_name ch 1 false)
| (exception End_of_file ) -> 0.0

(*put the weights in the cg*)
let get_edges method_files_list = 
  let energy_per_method = Hashtbl.create (Array.length method_files_list)
  in
  let d = Domain.spawn( fun _ ->  
   Array.iter (
    fun method_file_name -> let file_path = (String.concat method_files [""; method_file_name]) in
    let method_name = Filename.remove_extension method_file_name in
    let file_channel = open_in file_path in
     let () = Hashtbl.add energy_per_method method_name @@ apply_model method_file_name  file_channel 1 false in
    close_in file_channel    
    ) method_files_list)
  in
  let cg_temp = Load_cg.Load.load_cg cg_file in
  let () = Domain.join d in 
  List.map (fun edge ->  
    let edge_weight = try Hashtbl.find energy_per_method (snd edge) with Not_found -> 1.0  in
    ((fst edge),(snd edge), edge_weight))cg_temp

let () =    
    let edges = get_edges (Sys.readdir method_files) in
    Solve.Cg_ilp.solve_ilp edges;
    (*let () = Solve.Heavist_path.heaviest_path edges in *)
    (*let () = Printf.printf "\ntime, in seconds, used by the program: %f\n" (Sys.time()) in *)
    ignore (Sys.command ("./clean.sh") )