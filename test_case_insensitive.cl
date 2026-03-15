(* Teste de case insensitive e caracteres especiais *)

(* Palavras-chave em diferentes cases - devem funcionar *)
Class TestCase Inherits IO {
    attr : Int <- 0;
    
    testKeywords() : SELF_TYPE {
        {
            If attr = 0 Then
                WhILe attr < 10 lOOp
                    attr <- attr + 1
                pOOl
            eLse
                attr <- 0
            FI;
            
            cAsE attr oF
                x : Int => x;
            EsAc;
            
            lEt temp : Int <- NeW Int In
                temp;
                
            If IsVoid temp tHeN
                nOt True
            eLsE
                FaLsE
            fI;
            
            self;
        }
    };
};

(* Teste com caracteres invalidos diversos *)
class BadChars {
    test1 : Int <- 10 ^ 2;
    test2 : Int <- 5 % 3;
    test3 : String <- "ok" & "test";
    test4 : Int <- 1 | 2;
};
