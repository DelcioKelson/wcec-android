%{
  open Ast
%}

%token <string> STRING
%token <float> FLOAT

%token VERTICALBAR
%token EOF

%start file

%type <Ast.stmt> file

%%

file:
| b = nonempty_list(stmt) EOF { Sline b }
;

stmt:
| inst = STRING VERTICALBAR  v = FLOAT
        {Inst (inst , v) }