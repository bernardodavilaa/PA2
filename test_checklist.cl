(* Teste 1: Keywords case-insensitive *)
class CLASS Class ClAsS
if IF iF
inherits INHERITS

(* Teste 2: true/false case-sensitive *)
true
false
tRuE
fAlSe

(* Teste 3: Identificadores *)
Main
main
MyClass
myVariable
x1
X1
self
SELF_TYPE

(* Teste 4: Operadores compostos *)
x <- 5
x <= 10
case x => 1

(* Teste 5: String com escapes *)
"hello\nworld"
"tab\there"
"quote\"inside"

(* Teste 6: Comentário de bloco *)
(* simples *)
(* externo (* aninhado *) *)

(* Teste 7: Comentário de linha *)
-- isto é um comentário
x <- 1; -- comentário no fim
