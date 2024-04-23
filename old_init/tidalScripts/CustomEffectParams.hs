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
    -- tape params
    tape = pF "tape"
    tape_saturation = pF "tape_saturation"
    tape_drive = pF "tape_drive"
    tape_oversample = pI "tape_oversample"
    tape_mode = pI "tape_mode"
    soundin = pI "soundin" -- change input bus
:}


putStrLn "loaded CustomEffectParams.hs"
