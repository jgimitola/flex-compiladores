/* DECLARACIONES */
%{
    #include <string.h>

    int num_errores = 0;
    int num_identificadores = 0;	
    char lista_id[10000];
    char buff[10000];

    typedef struct Nodo {
        char* id;
        struct Nodo* sgte;
    } Nodo_t;
    
    Nodo_t* ptr = NULL;
    Nodo_t* ult = NULL;   
  
    void añadirId(char* text);
    void imprimirTabla();
%}

/* DEFINICIONES REGULARES */

CARACTERES_BLANCOS [ \t\n]+
DIGITO			[0-9]
LETRA			[a-zA-Z]
SIGNO           "+"|"-"

IDENTIFICADOR	{LETRA}({LETRA}|{DIGITO})*
CTE-ENT         {SIGNO}?{DIGITO}+
EXPONENTE       ("E"|"e"){CTE-ENT}     
PARTE-DECIMAL   \.{CTE-ENT}
CTE-REAL        {CTE-ENT}{PARTE-DECIMAL}?{EXPONENTE}?
CTE-CADENA      \".+\"

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
{PUBLIC}				{ fprintf(yyout, "PUBLIC"); }
{PRIVATE}				{ fprintf(yyout, "PRIVATE"); }
{CLASS}					{ fprintf(yyout, "CLASS"); }
{STATIC}				{ fprintf(yyout, "STATIC"); }
{VOID}					{ fprintf(yyout, "VOID"); }
{NEW}					{ fprintf(yyout, "NEW"); }
{IF}					{ fprintf(yyout, "IF"); }
{ELSE}					{ fprintf(yyout, "ELSE"); }
{FOR}					{ fprintf(yyout, "FOR"); }
{WHILE}					{ fprintf(yyout, "WHILE"); }
{CHAR}					{ fprintf(yyout, "CHAR"); }
{STRING}				{ fprintf(yyout, "STRING"); }
{INT}					{ fprintf(yyout, "INT"); }
{DOUBLE}				{ fprintf(yyout, "DOUBLE"); }
{IDENTIFICADOR}			{ fprintf(yyout, " Id=%s ", yytext); añadirId(yytext); }
{CARACTERES_BLANCOS}+	{ ECHO; }
.						{ fprintf(yyout, " ERROR_LEXICO=%s ", yytext); num_errores++; }
<<EOF>> 				{ fprintf(yyout, "\n\nTABLA DE IDENTIFICADORES\n"); fprintf(yyout, "Hay %d identificadores | Ocurrieron %d errores\n", num_identificadores, num_errores); imprimirTabla(); return 0; } // Detenemos el programa al final del archivo
%%

/* FUNCIONES AUXILIARES */

void añadirId(char* text) {   
    Nodo_t* p = ptr;
    int repetido = 0;

    while (!repetido && p != NULL) {
        repetido = strcmp(p->id, text) == 0;       
        p = p->sgte;
    }

    if (!repetido) {
        if (ptr == NULL) {
            ptr = (Nodo_t*) malloc(sizeof(Nodo_t));
            ptr->id = malloc(strlen(text) + 1);
            strcpy(ptr->id, text);  
            ptr->sgte = NULL;
            ult = ptr;
        } else {
            Nodo_t* nId = (Nodo_t*) malloc(sizeof(Nodo_t));
            nId->id = malloc(strlen(text) + 1);
            strcpy(nId->id, text); 
            nId->sgte = NULL;
            ult->sgte = nId;
            ult = nId; 
        }
        num_identificadores++;          
    }    
} 

void imprimirTabla() {
    Nodo_t* p = ptr;
    Nodo_t* a = NULL;    
    while (p != NULL) {        
        sprintf(buff, "Id=%s, ", p->id);
        strcat(lista_id, buff);        
        a = p;        
        p = p->sgte;   
        free(a);
    }    
    fprintf(yyout, "%s", lista_id);
}

int yywrap() {}
int main(int argc, char* argv[]) {	
    //char filename[50];
    //printf("Escriba nombre de archivo (prueba.extension): \n");
    //scanf("%s", filename);
    
    yyin = fopen(argv[1], "r"); // Archivo de entrada
    yyout = fopen("salida.txt", "w"); // Archivo de salida

    yylex();	
    return 0;
}
