module [steps]

steps : U64 -> Result U64 _
steps = \number ->
    counter = \n, i ->
        if n == 1 then
            i
        else if n % 2 == 0 then
            counter (n // 2) (i + 1)
        else
            counter ((n * 3) + 1) (i + 1)

    if number == 0 then 
        Err("invalid number")
    else 
        Ok (counter number 0)
            
        
