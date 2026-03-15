(* 
   Arquivo de teste completo para analisador lexico COOL
   Cobre todos os tokens da linguagem em casos de sucesso
*)

(* Teste de classe base simples *)
class BaseClass {
    (* Atributos com e sem inicializacao *)
    attr1 : Int;
    attr2 : Int <- 42;
    attr3 : Bool <- true;
    attr4 : Bool <- false;
    attr5 : String <- "Hello World";
    attr6 : Object;
    
    (* Metodo simples sem parametros *)
    getValue() : Int {
        attr2
    };
    
    (* Metodo com multiplos parametros *)
    setValues(x : Int, y : Int, z : Bool) : Int {
        {
            attr1 <- x;
            attr2 <- y;
            attr3 <- z;
            attr1 + attr2;
        }
    };
    
    (* Metodo usando self *)
    getSelf() : SELF_TYPE {
        self
    };
};

(* Teste de heranca com inherits *)
class DerivedClass inherits BaseClass {
    derived_attr : String <- "Derived";
    
    (* Sobrescrita de metodo *)
    getValue() : Int {
        attr2 * 2
    };
    
    (* Teste de operadores aritmeticos: +, -, * *)
    arithmetic(a : Int, b : Int) : Int {
        {
            let result : Int <- 0 in
            {
                result <- a + b;
                result <- result - 10;
                result <- result * 2;
                result;
            };
        }
    };
    
    (* Teste de operadores de comparacao: =, <, <= *)
    comparison(x : Int, y : Int) : Bool {
        if x = y then
            true
        else
            if x < y then
                false
            else
                if x <= y then
                    true
                else
                    false
                fi
            fi
        fi
    };
};

(* Classe para testar expressoes condicionais *)
class ConditionalTest {
    (* Teste de if-then-else-fi *)
    testIf(condition : Bool) : String {
        if condition then
            "true branch"
        else
            "false branch"
        fi
    };
    
    (* Teste de if aninhado *)
    testNestedIf(x : Int) : Int {
        if x = 0 then
            0
        else
            if x < 0 then
                -1
            else
                1
            fi
        fi
    };
};

(* Classe para testar loops *)
class LoopTest {
    counter : Int <- 0;
    
    (* Teste de while-loop-pool *)
    testWhile(limit : Int) : Int {
        {
            counter <- 0;
            while counter < limit loop
                counter <- counter + 1
            pool;
            counter;
        }
    };
    
    (* Teste de not *)
    testNot(flag : Bool) : Bool {
        not flag
    };
};

(* Classe para testar let *)
class LetTest {
    (* Teste de let-in com uma variavel *)
    testLetSingle() : Int {
        let x : Int <- 10 in
            x + 5
    };
    
    (* Teste de let-in com multiplas variaveis *)
    testLetMultiple() : String {
        let str1 : String <- "Hello",
            str2 : String <- " ",
            str3 : String <- "World"
        in
            str1.concat(str2.concat(str3))
    };
    
    (* Teste de let sem inicializacao *)
    testLetNoInit() : Int {
        let y : Int in
            y
    };
};

(* Classe para testar case *)
class CaseTest {
    (* Teste de case-of-esac *)
    testCase(obj : Object) : String {
        case obj of
            i : Int => "Integer type";
            s : String => "String type";
            b : Bool => "Boolean type";
            o : Object => "Object type";
        esac
    };
};

(* Classe para testar isvoid *)
class VoidTest {
    maybe_null : Object;
    
    (* Teste de isvoid *)
    testIsVoid() : Bool {
        isvoid maybe_null
    };
    
    checkAndUse(obj : Object) : String {
        if isvoid obj then
            "null object"
        else
            "valid object"
        fi
    };
};

(* Classe para testar new *)
class NewTest {
    base_obj : BaseClass;
    derived_obj : DerivedClass;
    
    createObjects() : Object {
        {
            base_obj <- new BaseClass;
            derived_obj <- new DerivedClass;
            self;
        }
    };
};

(* Classe para testar IO *)
class IOTest inherits IO {
    (* Teste de entrada e saida *)
    testIO() : Object {
        {
            out_string("Enter text: ");
            let input : String <- in_string() in
            {
                out_string("You entered: ");
                out_string(input);
                out_string("\n");
                self;
            };
        }
    };
    
    (* Teste de out_int e out_string *)
    printValues() : Object {
        {
            out_string("Testing integers: ");
            out_int(123);
            out_string("\n");
            out_string("Testing booleans: ");
            if true then
                out_string("true")
            else
                out_string("false")
            fi;
            out_string("\n");
            self;
        }
    };
};

(* Classe para testar chamadas de metodo *)
class MethodCallTest {
    obj : BaseClass;
    
    testMethodCalls() : Int {
        {
            obj <- new BaseClass;
            obj.setValues(1, 2, true);
            obj.getValue();
        }
    };
    
    (* Teste de chamada em cadeia *)
    testChainedCalls() : String {
        "Hello".concat(" ").concat("World")
    };
};

(* Classe para testar blocos *)
class BlockTest {
    (* Teste de bloco com multiplas expressoes *)
    testBlock() : Int {
        {
            let x : Int <- 10 in x;
            let y : Int <- 20 in y;
            let z : Int <- 30 in z;
            100;
        }
    };
    
    (* Teste de bloco vazio *)
    testEmptyReturn() : Object {
        {
            self;
        }
    };
};

(* Classe para testar strings *)
class StringTest {
    str : String <- "default";
    
    testStrings() : String {
        {
            str <- "Test string with spaces";
            str <- "String with\nnewline";
            str <- "String with\ttab";
            str <- "";
            str.concat(" concatenated");
        }
    };
    
    testStringMethods() : Int {
        {
            let s : String <- "Hello" in
            {
                s.length();
                s.concat(" World");
                s.substr(0, 1);
                0;
            };
        }
    };
};

(* Classe para testar numeros e operadores *)
class NumberTest {
    (* Teste de literais inteiros *)
    testIntegers() : Int {
        {
            let n1 : Int <- 0 in n1;
            let n2 : Int <- 1 in n2;
            let n3 : Int <- 123 in n3;
            let n4 : Int <- 999999 in n4;
            42;
        }
    };
    
    (* Teste de todas operacoes aritmeticas *)
    testAllArithmetic(a : Int, b : Int) : Int {
        {
            a + b;
            a - b;
            a * b;
            a;
        }
    };
    
    (* Teste de comparacoes *)
    testComparisons(x : Int, y : Int) : Bool {
        {
            x = y;
            x < y;
            x <= y;
            true;
        }
    };
};

(* Classe para testar negacao com not *)
class BooleanTest {
    testBoolean(x : Bool, y : Bool) : Bool {
        {
            not x;
            not y;
            not (x = y);
            true;
        }
    };
};

(* Classe Main obrigatoria *)
class Main inherits IO {
    (* Metodo main obrigatorio *)
    main() : Object {
        {
            (* Comentario dentro do main *)
            out_string("Testing COOL lexer\n");
            
            (* Teste de criacao de objetos com new *)
            let base : BaseClass <- new BaseClass,
                derived : DerivedClass <- new DerivedClass,
                conditional : ConditionalTest <- new ConditionalTest,
                loop_test : LoopTest <- new LoopTest,
                let_test : LetTest <- new LetTest,
                case_test : CaseTest <- new CaseTest,
                void_test : VoidTest <- new VoidTest,
                new_test : NewTest <- new NewTest,
                io_test : IOTest <- new IOTest,
                method_test : MethodCallTest <- new MethodCallTest,
                block_test : BlockTest <- new BlockTest,
                string_test : StringTest <- new StringTest,
                number_test : NumberTest <- new NumberTest,
                bool_test : BooleanTest <- new BooleanTest
            in
            {
                (* Usando self *)
                self.out_string("All tests completed\n");
                
                (* Retornando self *)
                self;
            };
        }
    };
};
