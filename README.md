# Prefix-notation-with-SML

This is the code to write both prefix and infix notation by using SML language.

prefix notation will follow this rule
- &lt;SET&gt; ::= "{"{&lt;EXP&gt;)*}"}" | SCOMP
- &lt;SCOMP&gt; ::= "(""+"&lt;SET&gt;&lt;SET&gt;{&lt;SET&gt;}*")" |
  "(""-"&lt;SET&gt;&lt;SET&gt;{&lt;SET&gt;}*")" |
  "(""*"&lt;SET&gt;&lt;SET&gt;{&lt;SET&gt;}*")"
- &lt;EXP&gt; ::= non-negative integer  | &lt;COMP&gt; | &lt;FUNC&gt;
- &lt;COMP&gt; ::= "(""+"&lt;EXP&gt;&lt;EXP&gt;{&lt;EXP&gt;}*")" |
  "(""-"&lt;EXP&gt;&lt;EXP&gt;{&lt;EXP&gt;}*")" |
  "(""*"&lt;EXP&gt;&lt;EXP&gt;{&lt;EXP&gt;}*")" | "(""/"&lt;EXP&gt;&lt;EXP&gt;{&lt;EXP&gt;}*")"
- &lt;FUNC&gt; ::= "(""fact"&lt;EXP&gt;")" | "(""fibo"&lt;EXP&gt;")"



while infix notation will follow this rule
- <EXP> ::= <TERM>{{"+"|"-"}<TERM>}*
- <TERM> ::= <BASE>{{"*"|"/"}<BASE>}*
- <BASE> ::= non-negative integer | "("<EXP>")" | <FUNC>
- <FUNC> ::= "fact"<EXP> | "fibo"<EXP>
