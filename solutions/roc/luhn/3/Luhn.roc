module [valid]
# This revision improved two aspects!
# 1. no more double reversing by walking backwards
# 2. removed the need to keep index instead just keep a toggle
# am considering changing is digit to char type as as means to better declare control flow.
valid : Str -> Bool
valid = \digits ->
    li =
        digits
            |> Str.to_utf8
            |> List.keep_if (\b -> b != Num.to_u8 ' ')

    if List.len li <= 1 then
        Bool.false
    else
        is_digit : U8 -> Bool
        is_digit = \b ->
            digit0 = Num.to_u8 '0'
            digit9 = Num.to_u8 '9'
            b >= digit0 && b <= digit9

        step = \state, elem ->
            if !state.ok then
                Break state
            else if is_digit elem then
                value = Num.to_i32 elem - Num.to_i32 (Num.to_u8 '0')
                doubled =
                    set = [0,2,4,6,8,1,3,5,7,9]
                    if state.even then
                        Result.with_default (List.get set (Num.to_u64 value)) value
                    else
                        value
                Continue { total: state.total + doubled, ok: Bool.true, even: !state.even }
            else
                Break { total: state.total, ok: Bool.false, even: state.even }


        result =
            List.walk_backwards_until li { total: 0, ok: Bool.true, even: Bool.false } step

        result.ok && (result.total % 10 == 0)
