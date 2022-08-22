%{
  open Ast
%}

%token <string> STRING

%token EQUAL
%token EOF

%start file

%type <Ast.edge> file

%%

file:
| cg = nonempty_list(edge) EOF { Cg cg }
;

edge:
| from = STRING EQUAL  node = STRING
        {Edge (from , node) }