 
let pi = 3.1415;;
let truc = pi;; (* copie de la valeur de pi dans truc et non reference.*)

let rot_gen pi (x,y,ang) = 
  let newx = x*.cos(ang*.pi) +. y*.sin(ang*.pi) in
  let newy = x*.sin(ang*.pi) -. y*.cos(ang*.pi) in (newx,newy);;
let rot = (rot_gen pi);; (* fixe cette copie de pi a 3.1415 *)
let pi = "troispointquatorze";;
rot (1.,0.,1.);; (*utilise la version de pi présente dans rot.*)


(* ex2 *)

let i = 0 ;;
let f j = j + i;;
let main = print_int(f 1); print_int(f 2); i=421 in print_int(f 2);
(* Ne peut pas retourner les mêmes valeurs que dans la version C puisqu'on ne peut redéfinit le 'i' présent dans l'environnement de f. Son environnement a été préalablement définit et n'est pas modifiable. *)
main;;
