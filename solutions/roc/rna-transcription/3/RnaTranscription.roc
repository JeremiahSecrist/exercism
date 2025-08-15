module [to_rna]

to_rna : Str -> Str
to_rna = |dna|
    # is given empty list as state and char converts and merges
    step : Str, U8 -> Str
    step =  |acc,char| Str.concat(acc, (when char is
            'G' -> "C"
            'C' -> "G"
            'T' -> "A"
            'A' -> "U"
            _   -> ""
            ))
    # walking function that applies the step giving the empty str as init state
    dna |> Str.walk_utf8("", step)
