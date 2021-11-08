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
        MODIFICADOR CLASS IDENTIFICADOR LLAVE_A CUERPOCLASE LLAVE_C 
        | COMENTARIO INICIO
        | error {yyerrok;yyclearin;} 
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
        | error {yyerrok;yyclearin;} 
        ;

        
    DECMETODOS:        
        MODIFICADOR TIPO IDENTIFICADOR PARENT_A PARAMETROS PARENT_C LLAVE_A BLOQUE LLAVE_C
        | MODIFICADOR VOID IDENTIFICADOR PARENT_A PARAMETROS PARENT_C LLAVE_A BLOQUE LLAVE_C
        
        
    


    PARAMETROS:
        TIPO IDENTIFICADOR
        | DECARRAYSININICIAR
        | TIPO IDENTIFICADOR COMA PARAMETROS    
        | DECARRAYSININICIAR COMA PARAMETROS
        
        


    BLOQUE:
        DECVAR PUNTO_COMA BLOQUE ;
        | DECARRAYSININICIAR PUNTO_COMA BLOQUE ;
        | DECARRAYS PUNTO_COMA BLOQUE ;
        | ASIGNVARIABLE PUNTO_COMA BLOQUE ;
        | COMENTARIO BLOQUE ;
        |
        ;     
        
    


    DECVAR:
        TIPO MULTIID        
        ;
    
    MULTIID:
        IDENTIFICADOR
        | IDENTIFICADOR OP_ASIGN CONSTANTE
        | IDENTIFICADOR COMA MULTIID
        | IDENTIFICADOR OP_ASIGN CONSTANTE COMA MULTIID

    ASIGNVARIABLE:        
        IDENTIFICADOR ASIGNACION ARITMETICA
        | IDENTIFICADOR ASIGNACION IGUALDAD
            
        


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
        

    INICIARARRAY:
        OP_ASIGN NEW TIPO CORCHETE_A CONSTANTE CORCHETE_C
        ;
    INICIARMATRIZ:
        OP_ASIGN NEW TIPO CORCHETE_A CONSTANTE CORCHETE_C CORCHETE_A CONSTANTE CORCHETE_C 
        ;

    CONSTANTE:
        CTE_CADENA
        | CTE_ENT
        | CTE_REAL
        


    TIPO: 
        CHAR 
        | STRING 
        | INT 
        | DOUBLE
        ;

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
    
    ARITMETICA:        
        OPERADORES OPARITMETICA OPERADORES
        | PARENT_A ARITMETICA PARENT_C
        | OPERADORES
    
        

    IGUALDAD:
        OPERADORES OPIGUALDADES OPERADORES
    
    OPARITMETICA:
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
    
    OPERADORES:
        IDENTIFICADOR
        | CONSTANTE

    
    


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
