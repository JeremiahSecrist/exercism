module [to_rna]

dna_to_num = [("G","1"),("C","2"),("T","3"),("A","4")]
num_to_rna = [("1","C"),("2","G"),("3","A"),("4","U")]
to_rna : Str -> Str
to_rna = |dna|
    ba = List.walk dna_to_num dna (|s,e| Str.replace_each(s, e.0, e.1) )
    List.walk num_to_rna ba (|s,e| Str.replace_each(s, e.0, e.1) )
