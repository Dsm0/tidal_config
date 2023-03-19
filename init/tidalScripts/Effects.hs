-- for use with the effects bindings in vim-tidals vimrc

-- effects can be over-written at any time
-- by design


-- :{
-- let eff_q = (|+ squiz (1/2))
--     eff_Q = (|+ squiz 4)
--     eff_w = (|+ waveloss 4)
--     eff_W = (|+ waveloss 10)
--     eff_e = dtf 0.8 0.03 (14/16)
--     eff_E = dtf (0.8 + 0.1*rand) 
--                 ( discretize ("[4|6|8|2]*4") $ range (10/1000) (50/1000) $ rand)
--                 ( discretize (2) $ range (10/16) (14/16) $ rand)
--     eff_r = (|+ room (1/16)) . (|+ size (1/16))
--     eff_R = (|+ room (7/8))  . (|+ size (7/8))
--     eff_t = roll
--     eff_T = roll''
--     eff_y = bite (1*8) ("0 1 2 0 1 2 0 1")
--     eff_Y = bite (1*8) ("0*2 0 0 1 2 0 0 1"+( discretize (1) $ irand 8))
--     eff_u = spike'
--     eff_U = spike''
--     eff_i = iter 4
--     eff_I = iter 8
--     eff_p = plysl (2)
--     eff_P = plysl (3)
--     eff_a = (|+ soundin "2")
--     eff_A = id
--     eff_s = slow 2
--     eff_S = striate 2
--     eff_d = (|+ distort (1/16))
--     eff_D = (|+ distort (1))
--     eff_f = fast (2)
--     eff_F = id
--     eff_g = ghost
--     eff_G = (|+ n (discretize 1 $ irand 10000))
--     eff_h = hurry (2)
--     eff_H = hurry (3/2)
--     eff_j = foldEvery [3,4] ((1/4) ~>) -- move
--     eff_J = foldEvery [2,3] ((4/8) ~>) -- move
--     eff_k = rip (9/8) (3/2)
--     eff_K = rip (7/8) (1/"{2 1 4}%4")
--     eff_l = linger (3/8)
--     eff_L = linger (3/16)
--     eff_z = (|+ hpf (100))
--     eff_Z = id
--     eff_x = (|+ lpf (100))
--     eff_X = id
--     eff_c = chop 2
--     eff_C = (# cut 1)
--     eff_v = id
--     eff_V = id
--     eff_b = shiftBy (1/8)
--     eff_B = (shiftBy (4/8))
--     eff_n = (|+ n 1)
--     eff_N = (|- n 1)
--     eff_m = (|+ smear (1/2))
--     eff_M = (|+ smear (2))
--     eff_o = (|+ crush 2)
--     eff_O = (|+ coarse 3)
--     eff_1 = id
--     eff_2 = id
--     eff_3 = id
--     eff_4 = id
--     eff_5 = id
--     eff_6 = id
--     eff_7 = id
--     eff_8 = id
--     eff_9 = id
--     eff_0 = id
--     eff_up = id
--     eff_down = id
--     eff_left = id
--     eff_right = id
-- :}

-- let make_eff 'm' i = (|+ smear ((realToFrac i)/2))
--     make_eff 'r' i = (|+ room ((realToFrac i)/2))
--     make_eff 'x' i = (|+ lpf (100*(realToFrac i)))

:{
 
 -- annoying to have to redeclare p_bpe a billion times,
 -- but we can't have haskell determine the type of 
 -- the function it returns before an argument gets passed in
 -- otherwise we couldn't have one function for both pattern and 
 -- param manipulations
  --  NOTE: there's probably some compiler option for this
  --  and you should look into it
let p_bpe = parseBP_E
    make_eff 'q' i = (|+ squiz (val/2)) where val = p_bpe i
    make_eff 'Q' i = id -- (|+ squiz 4)
    make_eff 'w' i = (|+ waveloss (p_bpe i)) where val = p_bpe i
    make_eff 'W' i = id -- (|+ waveloss 10)
    make_eff 'e' i = dtf 0.8 (0.05*val) (12/16) where val = p_bpe i
    make_eff 'E' i = dtf (0.8 + 0.15*rand) ((99 + val)/500) (14/16) where val = p_bpe i
    make_eff 'r' i = ((+ room (val * 1/32)) . (|+ size (val * 1/32))) where val = p_bpe i
    make_eff 'R' i = ((+ room (val * (8/32))) . (|+ size ((val *24/32)))) where val = p_bpe i
    make_eff 't' i = roll
    make_eff 'T' i = roll''
    make_eff 'y' i = bite (1*8) ("0 1 2 0 1 2 0 1")
    make_eff 'Y' i = bite (1*8) ("0*2 0 0 1 2 0 0 1"+( discretize (1) $ irand 8))
    make_eff 'u' i = spike'
    make_eff 'U' i = spike''
    make_eff 'i' i = iter (4*val) where val = p_bpe i
    make_eff 'I' i = id
    make_eff 'o' i = (|+ crush (2+val)) where val = p_bpe i
    make_eff 'O' i = (|+ coarse (2*val)) where val = p_bpe i
    make_eff 'p' i = plysl (2 + val) where val = p_bpe i
    make_eff 'P' i = id -- plysl (3)
    make_eff 'a' i = (|+ soundin ("2" * val)) where val = p_bpe i
    make_eff 'A' i = id
    make_eff 's' i = (slow (val*2)) where val = p_bpe i
    make_eff 'S' i = striate (2*val) where val = p_bpe i
    make_eff 'd' i = (|+ distort (val * 1/16)) where val = p_bpe i
    make_eff 'D' i = (|+ distort (1*val)) where val = p_bpe i
    make_eff 'f' i = fast (2*val) where val = p_bpe i
    make_eff 'F' i = id
    make_eff 'g' i = (|* speed (1 + (val/24))) where val = p_bpe i
    make_eff 'G' i = (|* speed (1 + (val/8))) where val = p_bpe i
    make_eff 'h' i = hurry (2 * (val + 1)) where val = p_bpe i
    make_eff 'H' i = hurry ((4 + val)/4) where val = p_bpe i
    make_eff 'j' i = foldEvery [3,4] ((1/4) ~>) -- move
    make_eff 'J' i = foldEvery [2,3] ((4/8) ~>) -- move
    make_eff 'k' i = rip (9/8) (3/2)
    make_eff 'K' i = rip (7/8) (1/"{2 1 4}%4")
    make_eff 'l' i = linger ((2 + val)/8) where val = p_bpe i
    make_eff 'L' i = linger ((3+val)/16) where val = p_bpe i
    make_eff 'z' i = (|+ hpf (100*val)) where val = p_bpe i
    make_eff 'Z' i = id
    make_eff 'x' i = (|+ lpf (100*val)) where val = p_bpe i
    make_eff 'X' i = id
    make_eff 'c' i = chop (1 + val) where val = p_bpe i
    make_eff 'C' i = (# cut val) where val = p_bpe i
    make_eff 'v' i = ghost
    make_eff 'V' i = (# room ("0"/100)) . (# size ("0"/100))
    make_eff 'b' i = shiftBy (val/8) where val = p_bpe i
    make_eff 'B' i = (shiftBy ((4*val)/8)) where val = p_bpe i
    make_eff 'n' i = (|+ n val) where val = p_bpe i
    make_eff 'N' i = (|- n val) where val = p_bpe i
    make_eff 'm' i = (|+ smear ((val)/2)) where val = p_bpe i
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
