
open String
(*let status = Sys.command "./prepare.sh"*)


let model_file = "resources/test_model.txt"

let files_path = "resources/method_files/"


let methods_bounds = Bounds.get_bounds()

let model = Load_model.Load.load_model model_file


let method_files_list = Sys.readdir files_path

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
    fun method_name -> let file_path = (String.concat files_path [""; method_name]) in
    
    Hashtbl.add energy_per_method method_name (apply_model method_name (read_file (open_in file_path)) 1 false)
    
    ) method_files_list


let () = Hashtbl.iter (fun x a -> print_string x; print_float a) energy_per_method  


