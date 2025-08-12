module [is_leap_year]

is_leap_year : I64 -> Bool
is_leap_year = |year|
    if (year%4 == 0) && (year%100 !=0) then
        Bool.true
    else if (year%400 == 0) then
        Bool.true
    else
        Bool.false
