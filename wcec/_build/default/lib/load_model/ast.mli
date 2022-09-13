type stmt =
  | Inst of string * float * float
  | Sline of stmt list
