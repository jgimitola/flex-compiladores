%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern FILE * yyin;
extern FILE * yyout;
extern int yylineno;
extern char *yytext;
extern int linea;
int errores = 0;
void yyerror(const char *s);
%}

%token COMENTARIO
%token PUBLIC
%token PRIVATE
%token CLASS
%token STATIC
%token VOID
%token NEW
%token IF
%token ELSE
%token FOR
%token WHILE
%token CHAR
%token STRING
%token INT
%token DOUBLE
%token OP_MULT
%token OP_SUM
%token OP_SUST
%token OP_DIV
%token OP_ASIGN
%token OP_MOD
%token OP_MASMAS
%token OP_MENOSMENOS
%token OP_MASASIGN
%token OP_MENOSASIGN
%token OP_PORASIGN
%token OP_ENTREASIGN
%token OP_IGUAL
%token OP_MENORIGUAL
%token OP_MAYORIGUAL
%token OP_DIFERENTE
%token OP_MAYOR
%token OP_MENOR
%token OP_Y
%token OP_O
%token OP_NO
%token LLAVE_A
%token LLAVE_C
%token CORCHETE_A
%token CORCHETE_C
%token PARENT_A
%token PARENT_C
%token PUNTO_COMA
%token COMA
%token IDENTIFICADOR
%token CTE_ENT
%token CTE_REAL
%token CTE_CADENA


%start INICIO

%%
    INICIO: 
        PUBLIC CLASS IDENTIFICADOR LLAVE_A CUERPOCLASE LLAVE_C 
        | PRIVATE CLASS IDENTIFICADOR LLAVE_A CUERPOCLASE LLAVE_C 
        | COMENTARIO INICIO
        | error {yyerrok; yyclearin;}
        |
        ;
    
        
    CUERPOCLASE: 
        DECGLOBAL CUERPOCLASE         
        | DECMETODOS CUERPOCLASE
        | COMENTARIO CUERPOCLASE
        |
        ;
        

    DECGLOBAL: 
        MODIFICADOR DECVAR PUNTO_COMA
        
        ;

        
    DECMETODOS:        
        MODIFICADOR TIPO IDENTIFICADOR PARENT_A PARAMETROS PARENT_C LLAVE_A BLOQUE LLAVE_C
        | MODIFICADOR VOID IDENTIFICADOR PARENT_A PARAMETROS PARENT_C LLAVE_A BLOQUE LLAVE_C
        
        
        
    


    PARAMETROS:
        TIPO IDENTIFICADOR
        | DECARRAYSININICIAR
        | TIPO IDENTIFICADOR COMA PARAMETROS    
        | DECARRAYSININICIAR COMA PARAMETROS
        |
        ;
        
        


    BLOQUE:
        DECVAR PUNTO_COMA BLOQUE
        | DECARRAYSININICIAR PUNTO_COMA BLOQUE
        | DECARRAYS PUNTO_COMA BLOQUE
        | ASIGNVARIABLE PUNTO_COMA BLOQUE
        | COMENTARIO BLOQUE
        | CICLO_FOR BLOQUE
        | CICLO_WHILE BLOQUE
        | CONDICIONAL_IF BLOQUE        
        |
        ;     
        
    


    DECVAR:    
        TIPO MULTIID 

    MULTIID:
        IDENTIFICADOR
        | IDENTIFICADOR OP_ASIGN OPERACION 
        | IDENTIFICADOR COMA MULTIID       
        | IDENTIFICADOR OP_ASIGN OPERACION COMA MULTIID

    ASIGNVARIABLE:        
        IDENTIFICADOR ASIGNACION OPERACION
        ;
        
            
        


    DECARRAYSININICIAR:
        TIPO IDENTIFICADOR CORCHETE_A CORCHETE_C  
        | TIPO CORCHETE_A CORCHETE_C IDENTIFICADOR 
        | TIPO IDENTIFICADOR CORCHETE_A CORCHETE_C CORCHETE_A CORCHETE_C   
        | TIPO CORCHETE_A CORCHETE_C CORCHETE_A CORCHETE_C IDENTIFICADOR ;
        


    DECARRAYS:
        TIPO IDENTIFICADOR CORCHETE_A CORCHETE_C INICIARARRAY      
        | TIPO CORCHETE_A CORCHETE_C IDENTIFICADOR INICIARARRAY 
        | TIPO IDENTIFICADOR CORCHETE_A CORCHETE_C CORCHETE_A CORCHETE_C INICIARMATRIZ     
        | TIPO CORCHETE_A CORCHETE_C CORCHETE_A CORCHETE_C IDENTIFICADOR INICIARMATRIZ 
        | IDENTIFICADOR INICIARARRAY
        | IDENTIFICADOR INICIARMATRIZ
        

    INICIARARRAY:
        OP_ASIGN NEW TIPO CORCHETE_A CONSTANTE CORCHETE_C
        ;
    INICIARMATRIZ:
        OP_ASIGN NEW TIPO CORCHETE_A CONSTANTE CORCHETE_C CORCHETE_A CONSTANTE CORCHETE_C 
        ;

    CICLO_FOR:
        FOR PARENT_A ARG1FOR PUNTO_COMA ARG2FOR PUNTO_COMA ARG3FOR PARENT_C LLAVE_A BLOQUE LLAVE_C
        
    ARG1FOR:
        TIPO IDENTIFICADOR ASIGNACION OPERACION
        | IDENTIFICADOR ASIGNACION OPERACION

    ARG2FOR:
        OPERADORES OPIGUALDADES OPERADORES
    
    ARG3FOR:
        IDENTIFICADOR ASIGNACION OPERACION
        | IDENTIFICADOR INCREMENTOS
    
    CICLO_WHILE:
        WHILE PARENT_A CONDICION PARENT_C LLAVE_A BLOQUE LLAVE_C
       
        
    CONDICIONAL_IF:
        IF PARENT_A CONDICION PARENT_C LLAVE_A BLOQUE LLAVE_C
        | IF PARENT_A CONDICION PARENT_C LLAVE_A BLOQUE LLAVE_C ELSE LLAVE_A BLOQUE LLAVE_C
        
    


    TIPO: 
        CHAR 
        | STRING 
        | INT 
        | DOUBLE

    MODIFICADOR: 
        PUBLIC PERTENECECLASE 
        | PRIVATE PERTENECECLASE 
        | PERTENECECLASE 
        ;

    PERTENECECLASE:
        STATIC
        | 
        ;

    ASIGNACION:
        OP_ASIGN
        | OP_MASASIGN
        | OP_MENOSASIGN
        | OP_ENTREASIGN
        | OP_PORASIGN
    
    OPERACION:
        PARENT_A OPERACION PARENT_C OPERACION2
        | OPERADORES OPERACION2
        
    OPERACION2:
        OPOPERACION OPERACION
        |
        ;   
    
    CONDICION:
        IGUALDAD CONDICION2
        | IDENTIFICADOR CONDICION2
        | OP_NO IDENTIFICADOR CONDICION2
        | OP_NO PARENT_A IGUALDAD PARENT_C CONDICION2
    
    CONDICION2:
        OP_LOGICOS CONDICION
        |
        ;



    IGUALDAD:        
        PARENT_A IGUALDAD PARENT_C IGUALDAD2
        | OPERACION IGUALDAD2
        | PARENT_A IGUALDAD PARENT_C

    
    IGUALDAD2:
        OPIGUALDADES IGUALDAD
        | 
        OPIGUALDADES OPERADORES

    
    OPOPERACION:
        OP_SUM
        | OP_MULT
        | OP_SUST
        | OP_DIV
        | OP_MOD

    OPIGUALDADES:
        OP_DIFERENTE
        | OP_IGUAL
        | OP_MAYOR
        | OP_MENOR
        | OP_MENORIGUAL
        | OP_MAYORIGUAL
    
    INCREMENTOS:
        OP_MASMAS
        | OP_MENOSMENOS

    OPERADORES:
        IDENTIFICADOR
        | OP_SUM NUMEROS
        | OP_SUST NUMEROS
        | CONSTANTE

    CONSTANTE:        
        CTE_CADENA
        | NUMEROS
    
    NUMEROS:
        CTE_ENT
        | CTE_REAL
        
    OP_LOGICOS:
        OP_Y
        | 
        OP_O


%%

void yyerror(const char *s){
    fprintf(yyout, "\nError sintactico en la linea numero: %d", linea+1);
    fprintf(stderr, "\nError sintactico en la linea numero: %d", linea+1);
    errores++;
}

int main(int argc, char *argv[]){    
    if (argc==2) {
        yyin = fopen(argv[1], "r");
        yyout = fopen("saliday.txt", "w");
        
        if (yyin == NULL) {
            printf("No se pudo abrir el archivo %s \n", argv[1]);
            exit(-1);
        }else{            
            while(!feof(yyin)){                
                yyparse();               
            }
            if(errores == 0 ){
                fprintf(yyout, "\nPrueba con el archivo de entrada \nBien\n");
                fprintf(stderr, "\nPrueba con el archivo de entrada \nBien\n");
            }else{
                fprintf(yyout, "\nEl archivo de entrada tiene %d errores sintacticos. \n",errores);
                fprintf(stderr,"\nEl archivo de entrada tiene %d errores sintacticos. \n",errores);
            }
        }
    }
}
