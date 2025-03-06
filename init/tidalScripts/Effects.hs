-- for use with the effects bindings in vim-tidals vimrc

-- effects can be over-written at any time
-- by design


-- let make_eff 'm' i = (|+ smear ((realToFrac i)/2))
--     make_eff 'r' i = (|+ room ((realToFrac i)/2))
--     make_eff 'x' i = (|+ lpf (100*(realToFrac i)))

:{
 
 -- annoying to have to redeclare val a billion times,
 -- but we can't have haskell determine the type of 
 -- the function it returns before an argument gets passed in
 -- otherwise we couldn't have one function for both pattern and 
 -- param manipulations
    -- wonder how interesting it would be to refactor this
    -- doubt it's worth the trouble tho
    --  
let p_bpe = parseBP_E
    bitein x y z = slow x . bite y z . fast x
    
    make_eff 'q' i = (|+ squiz (val/10)) where val = p_bpe i
    make_eff 'Q' i = (|+ waveloss (p_bpe i)) where val = p_bpe i
    make_eff 'w' i = echo (2) (((-1)*val - 1)/16) (15/18) where val = p_bpe i
    make_eff 'W' i = inside 1 (echo (1 + val) (((-1))/16) (7/8)) where val = p_bpe i
    make_eff 'e' i =  (# delay (0.5 + ((50 + val)/100))) 
                        . (|* delaytime (((40 + val)/1000))) 
                        . (# delayfb ((9/16) + (val/2000))) where val = p_bpe i
    make_eff 'E' i =  (# delay (0.5 + ((50 + val)/100))) 
                        . (|* delaytime (1 + ((2 ** val))/10000)) 
                        . (# delayfb ((9/16) - (val/500))) where val = p_bpe i
    make_eff 'r' i = ((+ room (val * 1/32)) . (|+ size (val * 1/32))) where val = p_bpe i
    make_eff 'R' i = ((+ room (val * (8/32))) . (|+ size ((val * 24/32)))) where val = p_bpe i
    make_eff 't' i = roll
    make_eff 'T' i = roll''
    make_eff 'y' i = bitein 1 (1*8) (rot (-val) $ "[0] [1] [2] [3] [4] [5] [6] [7]") where val = p_bpe i
    make_eff 'Y' i = bite (1*8) ("0*2 0 0 1 2 0 0 1"+( discretize (1) $ irand 8))
    -- make_eff 'u' i = spikeVal val where val = p_bpe i
    -- make_eff 'u' i = (# delay "0.4") . (# delaytime (range 0.001 0.1 $ slow (6.1 + (-1 * (val /20))) sine)) . (# delayfeedback (range 0.7 0.99 $ slow ((5.72 + (-1 * (val /20)))) sine)) where val = p_bpe i
    make_eff 'u' i = (# delay (0.93 - (val/300))) . 
                     (|* delaytime (discretize 32 $ range 1 (0.001) $ fast (1 + val) $ saw)) . 
                     (# delayfeedback (range 0.7 0.8 $ fast (val*(1/8) + (3/4)) $ sine))
                       where val = p_bpe i
    make_eff 'U' i = (# delay (0.93 - (val/500))) . 
                     (# delaytime (range (0.1 + 2 ** (val)) 2 $ fast (4) $ saw)) . 
                     (# delayfeedback (range 0.4 0.9 $ fast (val*(1/4) + (3/4)) $ sine))
                       where val = p_bpe i
    make_eff 'i' i = bitein 2 "8" ("[0]*8" + (val-1)) where val = p_bpe i
    make_eff 'I' i = bitein 4 (2*"32") ("{ 0 1 2 3}%64" + (val-1)) where val = p_bpe i
    make_eff 'o' i = (|+ crush (2+val)) where val = p_bpe i
    make_eff 'O' i = (|+ coarse (2+val)) where val = p_bpe i
    make_eff 'p' i = plysl (1 + val) where val = p_bpe i
    make_eff 'P' i = plyWith (1 + val) ((|* speed (3/2)) . (|* gain (9/10)) ) where val = p_bpe i
    make_eff 'a' i = (|* accelerate (val/8)) where val = p_bpe i
    make_eff 'A' i = (|+ soundin ("2" * val)) where val = p_bpe i
    make_eff 's' i = (slow (val + 1)) where val = p_bpe i
    make_eff 'S' i = (# shape (0 + (val-1)/1000)) where val = p_bpe ii
                                                        ii = if (read i :: Integer) > (999) then ("999") else i
    make_eff 'd' i = (|+ distort (val * 1/16)) where val = p_bpe i
    make_eff 'D' i = (|+ distort (1*val)) where val = p_bpe i
    make_eff 'f' i = fast (1 + val) where val = p_bpe i
    make_eff 'F' i = fast (1 + (val / 64)) where val = p_bpe i
    make_eff 'g' i = (|* speed (1 + (val/24))) where val = p_bpe i
    make_eff 'G' i = (|* speed (1 + (val/100))) where val = p_bpe i
    make_eff 'h' i = hurry (1 + (val)) where val = p_bpe i
    make_eff 'H' i = hurry ((3 + val)/8) where val = p_bpe i
    make_eff 'j' i = degradeBy (val / 10) where val = p_bpe i
    make_eff 'J' i = degradeBy (val / 100) where val = p_bpe i
    make_eff 'k' i = swingBy (val/16) 4 where val = p_bpe i
    make_eff 'K' i = rip (7/8) (1/"{2 1 4}%4")
    make_eff 'l' i = linger ((2 + val)/8) where val = p_bpe i
    make_eff 'L' i = if (read i :: Integer) > (-2) then linger ((2+val)/16) else linger (1/(16 - val)) where val = p_bpe i
    make_eff 'z' i = (|+ hpf (100*val)) where val = p_bpe i
    make_eff 'Z' i = (# rel (val/100))  where val = p_bpe i
    make_eff 'x' i = (|+ lpf (100*val)) where val = p_bpe i
    make_eff 'X' i = (# pan ((val)/20)) where val = p_bpe i
    make_eff 'c' i = if (read i :: Integer) < 0 then chop (-1 * (val -1)) else chop (1 + val) where val = p_bpe i
    make_eff 'C' i = ((# cut val). (# orbit val)) where val = p_bpe i
    make_eff 'v' i = ghost
    make_eff 'V' i = (# room ("0"/100)) . (# size ("0"/100)) . (# delay (0)) . (# delayfb (0))  . (# delaytime (1) )
    make_eff 'b' i = shiftBy (val/8) where val = p_bpe i
    make_eff 'B' i = (shiftBy ((4*val)/8)) where val = p_bpe i
    make_eff 'n' i = (|+ n val) where val = p_bpe i
    make_eff 'N' i = (|- n val) where val = p_bpe i
    -- make_eff 'm' i = (# multiband_comp (if val < 99 then (1/(val/16 + 0.5)-2)/(-2))) where val = p_bpe i
    make_eff 'm' i = (# multiband_comp (if (bruh < 99) then (val/100) else ((1/(val + 0.5)-2)/(-2)))) 
                        where bruh = read i :: Integer
                              val = p_bpe i
    make_eff 'M' i = (|+ smear (2*val)) where val = p_bpe i
    make_eff '_' i = id
    make_eff '1' i = id
    make_eff '2' i = id
    make_eff '3' i = id
    make_eff '4' i = id
    make_eff '5' i = id
    make_eff '6' i = id
    make_eff '7' i = id
    make_eff '8' i = id
    make_eff '9' i = id
    make_eff '0' i = id
    eff x = make_eff x "1"
    ----
    splitWhen p s =
      case dropWhile p s of
        "" -> []
        s' -> w : splitWhen p s''
          where (w, s'') = break p s'
    effStr fxs = foldl (.) id fxArray
      where fxArrayStrs = splitWhen (\c -> c == ',') fxs
            fxArray = map make_eff' fxArrayStrs
            make_eff' (c:i) = make_eff c i
             
:}

-- consider adding functionality to change event parameters
-- by design
-- :{
-- :}

putStrLn "loaded Effects.hs"
