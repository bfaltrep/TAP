(*** Exercice  1  ***)
 
type 'a vertex = V of 'a
and 'a graph_full = Graph of ('a vertex * 'a vertex list) list;;

(* 1.1 *)
let graph1 = Graph([((V "s1"), [(V "s2");(V "s3")]);
		    ((V "s2"), [(V "s1")]);
		    ((V "s3"), [(V "s1")])]);;

let vertex_equality v1 v2 = v1 = v2;; (* surtout pas ==. http://caml.inria.fr/pub/old_caml_site/FAQ/FAQ_EXPERT-eng.html#egalite *)

let v1 = (V "s1");;
let v2 = (V "s1");;
let v3 = (V "s2");;

vertex_equality v1 v1;; (* expected true *)
vertex_equality v1 v2;; (* expected true *)
vertex_equality v1 v3;; (* expected false *)

(* 1.2 *)
let rec graph_map (Graph g) f = 
  match g with
    | [] -> []
    | (V elmt, friends)::q -> Graph([(f elmt, friends)])::graph_map (Graph q) f;; 

graph_map graph1 (function x -> (V "sommet"));;
(* Le problème est que chaque sommet est identifié par sa valeur, si elle change ou si plusieurs sommets contiennent des doublons, alors l'objet est faussé. *)
(* 1.3 : chaque sommet a une clé unique, distincte de sa valeur, qui seule permet de le distinguer et est utilisée dans la liste de voisin de chaque sommet.*)

type 'k key = K of 'k
and ('k, 'a) vertex = 'k key * 'a 
and ('k, 'a) graph = Graph of (('k, 'a) vertex * 'k key list) list;;

let graph2 = Graph ([
  ((K 1, "Sapristi"), [K 2;K 3;K 4]);
  ((K 2, "Saperlotte"), [K 1;K 3]);
  ((K 3, "Sacrebleu"), [K 1;K 2]);
  ((K 4, "Sacristin"), [K 1]);
]);;

let rec graph_nexts (Graph g) (K k) =
   match g with
     | [] -> []
     | (((K k2), value) , behaviour )::q -> if k = k2 then behaviour else graph_nexts (Graph q) (K k);;

(* Q5 :  val graph-map : ('k, 'a) graph -> (('k, 'a) -> 'a) -> ('k, 'a) graph *)


(* ne fonctionne pas... mauvaise reconnaissance de type *)
let rec find_component (Graph g) (K k) component =
  match g with
      | [] -> component
      | (((K k2), value) , behaviour)::q -> if k2 = k || List.exists (function (x) -> x = k2) component then find_component (Graph q) (K k) (List.append behaviour component)::(K k2) else find_component (Graph q) (K k) component ;;

let component (Graph g) (K k) =  find_component (Graph g) (K k) [];; (* probleme : pour pouvoir traiter tous les graphes possibles, on devrait faire un parcours, puis un second utilisant la liste du premier et comparer si le résultat est le meme pour terminer le traitement.*)

(*** Exercice  2  ***)
type 'k key = K of 'k
and ('k, 'a) vertex = 'k key * 'a 
and ('k, 'a) graph = Graph of (('k, 'a) vertex * 'k key list) list;;
 
Graph ([
         ((K 1, "Sommet"), [K 2; K 3]);
         ((K 2, ""), [K 4; K 5]);
         ((K 3, ""), [K 6; K 7]);
         ((K 4, ""), []);
         ((K 5, ""), []);
         ((K 6, ""), []);
         ((K 7, ""), []);
       ])
 
type 'a strategy = Strategy of ('a -> 'a list -> 'a list -> 'a list)

(* 2.1 *)
    
let rec graph_find (Graph g) mark (K k) =
  match g with
    | [] -> []
    | (((K k2), value) , behaviour )::q -> if k = k2 then List.fold graph_find (Graph g) mark::value (K (List.hd behaviour)) else graph_nexts (Graph q) (K k);;

let rec depth_route (Graph g) (K k) =
  graph_find (Graph g) [] (K k);;
    
  (*
  match g with
    | [] -> []
    | (((K k2), value), behaviour)::q -> let mark2 = (depth_route List.partition (function (x) ->  ) ) in
					 if not (List.exists (function (K x) -> x=k2) mark)
					 then ((K k2)::mark)@mark2
					 else mark@mark2;;  *)

(* 2.2 *)

let rec width_route (Graph g) mark =
  match g with
    | [] -> []
    | (((K k2), value), behaviour)::q -> let mark2 = (width_route (Graph q)) in if() mark@mark2 else mark@mark2;;



(*** Exercice 3  ***) 

type 'a set = Set of ('a -> bool);;
    
let set_even = Set (fun x -> (x mod 2) == 0);;
let set_contains_0 (Set s) = s 0;;  (* pattern-matching *)
 
let ( +| ) (Set s1) (Set s2) = Set (fun y -> s1 y || s2 y);;  
let ( *| ) (Set s1) (Set s2) = Set (fun y -> s1 y && s2 y);; 


let set_empty = Set (fun x -> false);;

let set_all = Set (fun x -> true);;

let set_singleton x = Set( fun y -> x = y);; 

let set_mem (Set s) x = s x;;
 
let set_add (Set s) x = Set (fun y -> x = y || s y);;

let set_out (Set s) = Set (fun y -> not (s y));;

let ( +-| ) s1 s2 = (s1 *| (set_out s2)) +| ((set_out s1) *| s2);;

let ( +-| ) (Set s1) (Set s2) = Set ( fun y -> if s1 y &&  s2 y
  then false
  else
    if s1 y || s2 y
    then true
    else false);;


let test = (set_out (set_even));;
let truc = set_all +-| set_even;;
