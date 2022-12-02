type stmt =
  | Inst of string * float * float
  | Lines of stmt list
