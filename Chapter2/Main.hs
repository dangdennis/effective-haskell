
module Main where


main = do
    print "hello world" 
    print ""
    

listIsEmpty list = 
    if null list
    then putStrLn "this list is empty"
    else putStrLn ("first element is avail" <> show (head list))

isBalanced s =
    0 == isBalanced' 0 s
    where
        isBalanced' count s
            | null s = count
            | head s == '(' = isBalanced' (count+1) (tail s)
            | head s == ')' = isBalanced' (count-1) (tail s)
            | otherwise = isBalanced' count (tail s)

reduce func carryVal list =
    if null list then carryVal
    else 
        let intermediateVal = func carryVal (head list) 
        in reduce func intermediateVal (tail list)

isBalanced' s =
    0 == reduce checkBalance 0 s
    where 
    checkBalance count letter
        | letter == '(' = count + 1
        | letter == ')' = count - 1
        | otherwise = count