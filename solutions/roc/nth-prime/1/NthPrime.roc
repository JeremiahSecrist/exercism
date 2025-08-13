module [prime]

is_prime : U64 -> Bool
is_prime = |n|
    if n < 2 then
        Bool.false
    else if n == 2 then
        Bool.true
    else if n % 2 == 0 then
        Bool.false
    else
        limit = Num.to_u64(Num.floor(Num.sqrt(Num.to_f64(n))))
        List.range({ start: At(3), end: At(limit), step: 2 })
        |> List.keep_if(|x| n % x == 0)
        |> List.is_empty

prime : U64 -> Result U64 Str
prime = |nth|
    p_acc = |candidate, count|
        if count == nth then
            candidate-1
        else if is_prime candidate then
            p_acc (candidate + 1) (count + 1)
        else
            p_acc (candidate + 1) count

    if nth <= 0 then
        Err("invalid number")
    else
        Ok(p_acc 2 0)

