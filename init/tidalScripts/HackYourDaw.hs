:{
let pitch = pF "pitch"
    begin = pF "begin"
    res = pF "res"
    vel = pF "vel"
    cutoff = pF "cutoff"
    drive = pF "drive"
    filtertype = pS "filter"
    legato = pF "legato"
    --synth parameters
    pitchbend = pF "pitchbend"
    modwheel = pF "modwheel"
    aftertouch = pF "aftertouch"
    pbend = pitchbend
    modw = modwheel
    atouch = aftertouch
    --macro
    macro1 = pF "macro1"
    macro2 = pF "macro2"
    macro3 = pF "macro3"
    macro4 = pF "macro4"
    macro5 = pF "macro5"
    macro6 = pF "macro6"
    macro7 = pF "macro7"
    macro8 = pF "macro8"
    macro9 = pF "macro9"
    macro10 = pF "macro10"
    macro11 = pF "macro11"
    macro12 = pF "macro12"
    macro13 = pF "macro13"
    macro14 = pF "macro14"
    macro15 = pF "macro15"
    macro16 = pF "macro16"
    allmacro x = macro1 x #macro2 x #macro3 x #macro4 x #macro6 x #macro7 x #macro8 x
    allmacrorand = macro1 rand #macro2 (slow 1.1 rand) #macro3 (slow 1.3 rand) #macro4 (slow 1.4 rand) #macro5 (slow 1.5 rand) #macro6 (slow 1.6 rand) #macro7 (slow 1.7 rand) #macro8 (slow 1.8 rand)
    --sends
    send1 = pF "send1"
    send2 = pF "send2"
    send3 = pF "send3"
    send4 = pF "send4"
    send5 = pF "send5"
    send6 = pF "send6"
    send7 = pF "send7"
    send8 = pF "send8"
    sendA = pF "send1"
    sendB = pF "send2"
    sendC = pF "send3"
    sendD = pF "send4"
    sendE = pF "send5"
    sendF = pF "send6"
    sendG = pF "send7"
    sendH = pF "send8"
    allsend x = send1 x #send2 x #send3 x #send4 x #send6 x #send7 x #send8 x
    allsendrand = send1 rand #send2 (slow 1.1 rand) #send3 (slow 1.3 rand) #send4 (slow 1.4 rand) #send5 (slow 1.5 rand) #send6 (slow 1.6 rand) #send7 (slow 1.7 rand) #send8 (slow 1.8 rand)
:}
 


