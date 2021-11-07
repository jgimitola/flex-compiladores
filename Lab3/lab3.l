/* DECLARACIONES */
%{
	#include "y.tab.h"
	#include<stdio.h>
	int linea = 0;
    

   /* #include <string.h>

    int num_errores = 0;
    int num_identificadores = 0;	
    char lista_id[10000];
    char lista_err[10000];
    char buff[10000];
    char buff2[10000];

    typedef struct Nodo {
        char* id;
        struct Nodo* sgte;
    } Nodo_t;
    
    Nodo_t* ptrId = NULL;
    Nodo_t* ultId = NULL;   
    Nodo_t* ptrError = NULL;
    Nodo_t* ultError = NULL;   
  
    void addIdToList(char* text);
    void addErrToList(char* text);
    void imprimirTablaID();
    void imprimirTablaERR();*/
%}

%option noyywrap

/* DEFINICIONES REGULARES */


DIGITO			[0-9]
LETRA			[a-zA-Z]
SIGNO           "+"|"-"

IDENTIFICADOR	{LETRA}({LETRA}|{DIGITO})*
CTE_ENT         {SIGNO}?{DIGITO}+
CTE_ENT_ERR     {CTE_ENT}{LETRA}+
EXPONENTE       ("E"|"e"){CTE_ENT}     
PARTE_DECIMAL   \.{CTE_ENT}
CTE_REAL        {CTE_ENT}{PARTE_DECIMAL}?{EXPONENTE}?
CTE_CADENA      \"(\\\")*[^(\")]+(\\\")*\"
COMENTARIO      ("/*"(.|\n)*"*/")|("//".*)

/* Palabras Reservadas  */
PUBLIC 			"public"
PRIVATE			"private"
CLASS			"class"
STATIC			"static"
VOID			"void"
NEW				"new"
IF				"if"
ELSE			"else"
FOR				"for"
WHILE			"while"
CHAR			"char"
STRING			"String"
INT				"int"
DOUBLE			"double"

/* Operadores aritmeticos */
OP_MULT         "*"
OP_SUM          "+"
OP_SUST         "-"
OP_DIV          "/"
OP_ASIGN        "="
OP_MOD          "%"

/* Operadores aritmeticos especiales */
OP_MASMAS       "++"
OP_MENOSMENOS   "--"
OP_MASASIGN     "+="
OP_MENOSASIGN   "-="
OP_PORASIGN     "*="
OP_ENTREASIGN   "/="

/* Operadores Relacionales */
OP_IGUAL        "=="
OP_MENORIGUAL   "<="
OP_MAYORIGUAL   ">="
OP_DIFERENTE    "<>"|"!="
OP_MAYOR        ">"
OP_MENOR        "<"

/* Operadores Logicos */
OP_Y            "&&"
OP_O            "||"
OP_NO           "!"

/* Delimitadores */
LLAVE_A         "{"
LLAVE_C         "}"
CORCHETE_A      "["
CORCHETE_C      "]"
PARENT_A        "("
PARENT_C        ")"
PUNTO_COMA      ";"

/* REGLAS */
%%
{COMENTARIO}            { return COMENTARIO;}
{PUBLIC}				{ return PUBLIC;}
{PRIVATE}				{ return PRIVATE;}
{CLASS}					{ return CLASS;}
{STATIC}				{ return STATIC;}
{VOID}					{ return VOID;}
{NEW}					{ return NEW;}
{IF}					{ return IF;}
{ELSE}					{ return ELSE;}
{FOR}					{ return FOR;}
{WHILE}					{ return WHILE;}
{CHAR}					{ return CHAR;}
{STRING}				{ return STRING;}
{INT}					{ return INT;}
{DOUBLE}				{ return DOUBLE;}
{OP_MULT}               { return OP_MULT;}
{OP_SUM}                { return OP_SUM;}
{OP_SUST}               { return OP_SUST;}
{OP_DIV}                { return OP_DIV;}
{OP_ASIGN}              { return OP_ASIGN;}
{OP_MOD}                { return OP_MOD;}
{OP_MASMAS}             { return OP_MASMAS;}
{OP_MENOSMENOS}         { return OP_MENOSMENOS;}
{OP_MASASIGN}           { return OP_MASASIGN;}
{OP_MENOSASIGN}         { return OP_MENOSASIGN;}
{OP_PORASIGN}           { return OP_PORASIGN;}
{OP_ENTREASIGN}         { return OP_ENTREASIGN;}
{OP_IGUAL}              { return OP_IGUAL;}
{OP_MENORIGUAL}         { return OP_MENORIGUAL;}
{OP_MAYORIGUAL}         { return OP_MAYORIGUAL;}
{OP_DIFERENTE}          { return OP_DIFERENTE;}
{OP_MAYOR}              { return OP_MAYOR;}
{OP_MENOR}              { return OP_MENOR;}
{OP_Y}                  { return OP_Y;}
{OP_O}                  { return OP_O;}
{OP_NO}                 { return OP_NO;}
{LLAVE_A}               { return LLAVE_A;}
{LLAVE_C}               { return LLAVE_C;}
{CORCHETE_A}            { return CORCHETE_A;}
{CORCHETE_C}            { return CORCHETE_C;}
{PARENT_A}              { return PARENT_A;}
{PARENT_C}              { return PARENT_C;}
{PUNTO_COMA}            { return PUNTO_COMA;}
{IDENTIFICADOR}			{ return IDENTIFICADOR;}
{CTE_ENT}               { return CTE_ENT;}
{CTE_REAL}              { return CTE_REAL;}
{CTE_CADENA}            { return CTE_CADENA;}
\n						{linea++;}
" "						{;}
\t						{;}

%%
/*
.					{ fprintf(yyout, " ERROR_LEXICO=%s ", yytext); addErrToList(yytext); }
<<EOF>> 				{ fprintf(yyout, "\n\nTABLA DE IDENTIFICADORES\n"); fprintf(yyout, "Hay %d identificadores | Ocurrieron %d errores\n", num_identificadores, num_errores); imprimirTablaID(); imprimirTablaERR(); return 0; } // Detenemos el programa al final del archivo


 FUNCIONES AUXILIARES 

void addIdToList(char* text) {
    Nodo_t* p = ptrId;

    int repetido = 0;

    while (!repetido && p != NULL) {
        repetido = strcmp(p_>id, text) == 0;       
        p = p_>sgte;
    }

    if (!repetido) {
        if (ptrId == NULL) {
            ptrId = (Nodo_t*) malloc(sizeof(Nodo_t));
            ptrId_>id = malloc(strlen(text) + 1);
            strcpy(ptrId_>id, text);  
            ptrId_>sgte = NULL;
            ultId = ptrId;
        } else {
            Nodo_t* nId = (Nodo_t*) malloc(sizeof(Nodo_t));
            nId_>id = malloc(strlen(text) + 1);
            strcpy(nId_>id, text); 
            nId_>sgte = NULL;
            ultId_>sgte = nId;
            ultId = nId; 
        }
        num_identificadores++;
    }      
}

void addErrToList(char* text) {
    Nodo_t* p = ptrError;
    
    if (ptrError == NULL) {
        ptrError = (Nodo_t*) malloc(sizeof(Nodo_t));
        ptrError_>id = malloc(strlen(text) + 1);
        strcpy(ptrError_>id, text);  
        ptrError_>sgte = NULL;
        ultError = ptrError;
    } else {
        Nodo_t* nId = (Nodo_t*) malloc(sizeof(Nodo_t));
        nId_>id = malloc(strlen(text) + 1);
        strcpy(nId_>id, text); 
        nId_>sgte = NULL;
        ultError_>sgte = nId;
        ultError = nId; 
    }
    num_errores++;
        
}

void imprimirTablaID() {
    Nodo_t* p = ptrId;
    Nodo_t* a = NULL;    
    while (p != NULL) {        
        sprintf(buff, "Id=%s, ", p_>id);        
        strcat(lista_id, buff);        
        a = p;        
        p = p_>sgte;   
        free(a);
    }    
    fprintf(yyout, "%s\n", lista_id);
}

void imprimirTablaERR() {
    Nodo_t* p = ptrError;
    Nodo_t* a = NULL;
    while (p != NULL) {        
        sprintf(buff2, "ERROR_LEXICO=%s, ", p_>id);
        strcat(lista_err, buff2);        
        a = p;        
        p = p_>sgte;   
        free(a);
    }    
    fprintf(yyout, "%s\n", lista_err);
}

int yywrap() {}
int main(int argc, char* argv[]) {	 
    
    yyin = fopen(argv[1], "r"); // Archivo de entrada
    yyout = fopen("salida.txt", "w"); // Archivo de salida

    yylex();	
    return 0;
}
*/
