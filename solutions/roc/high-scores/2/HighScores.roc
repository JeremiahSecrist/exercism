module [latest, personal_best, personal_top_three]

Score : U64

latest : List Score -> Result Score _
latest = |scores|
    List.last scores

personal_best : List Score -> Result Score _
personal_best = |scores|
    when scores is
        [] ->  Err("Must not be empty")
        [a] -> Ok(a)
        [f, s, .. as rest ] ->
            max_score = if f >= s then f else s
            personal_best(List.append(rest, max_score))

personal_top_three : List Score -> List Score
personal_top_three = |scores|
    when scores is
        [] -> []
        [a] -> [a]
        [a,b] -> if a > b then [a,b] else [b,a]
        [a,b,c] -> List.sort_desc([a,b,c])
        [a, .. as rest] -> 
            lt = List.all rest (\n -> a <= n )
            if lt then 
                personal_top_three(rest) 
            else 
                personal_top_three(List.append(rest, a))
