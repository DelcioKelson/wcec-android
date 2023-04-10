let load_model model_file =
 let file = open_in model_file in
 let model = ref [] in 
 let () = 
 try
   while true; do
     let word_list = Str.split (Str.regexp "[|]" ) (input_line file) in
     let first = List.nth word_list 0 in 

     let second = Float.of_string (String.trim (List.nth word_list 1)) in 
     let third = Float.of_string (String.trim (List.nth word_list 2)) in  
 
     model := (first, Float.mul second third)::(!model);
   done;
 with End_of_file -> close_in file; in 
 !model  


 type graph = {nodes : string list; edges : (string * string) list}


let load_cg cg_file =
  let file = open_in cg_file in
  let nodes = ref [] in 
  let edges = ref [] in 
  let () = 
  try
    while true; do
      let word_list = Str.split (Str.regexp "[=]\|[\n]" ) (input_line file) in
      let first = List.nth word_list 0 in 
      let second = List.nth word_list 1 in  
      edges := (first,second)::(!edges);
      if not (List.mem first !nodes) then (nodes:= first::(!nodes));
      if not (List.mem second !nodes) then (nodes:= second::(!nodes))

    done;
  with End_of_file | Failure "nth" -> close_in file; in 
  {nodes = !nodes; edges= !edges}
