(* 
   Arquivo de teste adicional para erros COOL
   Testa comentarios nao balanceados e outros casos
*)

class MoreErrors {
    (* Teste de comentario balanceado OK *)
    testOK() : Int {
        42
    };
    
    (* Teste (* de comentario (* aninhado *) que funciona *) *)
    testNested() : Int {
        100
    };
    
    (* Agora vem um comentario nao balanceado *)
    testUnbalanced() : Int {
        10 *) 20
    };
    
    (* Teste de string com escape valido *)
    testEscapes() : String {
        "Line1\nLine2\tTabbed\bBackspace"
    };
    
    (* Teste de string com \0 - deve funcionar *)
    testBackslashZero() : String {
        "Contains\0digit"
    };
};
