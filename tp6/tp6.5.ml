(*** Exercice  5  ***)

type op_bin = PLUS | MOINS | EQUAL | MULT | DIV;;
type expression = 
| ExpInt of int 
| ExpVar of string
| ExpBin of expression * op_bin * expression  ;;
 
type valeur = Vint of int | VBool of bool;;
 
type instruction = 
| Goto of int 
| Print of expression
| Input of string 
| If of expression * int 
| Let of string * expression  ;;
type ligne = { num : int ; inst : instruction }  ;;
type program = ligne list  ;;
 
10 INPUT N
20 LET I = 1
30 LET S = 1
40 LET I = I + 1
50 LET S = S * I
60 IF (I = N) THEN GOTO 80
70 GOTO 40
80 PRINT S

let prog = [
  { num = 10; inst = Input "n" };
  { num = 20; inst = Let ("i",ExpInt 1) };
  { num = 30; inst = Let ("s",ExpInt 1) };
  { num = 40; inst = Let ("i",(ExpBin ((ExpVar "i"),PLUS,(ExpInt 1)))) };
  { num = 50; inst = Let ("s",(ExpBin ((ExpVar "s"),MULT,(ExpVar "i")))) };
  { num = 60; inst = If ((ExpBin ((ExpVar "i"),EQUAL,(ExpVar "n"))),80) };
  { num = 70; inst = Goto 40 };
  { num = 80; inst = Print (ExpVar "s") };
];;

