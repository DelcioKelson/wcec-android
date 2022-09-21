
let problem_file = "problem.lp"

let get_fst_3 (s1,_,_) = s1 
let get_snd_3 (_,s2,_) = s2 
let get_trd_3 (_,_,v) = v 

let get_fst_4 (s1,_,_,_) = s1 
let get_snd_4 (_,s2,_,_) = s2 
let get_trd_4 (_,_,v,_) = v 
let get_fth_4 (_,_,_,d) = d

let edges_enumerated edges nodes ()= 
  List.fold_right (fun edge edge_list-> 
                    let i = List.length edge_list in 
                    if not (Hashtbl.mem nodes (get_fst_3 edge)) then Hashtbl.add nodes (get_fst_3 edge) ("x" ^ (string_of_int i));
                    if not (Hashtbl.mem nodes (get_snd_3 edge)) then Hashtbl.add nodes (get_snd_3 edge) ("y" ^ (string_of_int i));
                    (Hashtbl.find nodes (get_fst_3 edge), Hashtbl.find nodes (get_snd_3 edge), get_trd_3 edge, "d" ^ (string_of_int i))::edge_list) (List.rev edges) [] 
  

let obj_fun edges_enumerated nodes= 
  Hashtbl.fold (fun _ node obj -> obj ^ "+" ^ string_of_float ( try get_trd_4 
  (List.find (fun el -> node = (get_snd_4 el) ) edges_enumerated) with Not_found -> 1.0 )^ node   ^ "  "  )nodes  ""   

let anteccessors_edges_sum n edges_enumerated=
  let matching (_,a,_,_) = a = n in
  let edgs = List.filter matching edges_enumerated in 
  let edges_sum = List.fold_right (fun edge sum ->  sum ^ "+" ^  (get_fth_4 edge )) edgs "" in
  if "" = edges_sum then (string_of_int 0) else edges_sum

let successors_edges_sum n edges_enumerated= 
  let matching (s,_,_,_) = s = n in
  let edgs = List.filter matching edges_enumerated in 
  List.fold_right (fun edge sum ->  sum ^ "+" ^  get_fth_4 edge ) edgs "" 

let equations edges_enumerated nodes= 
  Hashtbl.fold (fun _ node equ_aux ->
    let succers = (successors_edges_sum node edges_enumerated) in
    let anteccers = (anteccessors_edges_sum node edges_enumerated) in
    equ_aux ^ (if not ("" = succers) then  node ^ "=" ^ succers ^ ";\n" else "") ^
    (if not ("" = anteccers) && (not (node="x0"))  then node ^ "=" ^ anteccers ^ ";\n" else "" )
    ) nodes  ""


(*the first node (entry node) is the element x0*)

let rec prind_list edges = 
    match edges with
    | [] -> print_endline ""
    | e::edg -> Printf.printf "%s %s %f %s " (get_fst_4 e) (get_snd_4 e) (get_trd_4 e) (get_fth_4 e);
                prind_list edg
let solve_ilp edges () =
  (* Write message to file *)
  let oc = open_out problem_file in
  (* create or truncate file, return channel *)
  let nodes =  Hashtbl.create 10000 in 
  let edgs = edges_enumerated edges nodes () in
  let () = Printf.fprintf oc "max: %s;\n" (obj_fun edgs nodes) in
  let () = Printf.fprintf oc " x0 = 1 ; \n %s\n" (equations edgs nodes) in 
  (* write something *)
  let () = close_out oc in 
  let () = print_endline "wcec:" in 
  ignore( Sys.command "lp_solve -S1 problem.lp " )
