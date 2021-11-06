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
%token IDENTIFICADOR
%token CTE_ENT
%token CTE_REAL
%token CTE_CADENA
%start INICIO

%%
    INICIO: ;



%%

void yyerror(const char *s){
    fprintf(yyout, "Error sintactico en la linea numero: %d", linea+1);
    fprintf(stderr, "Error sintactico en la linea numero: %d", linea+1);
    errores++;
}

int main(int argc, char *argv[]){
    printf("Por lo menos entro");
    if (argc==2) {
        yyin = fopen(argv[1], "r");
        yyout = fopen("salida.txt", "w");
        
        if (yyin == NULL) {
            printf("No se pudo abrir el archivo %s \n", argv[1]);
            exit(-1);
        }else{
            while(!feof(yyin)){
                yyparse();
            }
            if(errores == 0 ){
                fprintf(yyout, "Prueba con el archivo de entrada \n Bien");
                fprintf(stderr, "Prueba con el archivo de entrada \n Bien");
            }
        }
    }
}
