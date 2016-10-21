(* Ex1 - curry*)

(* Q1 *)
let f1 (a, b, c) = b;;

(* Q2 *)
let testc x y = x+y;;
let testdec (x, y) = x+y;;

let curry f x y = f (x,y);;
let decurry f (x,y) = f x y;;

let testc_decur = decurry testc;;
let testdec_cur = curry testdec;;

testc_decur (4,5);;
testdec_cur 4 5;;

(* Q3 *)

let inverse f x y = f y x ;;                          

(* Q4 *)

let test x = x*2;;

(* REFAIRE - pas assez générique*)
let rec iterate f n = if n = 0
  then f
  else f f(n-1));;

let rec iterate f n = match n with
  | 0 -> f
  | n -> (f (iterate f (n-1)));;

(*
Error: This expression has type 'a -> 'b
       but an expression was expected of type 'a
       The type variable 'a occurs inside 'a -> 'b
*)

(* Ex2 -liste *)

(*
  'a list => liste de type générique.
  1::[];; <= concatene
 - : int list = [1]

  [ (1,"true")  ; (2,"false") ] => liste de tuples (tuples du MEME format)

*)

let list_int = 4::5::7::[];;
let rec voir l =
  match l with
    | [] -> print_string " "
    | t::q -> print_int t; print_string " ";
              voir q;;

let list_asso = [(1,"v");(2,"a");(4,"n");(2,"z")];;
let rec list_remove l i =
  let getkey (a,b) = a in
  match l with
    | [] -> []
    | t::q -> if (getkey(t)=i)
               then list_remove q i
               else t::list_remove q i;;

let rec list_map f l =
  match l with
    | [] -> []
    | t::q -> (f t)::list_map f q;;

let list_int2 = 6::2::8::[];;
let list2 = [(7,"vb");(1,"dc");(5,"ws");(3,"jy")];;
(* version non recursive : let list_concat_term l1 l2 = l1@l2;; *)

let rec list_concat_term l1 l2 =
  match l2 with
    | [] -> l1; (*rec terminal*)
    | t::q -> list_concat_term t::l1 q;;


(* Ex3 -Objet Enregistrements *)

(* Q1 *)
type complexe = {
  a : float;
  b : float;
  add : 'a 'a -> 'a;
};;

