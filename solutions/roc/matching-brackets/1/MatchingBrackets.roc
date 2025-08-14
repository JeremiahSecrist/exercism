module [is_paired]

is_paired : Str -> Bool
is_paired = |string|
    pair = |b|
        when b is
            '}' -> '{'
            ']' -> '['
            ')' -> '('
            _   -> 0  # no match

    is_closed = \b -> b == '}' || b == ']' || b == ')'
    is_open   = \b -> b == '{' || b == '[' || b == '('

    step = |state, ch|
        if !state.ok then
            Break state  # already invalid, just stop
        else if is_open ch then
            Continue { stack: List.prepend state.stack ch, ok: Bool.true }
        else if is_closed ch then
            when state.stack is
                [top, .. as rest] ->
                    if pair(ch) == top then
                        Continue { stack: rest, ok: Bool.true }
                    else
                        Break { stack: state.stack, ok: Bool.false }
                _ ->
                    Break { stack: state.stack, ok: Bool.false }
        else
            Continue state  # ignore non-bracket chars

    final =
        Str.to_utf8(string) # we must use to utf8 in order to split it correctly
            |> List.walk_until({ stack: [], ok: Bool.true }, step) # have a break condition so on any invalid state dont continue the list

    final.ok && (List.is_empty final.stack)
    
    