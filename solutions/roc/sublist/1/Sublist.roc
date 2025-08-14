module [sublist]
list_contains : List U8, List U8 -> Bool
list_contains = |l1, l2| 
    if l1 == l2 then 
      Bool.true
    else if List.len(l1) < List.len(l2) then
      Bool.false
    else if List.starts_with l1 l2 || List.ends_with l1 l2 then
      Bool.true 
    else
      list_contains (List.drop_last (List.drop_first  l1 1) 1) l2
      
sublist : List U8, List U8 -> [Equal, Sublist, Superlist, Unequal]
sublist = |list1, list2|
    if list1 == list2 then
        Equal
    else if list_contains list2 list1  then
        Sublist
    else if list_contains list1 list2 then
        Superlist
    else
        Unequal
