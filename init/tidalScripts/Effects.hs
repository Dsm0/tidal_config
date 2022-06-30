-- for use with the effects bindings in vim-tidals vimrc

-- effects can be over-written at any time
-- by design

:{
let eff_q = (# squiz (3/2))
    eff_Q = (# squiz 5)
    eff_w = (# waveloss 8)
    eff_W = (# waveloss 40)
    eff_e = id
    eff_E = id
    eff_r = rev
    eff_R = (# room (7/8))
    eff_t = id
    eff_T = id
    eff_y = id
    eff_Y = iter 4 . slow 2 . chop 2
    eff_u = id
    eff_U = id
    eff_i = iter 4
    eff_I = iter 8
    eff_p = plysl (2)
    eff_P = plysl (3)
    eff_a = id
    eff_A = id
    eff_s = slow 2
    eff_S = striate 2
    eff_d = (|+ distort (1/16))
    eff_D = (|* distort (2))
    eff_f = fast (2)
    eff_F = id
    eff_g = ghost
    eff_G = id
    eff_h = hurry (2)
    eff_H = hurry (3/2)
    eff_j = id
    eff_J = id
    eff_k = id
    eff_K = id
    eff_l = linger (1/2)
    eff_L = linger (1/8)
    eff_z = id
    eff_Z = id
    eff_x = id
    eff_X = id
    eff_c = chop 2
    eff_C = (# cut 1)
    eff_v = id
    eff_V = id
    eff_b = brak
    eff_B = id
    eff_n = (|+ n 1)
    eff_N = (|- n 1)
    eff_m = (# smear (1/2))
    eff_M = (# smear (2))
    eff_o = (# coarse 4)
    eff_O = (|* coarse 2)
:}

-- consider adding functionality to change event parameters
-- by design
-- :{
-- :}

putStrLn "loaded Effects.hs"