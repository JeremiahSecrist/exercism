module [valid]
# This revision improved two aspects!
# 1. no more double reversing by walking backwards
# 2. removed the need to keep index instead just keep a toggle
# 3. no longer need to trim chars!
valid : Str -> Bool
valid = \digits ->
    li = Str.to_utf8 digits

    char_type : U8 -> [Digit,Space,Other]
    char_type = \b ->
        digit0 = Num.to_u8 '0'
        digit9 = Num.to_u8 '9'
        if b >= digit0 && b <= digit9 then
            Digit
        else if b == Num.to_u8 ' ' then
            Space
        else
            Other

    step = \state, elem ->
        when char_type elem is
            Digit ->
                value = Num.to_i32 elem - Num.to_i32 (Num.to_u8 '0')
                doubled =
                    lookup_table = [0,2,4,6,8,1,3,5,7,9]
                    if state.even then 
                        Result.with_default (List.get lookup_table (Num.to_u64 value)) value
                    else
                        value
                Continue { 
                    total: state.total + doubled, 
                    ok: Bool.true, 
                    even: !state.even, 
                    larger_than_1: state.larger_than_1 || state.seen_one,
                    seen_one: Bool.true 
                }

            Space ->
                Continue state

            Other ->
                Break { total: state.total, ok: Bool.false, even: state.even, larger_than_1: state.larger_than_1, seen_one: state.seen_one }

    result =
        List.walk_backwards_until li { total: 0, ok: Bool.true, even: Bool.false, larger_than_1: Bool.false, seen_one: Bool.false } step

    result.ok && result.larger_than_1 && (result.total % 10 == 0)

