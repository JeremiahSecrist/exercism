module [is_isogram]

is_isogram : Str -> Bool
is_isogram = |phrase|
    list = phrase |> Str.with_ascii_lowercased |> Str.to_utf8
    step = |state, ch|
        if ch == '-' || ch == ' ' then
            Continue state  # ignore hyphens entirely
        else if !(List.contains state.state ch) then
            Continue { state: List.prepend state.state ch, ok: Bool.true }
        else
            Break { state: List.prepend state.state ch, ok: Bool.false }

    result =
        List.walk_until(
            list,
            { state: [], ok: Bool.true },
            step
        )

    result.ok