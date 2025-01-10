:{
let superDirtMixerTarget = Target {
        oName = "superDirtMixer", oAddress = "localhost"
        , oPort = 57121, oLatency = 0.2, oSchedule = Live
        , oWindow = Nothing, oHandshake = False
        , oBusPort = Nothing }
    oscplay = OSC "/SuperDirtMixer" Named {requiredArgs = ["orbit"]}
    oscmap = [(superDirtMixerTarget, [oscplay])]
:}

:{
superDirtMixer <- startStream (defaultConfig {cCtrlPort = 6010}) oscmap
:}

:{
let x1 = streamReplace superDirtMixer 1 . (|< orbit 0)
    x2 = streamReplace superDirtMixer 2 . (|< orbit 1)
    x3 = streamReplace superDirtMixer 3 . (|< orbit 2)
    x4 = streamReplace superDirtMixer 4 . (|< orbit 3)
    x5 = streamReplace superDirtMixer 5 . (|< orbit 4)
    x6 = streamReplace superDirtMixer 6 . (|< orbit 5)
    x7 = streamReplace superDirtMixer 7 . (|< orbit 6)
    x8 = streamReplace superDirtMixer 8 . (|< orbit 7)
    x9 = streamReplace superDirtMixer 9 . (|< orbit 8)
    x10 = streamReplace superDirtMixer 10 . (|< orbit 9)
    x11 = streamReplace superDirtMixer 11 . (|< orbit 10)
    x12 = streamReplace superDirtMixer 12 . (|< orbit 11)
    x13 = streamReplace superDirtMixer 13 . (|< orbit 12)
    x14 = streamReplace superDirtMixer 14 . (|< orbit 13)
:}


:{
-- This is needed to silence all patterns from both streams
hush = do
   streamHush tidal
   streamHush superDirtMixer
:}
 




:{
-- Equalizer
let hiPassFreq = pF "hiPassFreq"
    hiPassRq   = pF "hiPassRq"
    hiPassBypass   = pF "hiPassBypass"
    loShelfFreq = pF "loShelfFreq"
    loShelfGain = pF "loShelfGain"
    loShelfRs   = pF "loShelfRs"
    loShelfBypass   = pF "loShelfBypass"
    loPeakFreq  = pF "loPeakFreq"
    loPeakGain  = pF "loPeakGain"
    loPeakRq    = pF "loPeakRq"
    loPeakBypass    = pF "loPeakBypass"
    midPeakFreq = pF "midPeakFreq"
    midPeakGain = pF "midPeakGain"
    midPeakRq   = pF "midPeakRq"
    midPeakBypass   = pF "midPeakBypass"
    hiPeakFreq  = pF "hiPeakFreq"
    hiPeakGain  = pF "hiPeakGain"
    hiPeakRq    = pF "hiPeakRq"
    hiPeakBypass    = pF "hiPeakBypass"
    hiShelfFreq = pF "hiShelfFreq"
    hiShelfGain = pF "hiShelfGain"
    hiShelfRs   = pF "hiShelfRs"
    hiShelfBypass   = pF "hiShelfBypass"
    loPassFreq = pF "loPassFreq"
    loPassRq   = pF "loPassRq"
    loPassBypass   = pF "loPassBypass"
:}

:{
-- Compressor
let cpAttack = pF "cpAttack"
    cpRelease = pF "cpRelease"
    cpThresh = pF "cpThresh"
    cpTrim = pF "cpTrim"
    cpGain = pF "cpGain"
    cpRatio = pF "cpRatio"
    cpLookahead = pF "cpLookahead"
    cpSaturate = pF "cpSaturate"
    cpHpf = pF "cpHpf"
    cpKnee = pF "cpKnee"
    cpBias = pF "cpBias"
:}


:{
-- Mixer
let masterGain = pF "masterGain"
:}
