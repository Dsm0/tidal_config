-- for use with the effects bindings in vim-tidals vimrc

-- effects can be over-written at any time
-- by design

:{
let eff_q = (|+ squiz (1/2))
    eff_Q = (|+ squiz 4)
    eff_w = (|+ waveloss 4)
    eff_W = (|+ waveloss 10)
    eff_e = dtf 0.8 0.03 (14/16)
    eff_E = randDelay
    eff_r = rev
    eff_R = (# room (7/8))
    eff_t = roll
    eff_T = roll''
    eff_y = id
    eff_Y = iter 4 . slow 2 . chop 2
    eff_u = spike'
    eff_U = spike''
    eff_i = iter 4
    eff_I = iter 8
    eff_p = plysl (2)
    eff_P = plysl (3)
    eff_a = id
    eff_A = id
    eff_s = slow 2
    eff_S = striate 2
    eff_d = (|+ distort (1/16))
    eff_D = (|+ distort (1))
    eff_f = fast (2)
    eff_F = id
    eff_g = ghost
    eff_G = id
    eff_h = hurry (2)
    eff_H = hurry (3/2)
    eff_j = foldEvery [3,4] ((1/4) ~>) -- move
    eff_J = foldEvery [2,3] ((4/8) ~>) -- move
    eff_k = rip (9/8) (3/2)
    eff_K = rip (7/8) (1/"{2 1 4}%4")
    eff_l = linger (1/4)
    eff_L = linger (1/8)
    eff_z = (|+ hpf (100))
    eff_Z = id
    eff_x = (|+ lpf (100))
    eff_X = id
    eff_c = chop 2
    eff_C = (# cut 1)
    eff_v = id
    eff_V = id
    eff_b = shiftBy (1/8)
    eff_B = superimpose (shiftBy (1/8))
    eff_n = (|+ n 1)
    eff_N = (|- n 1)
    eff_m = (|+ smear (1/2))
    eff_M = (|+ smear (2))
    eff_o = (|+ crush 2)
    eff_O = (|+ coarse 3)
    eff_1 = id
    eff_2 = id
    eff_3 = id
    eff_4 = id
    eff_5 = id
    eff_6 = id
    eff_7 = id
    eff_8 = id
    eff_9 = id
    eff_0 = id
:}

-- consider adding functionality to change event parameters
-- by design
-- :{
-- :}

putStrLn "loaded Effects.hs"
