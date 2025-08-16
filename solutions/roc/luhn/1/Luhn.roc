module [valid]


valid : Str -> Bool
valid = \digits ->
    # convert to bytes and strip spaces
    li =
        digits
            |> Str.to_utf8
            |> List.keep_if (\b -> b != Num.to_u8 ' ')
            |> List.reverse

    # must have at least 2 digits
    if List.len li <= 1 then
        Bool.false
    else
        is_digit : U8 -> Bool
        is_digit = \b ->
            digit0 = Num.to_u8 '0'
            digit9 = Num.to_u8 '9'
            b >= digit0 && b <= digit9

        step = \state, elem, index ->
            if !state.ok then
                Break state
            else if is_digit elem then
                value = Num.to_i32 elem - Num.to_i32 (Num.to_u8 '0')
                doubled =
                    if index % 2 == 1 then
                        v = value * 2
                        if v > 9 then v - 9 else v
                    else
                        value
                Continue { total: state.total + doubled, ok: Bool.true }
            else
                Break { total: state.total, ok: Bool.false }

        result =
            List.walk_with_index_until li { total: 0, ok: Bool.true } step

        result.ok && (result.total % 10 == 0)



