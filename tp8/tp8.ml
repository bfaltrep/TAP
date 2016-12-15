(* - Ex1 - *)

(* Q1 - evaluation paresseuse *)

type 'a frozen_flow = 
| End of 'a
| Step of (unit -> 'a frozen_flow);;

(* reconnait pas x comme une function meme si il est Step *)
let thaw x =
  match x with
  | End y -> End y
  | Step f -> f ();;

(* Q2 *)

let ppcm x y =
  let rec ppcm_rec x y mul = 
    if (y > x) then (ppcm_rec y x mul) else (* Ensures x >= y *)
    if (x = 0) then 0 else                  (* Ensures both are positive *)
      let r = (x mod y) in 
        if (r = 0) then (mul/y) else ppcm_rec y r mul
  in ppcm_rec x y (x*y);;


(* wanted : int -> int -> int frozen_flow*)
let frozen_ppcm x y =
  let rec ppcm_rec x y mul = 
    if (y > x) then Step (fun () -> ppcm_rec y x mul) else (* Ensures x >= y *)
      if (x = 0) then End 0 else                  (* Ensures both are positive *)
	let r = (x mod y) in 
        if (r = 0) then End (mul/y) else Step (fun () -> ppcm_rec y r mul)
  in ppcm_rec x y (x*y);;

(* Q3 *)

type ('key,'data) frozen_data_flow = 
| End of 'data
| Step of (unit -> (('key*'data) list) * ('key,'data) frozen_data_flow);;

let thaw x =
  match x with
  | End y -> End y
  | Step f -> f ();;

(* result : val frozen_ppcm_assoc : int -> int -> (string, int) frozen_data_flow = <fun> *)
let frozen_ppcm_assoc x y =
  let rec ppcm_rec x y mul = 
    if (y > x) then Step (fun () -> ( [("x",x);("y",y);("mul",mul)], ppcm_rec y x mul )) else (* Ensures x >= y *)
      if (x = 0) then End 0 else                  (* Ensures both are positive *)
	let r = (x mod y) in 
        if (r = 0) then End (mul/y) else Step (fun () -> ( [("x",x);("y",y);("mul",mul)] , ppcm_rec y r mul))
  in ppcm_rec x y (x*y);;

(* - Ex2 - Lazy lib *)

let f = lazy (failwith "Marchera pas");;
Lazy.force f;;

(* Q1 *)

(* congeler *)
let entier = (End 5);;
let liste = (End [2;5;4;5;8;9]);;
let tableau = (End [|2;5;4;5;8;9|]);;
(* decongeler *)
let unfrozen value = lazy value;;

(* Q2 *)

let bord_effect x = print_int x;;

let frozen = lazy (bord_effect 5);;
let unfrozen = Lazy.force frozen;;

(* l'effet de bord se produit lorsqu'on 'décongèle' la fonction *)

(* Q3 *)

(* on constate qu'on ne peut utiliser unfrozen qu'une seule fois alors que dans la version de l'exercice 1, la définition de 'unfrozen' fait qu'on peut l'utiliser autant de fois que l'on veut. *)

(* - Ex3 - Flots de données *)

(* Q1 *)

type 'a stm1 = 
| Stm1Empty 
| Cons1 of 'a * ('a stm1 lazy_t)

let q1 = Cons1(1/0, lazy (Cons1 ( 3, lazy (Stm1Empty))) );; (* provoque l'exception : Exception: Division_by_zero. *)
let q1bis =  Cons1(1, lazy (Cons1 ( 1/0, lazy (Stm1Empty))));; (* ne provoque PAS l'exception : Exception: Division_by_zero. *)

(* le problème vient du fait que l'évaluation paresseuse cache des problèmes sous jacents dans la liste. *)

let rec length_evaluated stm = match stm with 
  | Stm1Empty -> 0
  | Cons1(x,y)   -> if not(Lazy.lazy_is_val y)
    then 1
    else let u = Lazy.force y in 
         1 + length_evaluated u;;

(* Q2 *)

let q2 = Cons1(2, lazy (Cons1 ( 3, lazy (Stm1Empty))) );;
let q2longer = Cons1(2, lazy (Cons1 ( 3, lazy (Cons1 ( 4, lazy (Cons1 ( 5, lazy (Cons1 ( 6, lazy (Stm1Empty))))))))));;

let stm_head stm = match stm with
    | Stm1Empty -> (failwith "stm_head exception : nothing inside.")
    | Cons1(x,y) -> x;;

let is_empty stm = match stm with
  | Stm1Empty -> true
  | Cons1(x,y) -> false;;

let rec stm_tail stm = match stm with
    | Stm1Empty -> (failwith "stm_tail exception : nothing inside.")
    | Cons1(x,y) -> if(is_empty (Lazy.force y) ) then x else stm_tail (Lazy.force y);;
(*
let rec stm_create stm list = match stm with
  | Stm1Empty -> (failwith "stm_tail exception : nothing inside.")
  | Cons1(x,y) -> if(is_empty (Lazy.force y) ) then x::list else x::(stm_create (Lazy.force y) list) ;;

stm_create q2longer 2 [];;
- : int list = [2; 3; 4; 5; 6]
*)

let rec stm_create stm n list = match stm with
  | Stm1Empty -> (failwith "stm_tail exception : nothing inside.")
  | Cons1(x,y) -> if(is_empty (Lazy.force y))
    then x::list
    else
      if(n < 1)
      then list
      else  x::(stm_create (Lazy.force y) (n-1) list) ;;

(* Q3 *)
type 'a stm2 = 
| Stm2Empty 
| Cons2 of ('a * 'a stm2) lazy_t;;

let q3 = [1;2;3;4;5;6];;

let rec list_to_stream list =
  match list with
    | [] -> Stm2Empty
    | h::q -> Cons2(lazy (h, list_to_stream q));;

let test = list_to_stream(q3);;

(* Q4 *)


(*
let rec fun_to_stream_bounded f n = 
  match n with
    | 0 -> (failwith "fun_to_stream_bounded exception : n = 0.")
    | n -> let value = f n in
	   if(n > 1)
	   then Cons2(lazy (value ,fun_to_stream_bounded f (n-1)))
	   else Cons2(lazy (value ,Stm2Empty));;
*)

let fun_to_stream_bounded f n = 
  let rec fun_inside f n i =
    match i with
      | 0 -> (failwith "fun_to_stream_bounded exception : n = 0.")
      | n -> Cons2(lazy (f n, Stm2Empty))
      | i -> Cons2(lazy (f n ,(fun_inside f n (i+1))))
  in fun_inside f n 1;;

let mult = fun_to_stream_bounded (fun x -> x*5) 5;;

let unfreeze stm = match stm with
  | Stm2Empty -> (failwith "unfreeze exception : flblblbl EMPTY.")
  | Cons2(x) -> Lazy.force x;;
 
unfreeze mult;;

(* Q6 *)

(* utils *)
let is_empty stm = match stm with
  | Stm2Empty -> true
  | Cons2(_) -> false;;

let fonction n = match n with
  | 0 -> 1
  | 1 -> 1
  | n -> n+(n-1);;


let stream_to_list stm =
  let rec stl_inside stm list = 
      match stm with
  | Stm2Empty -> list
  | Cons2(x) -> (stl_inside (snd(Lazy.force x)) ((fst(Lazy.force x))::list))
  in stl_inside stm [];;


let rec stm_map stm f =
  match stm with
    | Stm2Empty -> (failwith "stm_map exception : EMPTY stream.")
    | Cons2(x) -> if is_empty (snd (Lazy.force x))
      then
	Cons2(lazy (f (fst (Lazy.force x)),  (snd (Lazy.force x))))
      else
	Cons2(lazy (f (fst (Lazy.force x)), (stm_map (snd (Lazy.force x)) f)));;

(* test de list_to_stream et de map *)
let list = stream_to_list (stm_map (list_to_stream q3) (fun x -> x+1));;

(* Q7 *)

(* ... utilisation de match pour caster ... on voyait pas comment faire un cast proprement *)
let rec stm_compose stm stm2 f =
  if not(is_empty stm) && not(is_empty stm2)
  then
    match stm with
      | Cons2(x) ->
	match stm2 with
	  | Cons2(y) -> Cons2( lazy ( (f (fst(Lazy.force x)) (fst(Lazy.force y))), (stm_compose (snd(Lazy.force x)) (snd(Lazy.force y)) f))) 
  else Stm2Empty;;

let compose = stream_to_list ( stm_compose (list_to_stream q3) (list_to_stream (List.rev q3)) (fun x y -> x + y));;

(* Q8 *)

let stm_concat stm stm2 = 
  if is_empty stm
  then
    stm2
  else
    match stm with
      | Cons2(x) ->
	let rec concat_inside stm stm2 =
	  match stm with
	    | Stm2Empty ->  (failwith "stm_concat exception : EMPTY stream.")
	    | Cons2(x) -> if is_empty (snd(Lazy.force x)) (* si on est sur le dernier élément non vide de stm *)
	      then if not(is_empty stm2)
		(* stm a été parcourue, nous relançons le traitement en parcourant stm2 cette fois. *)
		then Cons2(lazy ( (fst (Lazy.force x)), (concat_inside stm2 (snd(Lazy.force x)))))
		(* nos deux listes ont étés parcourues. Nous sommes sur le dernier élément de la seconde liste (maintenant devenue stm) *)
		else  Cons2(lazy ( (fst (Lazy.force x)), Stm2Empty))
	      (* on continue le parcours de stm *)
	      else Cons2(lazy (fst (Lazy.force x), concat_inside (snd(Lazy.force x)) stm2))
	in Cons2(lazy (fst (Lazy.force x), (concat_inside (snd (Lazy.force x)) stm2)));;

let concat = stream_to_list ( stm_concat (list_to_stream q3) (list_to_stream (List.rev q3)) );;
