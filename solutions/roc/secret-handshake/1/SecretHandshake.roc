module [commands]
actions = [
"wink",
"double blink",
"close your eyes",
"jump",
"reverse"
]

num_to_list : U64 -> List Bool
num_to_list = |x|
    List.map (List.range {start: At 0, end: At 4}) (|index|
        mask = Num.pow_int(2, index)
        (Num.bitwise_and x mask) == mask
    )


commands : U64 -> List Str
commands = |number|
    stage1 = List.map2 actions (num_to_list number) (|x,y| if y then x else "") |> List.keep_if (|x| x != "" )
    if List.contains stage1 "reverse" then
        List.drop_last stage1 1 |> List.reverse
    else
        stage1
