:{
let linput = pI "linput"
    lname = pS "lname"
		rec l x n' = once $ slow l $  qtrigger 1 $ "rlooper" # n n' # lname x # linput 0
    recMonitor l x n' = once $ slow l $ qtrigger 1 $ "rlooper" # n n' # lname x # linput 2
    recPulse l x n' = once $ slow l $ qtrigger 1 $ "rlooper" # n n' # lname x # linput 4
    recM = recMonitor
    recP = recPulse
    rectst = rec 1 "tst" 0
    recMtst = recM 1 "tst" 0
    recPtst = recP 1 "tst" 0
    persist x = once $ s "persistLoops" # lname x
    tr = trigger
:}

putStrLn "loaded TidalLooper.hs"
