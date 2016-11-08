let list_int = 4::5::7::10::4::2::8::[];;
let list_bool = false::false::false::false::true::false::[];;
let list_bool_false = false::false::false::false::[];;

(* Ex1 *)


(* Q1 : fold-left et fold-right permettent d'appliquer une fonction sur chaque élément d'une liste  tout en conservant une variable (au début la valeur de départ, puis notre fonction peut le changer)
fold-right s'applique en partant de la fin de la liste *)

(* Q2 *)
let sum list =
  List.fold_left (fun acc x -> acc + x) 0 list;;

let sum_opti list =
    List.fold_left (+) 0 list;;

let length list =
    List.fold_left (fun acc x -> acc + 1) 0 list;;
      
let maximum list =
    List.fold_left (fun acc x -> max acc x) (List.hd list) list;;

(* Q3 *)
let list_or list =
    List.fold_left (fun acc x -> if x = true then true else acc) false list;;


