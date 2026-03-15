(* Teste especifico de strings com \n e \0 *)

class StringCases {
    (* String com \n no meio - deve funcionar *)
    test1() : String {
        "Line1\nLine2"
    };
    
    (* String com multiplos \n - deve funcionar *)
    test2() : String {
        "First\nSecond\nThird"
    };
    
    (* String com \0 (backslash zero) - deve funcionar e virar '0' *)
    test3() : String {
        "Before\0After"
    };
    
    (* String com null character real (byte 0) - deve dar erro *)
    test4() : String {
        "String with null"
    };
    
    (* String com nova linha SEM escape - deve dar erro *)
    test5() : String {
        "String quebrada
        na linha seguinte"
    };
    
    (* Outros escapes validos *)
    test6() : String {
        "Tab\there\nNewline\bBackspace\fFormfeed"
    };
    
    (* Escape de aspas e backslash *)
    test7() : String {
        "Quote: \" and Backslash: \\"
    };
};
