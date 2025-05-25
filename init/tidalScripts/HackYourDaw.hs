-- :{
-- let pitch = pF "pitch"
--     begin = pF "begin"
--     res = pF "res"
--     vel = pF "vel"
--     cutoff = pF "cutoff"
--     drive = pF "drive"
--     filtertype = pS "filter"
--     legato = pF "legato"
--     --synth parameters
--     pitchbend = pF "pitchbend"
--     modwheel = pF "modwheel"
--     aftertouch = pF "aftertouch"
--     pbend = pitchbend
--     modw = modwheel
--     atouch = aftertouch
--     --macro
--     macro1 = pF "macro1"
--     macro2 = pF "macro2"
--     macro3 = pF "macro3"
--     macro4 = pF "macro4"
--     macro5 = pF "macro5"
--     macro6 = pF "macro6"
--     macro7 = pF "macro7"
--     macro8 = pF "macro8"
--     macro9 = pF "macro9"
--     macro10 = pF "macro10"
--     macro11 = pF "macro11"
--     macro12 = pF "macro12"
--     macro13 = pF "macro13"
--     macro14 = pF "macro14"
--     macro15 = pF "macro15"
--     macro16 = pF "macro16"
--     allmacro x = macro1 x #macro2 x #macro3 x #macro4 x #macro6 x #macro7 x #macro8 x
--     allmacrorand = macro1 rand #macro2 (slow 1.1 rand) #macro3 (slow 1.3 rand) #macro4 (slow 1.4 rand) #macro5 (slow 1.5 rand) #macro6 (slow 1.6 rand) #macro7 (slow 1.7 rand) #macro8 (slow 1.8 rand)
--     --sends
--     send1 = pF "send1"
--     send2 = pF "send2"
--     send3 = pF "send3"
--     send4 = pF "send4"
--     send5 = pF "send5"
--     send6 = pF "send6"
--     send7 = pF "send7"
--     send8 = pF "send8"
--     sendA = pF "send1"
--     sendB = pF "send2"
--     sendC = pF "send3"
--     sendD = pF "send4"
--     sendE = pF "send5"
--     sendF = pF "send6"
--     sendG = pF "send7"
--     sendH = pF "send8"
--     allsend x = send1 x #send2 x #send3 x #send4 x #send6 x #send7 x #send8 x
--     allsendrand = send1 rand #send2 (slow 1.1 rand) #send3 (slow 1.3 rand) #send4 (slow 1.4 rand) #send5 (slow 1.5 rand) #send6 (slow 1.6 rand) #send7 (slow 1.7 rand) #send8 (slow 1.8 rand)
-- :}
 


--  NOTE: for specific synths, these labels should be updated to something more descriptive than just "p0","p1"
--   ie. if p0 is bound to "osc1 shape" in ableton, 
--   redefine as 'let osc1Shape = p0'  or 'let osc1Shape = pF "p0"'
--    
--
:{
import qualified Data.Map.Strict     as Map
:}

:{
let pitchbend = pF "pitchbend"
    modwheel = pF "modwheel"
    aftertouch = pF "aftertouch"
    vel = pF "vel"
    p0   = pF "p0"
    p1   = pF "p1"
    p2   = pF "p2"
    p3   = pF "p3"
    p4   = pF "p4"
    p5   = pF "p5"
    p6   = pF "p6"
    p7   = pF "p7"
    p8   = pF "p8"
    p9   = pF "p9"
    p10  = pF "p10"
    p11  = pF "p11"
    p12  = pF "p12"
    p13  = pF "p13"
    p14  = pF "p14"
    p15  = pF "p15"
    p16  = pF "p16"
    p17  = pF "p17"
    p18  = pF "p18"
    p19  = pF "p19"
    p20  = pF "p20"
    p21  = pF "p21"
    p22  = pF "p22"
    p23  = pF "p23"
    p24  = pF "p24"
    p25  = pF "p25"
    p26  = pF "p26"
    p27  = pF "p27"
    p28  = pF "p28"
    p29  = pF "p29"
    p30  = pF "p30"
    p31  = pF "p31"
    p32  = pF "p32"
    p33  = pF "p33"
    p34  = pF "p34"
    p35  = pF "p35"
    p36  = pF "p36"
    p37  = pF "p37"
    p38  = pF "p38"
    p39  = pF "p39"
    p40  = pF "p40"
    p41  = pF "p41"
    p42  = pF "p42"
    p43  = pF "p43"
    p44  = pF "p44"
    p45  = pF "p45"
    p46  = pF "p46"
    p47  = pF "p47"
    p48  = pF "p48"
    p49  = pF "p49"
    p50  = pF "p50"
    p51  = pF "p51"
    p52  = pF "p52"
    p53  = pF "p53"
    p54  = pF "p54"
    p55  = pF "p55"
    p56  = pF "p56"
    p57  = pF "p57"
    p58  = pF "p58"
    p59  = pF "p59"
    p60  = pF "p60"
    p61  = pF "p61"
    p62  = pF "p62"
    p63  = pF "p63"
    p64  = pF "p64"
    p65  = pF "p65"
    p66  = pF "p66"
    p67  = pF "p67"
    p68  = pF "p68"
    p69  = pF "p69"
    p70  = pF "p70"
    p71  = pF "p71"
    p72  = pF "p72"
    p73  = pF "p73"
    p74  = pF "p74"
    p75  = pF "p75"
    p76  = pF "p76"
    p77  = pF "p77"
    p78  = pF "p78"
    p79  = pF "p79"
    p80  = pF "p80"
    p81  = pF "p81"
    p82  = pF "p82"
    p83  = pF "p83"
    p84  = pF "p84"
    p85  = pF "p85"
    p86  = pF "p86"
    p87  = pF "p87"
    p88  = pF "p88"
    p89  = pF "p89"
    p90  = pF "p90"
    p91  = pF "p91"
    p92  = pF "p92"
    p93  = pF "p93"
    p94  = pF "p94"
    p95  = pF "p95"
    p96  = pF "p96"
    p97  = pF "p97"
    p98  = pF "p98"
    p99  = pF "p99"
    p100 = pF "p100"
    p101 = pF "p101"
    p102 = pF "p102"
    p103 = pF "p103"
    p104 = pF "p104"
    p105 = pF "p105"
    p106 = pF "p106"
    p107 = pF "p107"
    p108 = pF "p108"
    p109 = pF "p109"
    p110 = pF "p110"
    p111 = pF "p111"
    p112 = pF "p112"
    p113 = pF "p113"
    p114 = pF "p114"
    p115 = pF "p115"
    p116 = pF "p116"
    p117 = pF "p117"
    p118 = pF "p118"
    p119 = pF "p119"
    p120 = pF "p120"
    p121 = pF "p121"
    p122 = pF "p122"
    p123 = pF "p123"
    p124 = pF "p124"
    p125 = pF "p125"
    p126 = pF "p126"
    p127 = pF "p127"
    tidalControllerParamList = [p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,p40,p41,p42,p43,p44,p45,p46,p47,p48,p49,p50,p51,p52,p53,p54,p55,p56,p57,p58,p59,p60,p61,p62,p63,p64,p65,p66,p67,p68,p69,p70,p71,p72,p73,p74,p75,p76,p77,p78,p79,p80,p81,p82,p83,p84,p85,p86,p87,p88,p89,p90,p91,p92,p93,p94,p95,p96,p97,p98,p99,p100,p101,p102,p103,p104,p105,p106,p107,p108,p109,p110,p111,p112,p113,p114,p115,p116,p117,p118,p119,p120,p121,p122,p123,p124,p125,p126,p127]
    applyToAllPs x = p0 x # p1 x # p2 x # p3 x # p4 x # p5 x # p6 x # p7 x # p8 x # p9 x # p10 x # p11 x # p12 x  # p13 x  # p14 x  # p15 x  # p16 x  # p17 x  # p18 x  # p19 x  # p20 x  # p21 x  # p22 x  # p23 x  # p24 x  # p25 x  # p26 x  # p27 x  # p28 x  # p29 x  # p30 x  # p31 x  # p32 x  # p33 x  # p34 x  # p35 x  # p36 x  # p37 x  # p38 x  # p39 x  # p40 x  # p41 x  # p42 x  # p43 x  # p44 x  # p45 x  # p46 x  # p47 x  # p48 x  # p49 x  # p50 x  # p51 x  # p52 x  # p53 x  # p54 x  # p55 x  # p56 x  # p57 x  # p58 x  # p59 x  # p60 x  # p61 x  # p62 x  # p63 x  # p64 x  # p65 x  # p66 x  # p67 x  # p68 x  # p69 x  # p70 x  # p71 x  # p72 x  # p73 x  # p74 x  # p75 x  # p76 x  # p77 x  # p78 x  # p79 x  # p80 x  # p81 x  # p82 x  # p83 x  # p84 x  # p85 x  # p86 x  # p87 x  # p88 x  # p89 x  # p90 x  # p91 x  # p92 x  # p93 x  # p94 x  # p95 x  # p96 x  # p97 x  # p98 x  # p99 x  # p100 x # p101 x # p102 x # p103 x # p104 x # p105 x # p106 x # p107 x # p108 x # p109 x # p110 x # p111 x # p112 x # p113 x # p114 x # p115 x # p116 x # p117 x # p118 x # p119 x # p120 x # p121 x # p122 x # p123 x # p124 x # p125 x # p126 x # p127 x  
:}
 


:{
let combineControlPatterns :: [Pattern Double -> ControlPattern] -> Pattern Double -> Pattern ValueMap
    combineControlPatterns fs p = foldr (\f acc -> Map.union <$> f p <*> acc) (pure Map.empty) fs
:}



-- :t map (\x -> (#) x rand)
--  
-- :t paramList
-- 
-- :t foldl
--  
-- let huh x = foldl (\p0 p -> p0 . (# p x)) id paramList
--  
-- let huh2 x = foldl1 (\p0 p -> p0 # p x) paramList
-- 
-- let huh x = foldl1 (\p0 p -> p0 . (# p x)) [p0,p1]
-- 
-- :t \x -> foldl1 (\p0 p -> p0 . (# p x))
-- :t paramList
-- 
--  
-- :t "2" # p0 "huh"
--  
-- :t s "bd" # huh
-- 
-- :t (#)
--  
-- import qualified Data.Map.Strict     as Map
--  
-- 
-- 
-- combinedPattern = combineControlPatterns paramList
-- examplePattern = combinedPattern rand
 
 
