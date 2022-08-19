%{
  open Ast
%}

%token <Ast.constant> CST
%token <Ast.binop> CMP
%token <string> IDENT
%token LABEL IF AND OR NOT GOTO
%token EOF
%token LSQ RSQ APOST COMPOINT COMMA EQUAL NEWLINE
%token PLUS MINUS TIMES DIV MOD BEQ BNEQ BLT BLE BGT BGE

/* Definição das prioridades e associatividades dos tokens */

%left OR
%left AND
%nonassoc NOT
%nonassoc CMP
%left PLUS MINUS
%left TIMES DIV MOD
%nonassoc unary_minus

/* Ponto de entrada da gramática */
%start file

/* Tipo dos valores devolvidos pelo analizador sintáctico */
%type <Ast.file> file

%%

file:
| b = stmt EOF { Sblock b }
;

expr:
| c = CST
    { Ecst c }
| id = ident
    { Eident id }
| MINUS e1 = expr %prec unary_minus
    { Eunop (Uneg, e1) }
| NOT e1 = expr
    { Eunop (Unot, e1) }
| e1 = expr BEQ e2 = expr
    { Ebinop (Beq, e1, e2) }
| e1 = expr BNEQ e2 = expr
    { Ebinop (Bneq, e1, e2) }
| e1 = expr BLT e2 = expr
    { Ebinop (Blt, e1, e2) }
| e1 = expr BLE e2 = expr
    { Ebinop (Ble, e1, e2) }   
| e1 = expr BGT e2 = expr
    { Ebinop (Bgt, e1, e2) }   
| e1 = expr BGE e2 = expr
    { Ebinop (Bge, e1, e2) } 
| e1 = expr o=binop e2 = expr
    { Ebinop (o, e1, e2) }   
; 

stmt:
| APOST c1 = CST APOST LSQ LABEL EQUAL APOST id1 = ident IF c = expr GOTO id2 = ident APOST COMMA RSQ COMPOINT s = stmt APOST c2 = CST APOST LSQ LABEL EQUAL APOST GOTO id3 = ident APOST COMMA RSQ COMPOINT NEWLINE
        {Sgoto (id1,s) }
| APOST c = CST APOST LSQ LABEL EQUAL APOST id = ident EQUAL s = expr APOST COMMA RSQ COMPOINT NEWLINE
        {Sassign (id,s) }


%inline binop:
| PLUS  { Badd }
| MINUS { Bsub }
| TIMES { Bmul }
| DIV   { Bdiv }
| MOD   { Bmod }
| c=CMP { c    }
| AND   { Band }
| OR    { Bor  }
;

ident:
  id = IDENT { id }
;
