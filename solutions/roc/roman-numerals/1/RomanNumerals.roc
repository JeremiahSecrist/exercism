module [roman]

roman_map : List (U64, Str)
roman_map =
    [ (1000, "M")
    , (900,  "CM")
    , (500,  "D")
    , (400,  "CD")
    , (100,  "C")
    , (90,   "XC")
    , (50,   "L")
    , (40,   "XL")
    , (10,   "X")
    , (9,    "IX")
    , (5,    "V")
    , (4,    "IV")
    , (1,    "I")
    ]

to_roman : U64 -> Str
to_roman = \num ->
    if num == 0 then
        ""
    else
        # Find the first value <= num
        go = \lst ->
            when lst is
                [] -> ""
                [(value, sym) , .. as rest] ->
                    if num >= value then
                        Str.concat(sym,  to_roman (num - value))
                    else
                        go rest
        go roman_map

roman : U64 -> Result Str _
roman = |number|
    if number == 0 || number > 3999 then
        Err "number out of range"
    else
        Ok(to_roman number)