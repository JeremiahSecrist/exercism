module [nucleotide_counts]

nucleotide_counts : Str -> Result { a : U64, c : U64, g : U64, t : U64 } _
nucleotide_counts = \input ->
    # we must type it here otherwise the init state is asserted wrong
    init : { a : U64, c : U64, g : U64, t : U64 }
    init = { a : 0, c : 0, g : 0, t : 0 }

    step = \counts, ch ->
        when ch is
            # & behavior allows me to override an element
            # the comunity solution is more elegant than mine :c
            'A' -> Ok { counts & a: counts.a + 1 }
            'C' -> Ok { counts & c: counts.c + 1 }
            'G' -> Ok { counts & g: counts.g + 1 }
            'T' -> Ok { counts & t: counts.t + 1 }
            _   -> Err "fail"
    # rather than walk until walk try make sense here as the same err should just be passed along
    # convert input into utf8 so we can manuipulate it.
    List.walk_try (Str.to_utf8 input) init step