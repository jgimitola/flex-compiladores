/* DECLARACIONES */
%{
	int num_errores = 0;
	int num_identificadores = 0;	
%}

/* DEFINICIONES REGULARES */

DIGITO			[0-9]
LETRA			[a-zA-Z]
CARACTERES_BLANCOS [ \t\n]+

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

/* */
IDENTIFICADOR	{LETRA}({LETRA}|{DIGITO})*

/* REGLAS */
%%
{PUBLIC}				{ fprintf(yyout, "PUBLIC"); }
{PRIVATE}				{ fprintf(yyout, "private"); }
{CLASS}					{ fprintf(yyout, "class"); }
{STATIC}				{ fprintf(yyout, "static"); }
{VOID}					{ fprintf(yyout, "void"); }
{NEW}					{ fprintf(yyout, "new"); }
{IF}					{ fprintf(yyout, "if"); }
{ELSE}					{ fprintf(yyout, "else"); }
{FOR}					{ fprintf(yyout, "for"); }
{WHILE}					{ fprintf(yyout, "while"); }
{CHAR}					{ fprintf(yyout, "char"); }
{STRING}				{ fprintf(yyout, "String"); }
{INT}					{ fprintf(yyout, "int"); }
{DOUBLE}				{ fprintf(yyout, "double"); }
{IDENTIFICADOR}			{ fprintf(yyout, " Id=%s ", yytext); num_identificadores++; }
{CARACTERES_BLANCOS}+	{ ECHO; }
.						{ fprintf(yyout, " ERROR_LEXICO=%s ", yytext); num_errores++; }
<<EOF>> 				{ fprintf(yyout, "\n\nTABLA DE IDENTIFICADORES\n"); fprintf(yyout, "Hay %d identificadores | Ocurrieron %d errores\n", num_identificadores, num_errores); return 0; } // Detenemos el programa al final del archivo
%%

/* FUNCIONES AUXILIARES */
int yywrap() {}
int main() {	
	char filename[50];
	printf("Escriba nombre de archivo (prueba.extension): \n");
	scanf("%s", filename);
	
	yyin = fopen(filename, "r"); // Archivo de entrada
	yyout = fopen("salida.txt", "w"); // Archivo de salida

	yylex();	
	return 0;
}
