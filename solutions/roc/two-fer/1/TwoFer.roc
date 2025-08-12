module [two_fer]

two_fer : [Name Str, Anonymous] -> Str
two_fer = |name|
    when name is
        Name(x) -> "One for $(x), one for me."
        _ -> "One for you, one for me."
         
