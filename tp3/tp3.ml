(* Ex1 - curry*)

(* Q1 *)
let f1 (a, b, c) = b;;

    (* Q2 *)
let testc x y = x+y;;
let testdec (x, y) = x+y;;

let curry f x y = f (x,y);;
let decurry f (x,y) = f x y;;

let curry_fun f = fun x y -> f (x, y);;
let decurry_fun f = fun (x,y) -> f x y;;

let testc_decur = decurry testc;;
let testdec_cur = curry testdec;;

testc_decur (4,5);;
testdec_cur 4 5;;

    (* Q3 *)

let inverse f x y = f y x ;;                          

    (* Q4 *)

let example x = x*2;;

let rec iterate f n x =
  match n with
  | 0 -> f x
  | n -> f (iterate f (n-1) x);;

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
    | t::q -> list_concat_term (t::l1) q;;




    (* Ex3 -Objet Enregistrements *)

(* Q1 *)

(*version non objet : let addC c1 c2 = {a = c1.a +. c2.a ; b=c1.b +. c2.b};;*)

(* I -  version incomplète - mais fonctionnelle *)

type complexeV1 = {
  a : float;
  b : float;
}

let constructeur a1 b1 = {a = a1 ; b=b1};;

let c1 = constructeur 5. 7.;;
let c2 = {a=2.;b=31.};;

(* II - ajout de fonction ressemblant à de l'objet - ADD *)

type complexe = {
  a : float;
  b : float;
  add : complexe -> complexe;
};;

let e1 = {a=5.;
	  b=7.;
	  add = fun c2 -> { a = e1.a +. c2.a ; b = e1.b +. c2.b ; add = c2.add ;}};;


let e2 = e1.add e1;;



(* III - ajout de fonction ressemblant à de l'objet - MULT  --> tentative *)

type complexe = {
  a : float;
  b : float;
  add : complexe -> complexe;
  mult : complexe -> complexe;
};;

let e1 = {a=5.;
	  b=7.;
	  add = fun c2 -> { a = e1.a +. c2.a ;
			    b = e1.b +. c2.b ;
			    add = c2.add ;
			    mult= c2.mult} ;
	    mult = fun c2 -> { a = e1.a *. c2.a ; (* Se croirait-il encore dans add ? Pourquoi une telle indentation ? Comment corriger cela ? *)
			    b = e1.b *. c2.b ;
			    add = c2.add ;
			    mult= c2.mult}
	 };;

(*
erreur :
This expression has type complexe/1303 -> complexe/1303
       but an expression was expected of type complexe/1325 -> complexe/1325
       Type complexe/1303 is not compatible with type complexe/1325 
*)




