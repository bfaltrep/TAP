(* primitives types : (), named 'unit' is void. int, float, bool, string "", char '', 
   families types : List [;] , Tuples parenthesis with commas and functions as first-class object.
*)

(* EX3 *)

let x = true;;
let x = sqrt;; (* les fonctions sont traitées comme des variables, donc ne pose pas de problème ici.*)

let add a b = a +. b;; (* add : float -> float -> float = <fun> signifie que add prend deux flottants en entrée, et retourne un flottant. *)
let sum (a, b) = a +. b;; (* sum : float * float -> float = <fun> différent de add. un seul argument qui est un tableau symbolisé par des étoiles. *)


let fun1 a = 2.*.a+.3.;; (* a est admis comme un flottant du fait de son utilisation avec des opérateurs flottants.*)
let fun2 a = 3.*.(sqrt(cos a))+.1.
let abso a = if a < 0 then -a else a;;

(* EX4 *)

let make_even f (x:float) =  (f x)+.f(-.x)/.2.;;
let deriv f e x = (f(x+.e)-.f(x-.e))/.2.*.e;;
let compo f e x = make_even f (deriv f e (make_even f (f x)));;

(* EX5 *)

let rec fact x = if x = 0 then 1 else x*fact(x-1);;

(* ne compile pas. *)
let rec newton f n x e = match n with
  0 -> x
  | n -> let u = (newton f (n-1) x e) in 
	 u -.((f u)/.(deriv f e u))
;;

