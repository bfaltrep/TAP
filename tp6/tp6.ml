(*** Exercice  1  ***)

type weight =
  | Gram of float
  | Livre of float
  | Carat of float;;

let convert x =
  match x with
    | Gram x -> x
    | Livre x -> x *. 1000. /. 2.205
    | Carat x -> x *. 1000. /. 5000.;;

let res = convert(Livre 50.);;

type value = 
  | Int of int 
  | Float of float;;
 
let string_of_value x =
 match x with 
  | Int i   -> string_of_int i;
  | Float f -> string_of_float f;;

let rec sum_of_values a b = match (a,b) with 
  | (Int i,Int j)     -> Int(i+j)
  | (Int i,Float f)   -> Float((float i)+.f)
  | (Float f,Float g) -> Float (f+.g)
  | (Float f, Int i)  -> Float((float i)+.f);; (*line added*)

type money = ZlotysOne | ZlotysSeven | ZlotysThirteen;;

let rec glouton n =
  if n>=13 then ZlotysThirteen::glouton(n-13)
  else if n>=7 then ZlotysSeven::glouton(n-7)
  else if n>=1 then ZlotysOne::glouton(n-1)
  else [];;
    
let res = glouton 42;;

(*** Exercice  2  ***)

type 'a bintree = 
| BinEmpty
| BinNode of 'a * 'a bintree * 'a bintree

let rec bintree_build f h x = 
  if (h<=0)
  then BinEmpty
  else let (x1,x2) = f(x) in 
          BinNode (x,
            (bintree_build f (h-1) x1),
            (bintree_build f (h-1) x2));;
 
let f x = (2*x,2*x+1);;

let rec bintree_map tree f =
  match tree with
    |BinEmpty            -> BinEmpty
    |BinNode(x, l1, l2)  -> BinNode(f x, bintree_map l1 f, bintree_map l2 f);;

let inc x = x +1;;
let t = BinNode(4, BinNode(1, BinEmpty, BinEmpty), BinNode(7, BinEmpty,BinNode( 8, BinEmpty, BinEmpty)));;
let t2 = bintree_map t inc;;

let rec bintree_insert tree x =
    match tree with
    |BinEmpty            -> BinNode(x, BinEmpty, BinEmpty)
    |BinNode(y, l1, l2)  -> if(y >= x) then BinNode(y, bintree_insert l1 x, l2) else BinNode(y, l1, bintree_insert l2 x);;

let bi = bintree_insert t 5;;

(* 
 Une instance en caml est persistante car même si son créateur est supprimé, si une autre instance pointait sur elle (ou sa valeur), cette instance reste accessible (en tout cas, ses valeurs sont accessibles, que ce soit une copie n'est pas pertinent.
 Nous ne savons pas si l'instance est déplacable en mémoire. Mais nous présumons qu'elles sont souvent clonées (passage des arguments par valeur), ce qui peut être considéré comme un déplacement de valeur en mémoire. *)

type 'a gentree =
  | TEmpty
  | TNode of 'a * 'a gentree list;;

let rec tree_build f n rac = 
  match n with 
    | 0 -> TNode(rac,[])
    | _ -> TNode(rac,List.map (tree_build f (n-1)) (f rac));;

let rec tree_map f tree = match tree with 
  | TEmpty     -> TEmpty
  | TNode(l,r) -> TNode (f l,List.map (tree_map f) r);; 

let tree = TNode(7,TNode(1,[])::TNode(4,[])::[]);;
let res = tree_build (fun x -> [x;x+1]) 11 1;;
tree_map inc res;;


(*** Exercice  4  ***)

type 'a queue = Q of 'a list * 'a list;;  

let q_insert x (Q (l1, l2)) = Q([x]@l1, l2);;

let q_transfer (Q (l1, l2)) = if l2 = [] then Q([],List.rev l1) else (Q (l1, l2));;

let q_pop_simple (Q (l1, l2)) = if l2 <> [] then  Q(l1,List.tl l2) else failwith "error: 500 or 404 maybe... have fun" ;;

let q_pop (Q (l1, l2)) = if l2 <> [] then
    Q(l1,List.tl l2)
  else
    if(l1 <> []) then
      let test = (q_transfer (Q(l1,l2))) in
      q_pop test
    else
      failwith "error: 500 or 404 maybe... have fun" ;;

let queue = Q ([] , []);;
let queue3 = q_pop queue;;
let queue = q_insert 1 queue;;
let queue3 = q_pop queue;;
let queue = q_insert 7 queue;;
let queue = q_insert 8 queue;;
let queue = q_transfer queue;;
let queue2 = q_insert 2 queue;;
let queue2 = q_transfer queue2;;
let queue2 = q_pop queue2;;


(*
  let q_insert2 x f =
    match f with
      | [] 
      | l1@l2 -> 
*)
 
