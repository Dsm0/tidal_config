:{
let -- midside
    midside = pF "midside"
    -- fm params
    fm = pF "fm"
    fmf = pF "fmf"
    inputFadeTime = pF "inputFadeTime" -- for \inr synth
    -- sidechain params
    sidechain = pI "sidechain"
    sidechain_thresh = pF "sidechain_thresh" -- default (1/10)
    sidechain_compression = pF "sidechain_compression" -- default (1/10)
    sidechain_attack = pF "sidechain_attack" -- default (1/100)
    sidechain_release = pF "sidechain_release" -- default (1/10)
    sc = sidechain
    sc_t = sidechain_thresh
    sc_c = sidechain_compression
    sc_a = sidechain_attack
    sc_r = sidechain_release
    sc_full o t c a r = sc o # sc_t t # sc_c c # sc_a a # sc_r r
    sc_part o t r = sc o # sc_t t # sc_c (1/10) # sc_a (1/1000) # sc_r r
    -- tape params
    tape = pF "tape"
    tape_saturation = pF "tape_saturation"
    tape_drive = pF "tape_drive"
    tape_oversample = pI "tape_oversample"
    tape_mode = pI "tape_mode"
    soundin = pI "soundin" -- change input bus
    multiband_comp = pF "multiband_comp"
    gate = pF "gate" 
    gateAtk = pF "gateatk"
    gateRel = pF "gateRel"
    chorusrate = pF "chorusrate"
    chorusdepth = pF "chorusdepth"
    chorusdelay = pF "chorusdelay"
    chorusmix = pF "chorusmix"
    foaPush = pF "foaRotate"
    foaAzim = pF "foaTilt"
    foaAngle = pF "foaTumble"
:}


putStrLn "loaded CustomEffectParams.hs"
