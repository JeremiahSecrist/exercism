module [convert]

convert : U64 -> Str
convert = |number|
    by_3 = 
        if number%3==0 then
            "Pling"
        else
            ""
    by_5 = 
        if number%5==0 then
            "Plang"
        else
            ""
    by_7 = 
        if number%7==0 then
            "Plong"
        else
            ""
    all = "$(by_3)$(by_5)$(by_7)"
    if  all == "" then
        Num.to_str number
    else
        all
        
