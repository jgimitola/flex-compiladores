/* DECLARACIONES */
%{
    #include <string.h>

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
    void imprimirTablaERR();
%}

/* DEFINICIONES REGULARES */

CARACTERES_BLANCOS [ \t\n]+
DIGITO			[0-9]
LETRA			[a-zA-Z]
SIGNO           "+"|"-"

IDENTIFICADOR	{LETRA}({LETRA}|{DIGITO})*
CTE-ENT         {SIGNO}?{DIGITO}+
CTE-ENT-ERR     {CTE-ENT}{LETRA}+
EXPONENTE       ("E"|"e"){CTE-ENT}     
PARTE-DECIMAL   \.{CTE-ENT}
CTE-REAL        {CTE-ENT}{PARTE-DECIMAL}?{EXPONENTE}?
CTE-CADENA      \"(\\\")*[^(\")]+(\\\")*\"
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
OP-MULT         "*"
OP-SUM          "+"
OP-SUST         "-"
OP-DIV          "/"
OP-ASIGN        "="
OP-MOD          "%"

/* Operadores aritmeticos especiales */
OP-MASMAS       "++"
OP-MENOSMENOS   "--"
OP-MASASIGN     "+="
OP-MENOSASIGN   "-="
OP-PORASIGN     "*="
OP-ENTREASIGN   "/="

/* Operadores Relacionales */
OP-IGUAL        "=="
OP-MENORIGUAL   "<="
OP-MAYORIGUAL   ">="
OP-DIFERENTE    "<>"|"!="
OP-MAYOR        ">"
OP-MENOR        "<"

/* Operadores Logicos */
OP-Y            "&&"
OP-O            "||"
OP-NO           "!"

/* Delimitadores */
LLAVE-A         "{"
LLAVE-C         "}"
CORCHETE-A      "["
CORCHETE-C      "]"
PARENT-A        "("
PARENT-C        ")"
PUNTO-COMA      ";"

/* REGLAS */
%%
{COMENTARIO}            { fprintf(yyout, "Comentario= %s ", yytext); }
{PUBLIC}				{ fprintf(yyout, "PUBLIC "); }
{PRIVATE}				{ fprintf(yyout, "PRIVATE "); }
{CLASS}					{ fprintf(yyout, "CLASS "); }
{STATIC}				{ fprintf(yyout, "STATIC "); }
{VOID}					{ fprintf(yyout, "VOID "); }
{NEW}					{ fprintf(yyout, "NEW "); }
{IF}					{ fprintf(yyout, "IF "); }
{ELSE}					{ fprintf(yyout, "ELSE "); }
{FOR}					{ fprintf(yyout, "FOR "); }
{WHILE}					{ fprintf(yyout, "WHILE "); }
{CHAR}					{ fprintf(yyout, "CHAR "); }
{STRING}				{ fprintf(yyout, "STRING "); }
{INT}					{ fprintf(yyout, "INT "); }
{DOUBLE}				{ fprintf(yyout, "DOUBLE "); }
{OP-MULT}               { fprintf(yyout, "Op-mult= %s ", yytext); }
{OP-SUM}                { fprintf(yyout, "Op-sum= %s ", yytext); }
{OP-SUST}               { fprintf(yyout, "Op-sust= %s ", yytext); }
{OP-DIV}                { fprintf(yyout, "Op-div= %s ", yytext); }
{OP-ASIGN}              { fprintf(yyout, "Op-asig= %s ", yytext); }
{OP-MOD}                { fprintf(yyout, "Op-mod= %s ", yytext); }
{OP-MASMAS}             { fprintf(yyout, "Op-MasMas= %s ", yytext); }
{OP-MENOSMENOS}         { fprintf(yyout, "Op-MenosMenos= %s ", yytext); }
{OP-MASASIGN}           { fprintf(yyout, "Op-MasAsign= %s ", yytext); }
{OP-MENOSASIGN}         { fprintf(yyout, "Op-MenosAsign= %s ", yytext); }
{OP-PORASIGN}           { fprintf(yyout, "Op-PorAsign= %s ", yytext); }
{OP-ENTREASIGN}         { fprintf(yyout, "Op-DivAsign= %s ", yytext); }
{OP-IGUAL}              { fprintf(yyout, "Op-Igual= %s ", yytext); }
{OP-MENORIGUAL}         { fprintf(yyout, "Op-MenorIgual= %s ", yytext); }
{OP-MAYORIGUAL}         { fprintf(yyout, "Op-MayorIgual= %s ", yytext); }
{OP-DIFERENTE}          { fprintf(yyout, "Op-Diferente= %s ", yytext); }
{OP-MAYOR}              { fprintf(yyout, "Op-Mayor= %s ", yytext); }
{OP-MENOR}              { fprintf(yyout, "Op-Menor= %s ", yytext); }
{OP-Y}                  { fprintf(yyout, "Op-Y= %s ", yytext); }
{OP-O}                  { fprintf(yyout, "Op-O= %s ", yytext); }
{OP-NO}                 { fprintf(yyout, "Op-No= %s ", yytext); }
{LLAVE-A}               { fprintf(yyout, "Llave-a= %s ", yytext); }
{LLAVE-C}               { fprintf(yyout, "Llave-c= %s ", yytext); }
{CORCHETE-A}            { fprintf(yyout, "Corchete-a= %s ", yytext); }
{CORCHETE-C}            { fprintf(yyout, "Corchete-c= %s ", yytext); }
{PARENT-A}              { fprintf(yyout, "Parent-a= %s ", yytext); }
{PARENT-C}              { fprintf(yyout, "Parent-c= %s ", yytext); }
{PUNTO-COMA}            { fprintf(yyout, "Punto-coma= %s ", yytext); }
{CTE-ENT-ERR}           { fprintf(yyout, " ERROR_LEXICO=%s ", yytext); addErrToList(yytext); }
{IDENTIFICADOR}			{ fprintf(yyout, "Id=%s ", yytext); addIdToList(yytext); }
{CTE-ENT}               { fprintf(yyout, "Cte-ent= %s ", yytext); }
{CTE-REAL}              { fprintf(yyout, "Cte-real= %s ", yytext); }
{CTE-CADENA}            { fprintf(yyout, "Cte-cadena= %s ", yytext); }
{CARACTERES_BLANCOS}+	{ ECHO; }
.						{ fprintf(yyout, " ERROR_LEXICO=%s ", yytext); addErrToList(yytext); }
<<EOF>> 				{ fprintf(yyout, "\n\nTABLA DE IDENTIFICADORES\n"); fprintf(yyout, "Hay %d identificadores | Ocurrieron %d errores\n", num_identificadores, num_errores); imprimirTablaID(); imprimirTablaERR(); return 0; } // Detenemos el programa al final del archivo
%%

/* FUNCIONES AUXILIARES */

void addIdToList(char* text) {
    Nodo_t* p = ptrId;

    int repetido = 0;

    while (!repetido && p != NULL) {
        repetido = strcmp(p->id, text) == 0;       
        p = p->sgte;
    }

    if (!repetido) {
        if (ptrId == NULL) {
            ptrId = (Nodo_t*) malloc(sizeof(Nodo_t));
            ptrId->id = malloc(strlen(text) + 1);
            strcpy(ptrId->id, text);  
            ptrId->sgte = NULL;
            ultId = ptrId;
        } else {
            Nodo_t* nId = (Nodo_t*) malloc(sizeof(Nodo_t));
            nId->id = malloc(strlen(text) + 1);
            strcpy(nId->id, text); 
            nId->sgte = NULL;
            ultId->sgte = nId;
            ultId = nId; 
        }
        num_identificadores++;
    }      
}

void addErrToList(char* text) {
    Nodo_t* p = ptrError;
    
    if (ptrError == NULL) {
        ptrError = (Nodo_t*) malloc(sizeof(Nodo_t));
        ptrError->id = malloc(strlen(text) + 1);
        strcpy(ptrError->id, text);  
        ptrError->sgte = NULL;
        ultError = ptrError;
    } else {
        Nodo_t* nId = (Nodo_t*) malloc(sizeof(Nodo_t));
        nId->id = malloc(strlen(text) + 1);
        strcpy(nId->id, text); 
        nId->sgte = NULL;
        ultError->sgte = nId;
        ultError = nId; 
    }
    num_errores++;
        
}

void imprimirTablaID() {
    Nodo_t* p = ptrId;
    Nodo_t* a = NULL;    
    while (p != NULL) {        
        sprintf(buff, "Id=%s, ", p->id);        
        strcat(lista_id, buff);        
        a = p;        
        p = p->sgte;   
        free(a);
    }    
    fprintf(yyout, "%s\n", lista_id);
}

void imprimirTablaERR() {
    Nodo_t* p = ptrError;
    Nodo_t* a = NULL;
    while (p != NULL) {        
        sprintf(buff2, "ERROR_LEXICO=%s, ", p->id);
        strcat(lista_err, buff2);        
        a = p;        
        p = p->sgte;   
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
