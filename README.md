# Prefix-notation-with-SML

This is the code to write both prefix and infix notation by using SML language.

prefix notation will follow this rule
<SET> ::= "{"{<EXP>)*}"}" | SCOMP
<SCOMP> ::= "(""+"<SET><SET>{<SET>}*")" |
"(""-"<SET><SET>{<SET>}*")" |
"(""*"<SET><SET>{<SET>}*")"
<EXP> ::= non-negative integer  | <COMP> | <FUNC>
<COMP> ::= "(""+"<EXP><EXP>{<EXP>}*")" |
"(""-"<EXP><EXP>{<EXP>}*")" |
"(""*"<EXP><EXP>{<EXP>}*")" | "(""/"<EXP><EXP>{<EXP>}*")"
<FUNC> ::= "(""fact"<EXP>")" | "(""fibo"<EXP>")"


while infix notation will follow this rule
<EXP> ::= <TERM>{{"+"|"-"}<TERM>}*
<TERM> ::= <BASE>{{"*"|"/"}<BASE>}*
<BASE> ::= non-negative integer | "("<EXP>")" | <FUNC>
<FUNC> ::= "fact"<EXP> | "fibo"<EXP>
