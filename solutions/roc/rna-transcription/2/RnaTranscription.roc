module [to_rna]

dna_to_rna = [("G","1"),("C","2"),("T","3"),("A","4"),("1","C"),("2","G"),("3","A"),("4","U")]
to_rna : Str -> Str
to_rna = |dna|
    List.walk dna_to_rna dna (|s,e| Str.replace_each(s, e.0, e.1) )
