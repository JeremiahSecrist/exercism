module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotide_counts = |input|
    init = Str.to_utf8 input
    istate : {
        result : { a : U64, c : U64, g : U64, t : U64 },
        ok : Bool
    }
    istate = {
        result:{ a : 0, c : 0, g : 0, t : 0 },
        ok: Bool.true
    }
    char_type : U8 -> [A, C, G, T, Other]
    char_type = \c ->
        when c is
            'A' -> A
            'C' -> C
            'G' -> G
            'T' -> T
            _ -> Other
    
    step = |state, ch|
        a = char_type ch
        when a is
            Other -> Break {ok: Bool.false,result:{ a : 0, c : 0, g : 0, t : 0 }}
            A -> Continue {ok: Bool.true,result:{ a : state.result.a +1, c : state.result.c, g : state.result.g, t : state.result.t }}
            C -> Continue {ok: Bool.true,result:{ a : state.result.a, c : state.result.c +1, g : state.result.g, t : state.result.t }}
            T -> Continue {ok: Bool.true,result:{ a : state.result.a, c : state.result.c, g : state.result.g, t : state.result.t +1 }}
            G -> Continue {ok: Bool.true,result:{ a : state.result.a , c : state.result.c , g : state.result.g +1, t : state.result.t }}
        
    out =List.walk_until init istate step
    if out.ok then
        Ok(out.result)
    else
        Err "fail"
