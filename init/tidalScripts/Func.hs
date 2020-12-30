import Data.List

:{
let (&) = (|*|)
    lofi = (crush 5.5 # shape 0.8 # lpf 700 # bandf 500 # bpq 0.4)
    ripOLD a b p = within (0.25, 0.75) (slow 2 . rev . stut 8 a b) p
    ripOLD' a b c d e p = within (a, b) (slow 2 . rev . stut c d e) p
    rip a b p = within (0.25, 0.75) (slow 2 . stutWith 8 (b/(-8)) (|* gain a)) p
    rip' a b c d e p = within (a, b) (slow 2 . stutWith c (e/(-8)) (|* gain d)) p
    spike p = ((# delaytime (range 0.001 0.3 $ slow 7.1 sine)) . (# delayfeedback (range 0.7 0.99 $ slow 6.71 sine))) $ p
    spike' p = (# delay "0.3") $ spike $ p
    spike'' p = (# delay "0.4") $ ((# delaytime (range 0.001 0.1 $ slow 6.1 sine)) . (# delayfeedback (range 0.7 0.99 $ slow 5.71 sine))) $ p
    -- ghost'' a f p = superimpose (((a/2 + a*2) ~>) . f) $ superimpose (((a + a/2) ~>) . f) $ p
    -- ghost' a p = ghost'' a ((|* gain "0.7") . (# end "0.2") . (|* speed "1.25")) p
    -- ghost p = ghost' 0.125 p
    jit start amount p = within (start, (start + 0.5)) (trunc (amount)) p
    gtfo p = (const $ sound "~") p
    gtfo' p = (const $ midinote "~") p
    gtfom = gtfo'
    gtfo2 = gtfo'
    shift p = (1 <~)  p
    shift' x p = (x <~) p
    -- choose xs = (xs !!) <$> (irand $ fromIntegral $ length xs)
    one p = stutWith 2 (0.125/2) id $ p
    one' p = rarely (stutWith 2 (0.125/2) id) $ shift' 1024 $ p
    one'' p = sometimes (stutWith 2 (0.125/2) id) $ shift' 1024 $ p
    rep n p = stutWith (n) (0.125*3) id $ p
    rep' n p = stutWith (n) (0.125/2*3) id $ p
    rep'' n p = stutWith (n) (0.125/4*3) id $ p
    beginend bpat durpat = (begin bpat) # (end $ (+) <$> bpat <*> durpat)
    mpent = [0, 3, 5, 7, 10, 12]
    pent = [0, 2, 4, 7, 9, 12]
    inverse 1 = 0
    inverse 0 = 1
    inverse 11 = 0
    inverse 10 = 1
    inv 1 = 0
    inv 0 = 1
    inv 11 = 0
    inv 10 = 1
    bpm x = setcps (x/120)
    brakk samps = ((# unit "c") . (# speed "8")) $ sound (samples samps (irand 30))
    brakk4 samps = ((# unit "c") . (# speed "4")) $ sound (samples samps (irand 30))
    move p = foldEvery [3,4] (0.25 <~) $ p
    move'' p = foldEvery [2,3] (0.25 <~) $ p
    move' p = foldEvery [3,4] (0.25 ~>) $ p
    move''' p = foldEvery [2,3] (0.25 ~>) $ p
    delays = [(1/512), (1/256), (1/128), (1/64), (1/32), (1/16), (1/8)]
    randDelay p = ((# delay (range 0.5 0.7 $ shift' 5001 $ rand)) . (# delaytime (shift' 5002 $ choose delays)) . (# delayfeedback (range 0.5 0.9 $ shift' 5003 $ rand))) $ p
    crumble = slow 2 $ sound "[k*16 ~]/2 ~" # n (run 32)
    rando = randDelay
    foldEVery = foldEvery
    accelrate = accelerate
    discretize = discretise
    crushit p = (# crush (range 3 8 $ slow 1.1 tri)) $ p
    replicator text1 = [putStr (text1) | x <- replicate 500 text1]
    flood text2 = sequence_(replicator text2)
    replicator' n text1 = [putStr (text1) | x <- replicate n text1]
    flood' n text2 = sequence_(replicator' n text2)
    sbank bank pat = s (flip (++) <$> pat <*> bank)
    fxchan = s "midi" # midicmd "control" # midichan "15" # nudge "0.35"
    stdmidinudge p = (|+ nudge "0.2") $ p
    stdvisnudge p = (|+ nudge "0.6") $ p
    ampa = ctlNum 1
    ampd = ctlNum 2
    amps = ctlNum 3
    ampr = ctlNum 4
    pitcha = ctlNum 5
    pitchd = ctlNum 6
    pitchs = ctlNum 7
    pitchr = ctlNum 8
    filta = ctlNum 9
    filtd = ctlNum 10
    filts = ctlNum 11
    filtr = ctlNum 12
    filt = ctlNum 13
    filtEnv = ctlNum 14
    phw = ctlNum 15
    phoff = ctlNum 16
    phwa = ctlNum 17
    phwd = ctlNum 18
    phws = ctlNum 19
    phwr = ctlNum 20
    phoffa = ctlNum 21
    phoffd = ctlNum 22
    phoffs = ctlNum 23
    phoffr = ctlNum 24
    uni = ctlNum 25
    -- slice pi pn p = begin b # end e # p
    -- where b = (\i n -> (div' i n)) <$> pi <*> pn
    -- e = (\i n -> (div' i n) + (div' 1 n)) <$> pi <*> pn
    -- div' a b = fromIntegral (a `mod` b) / fromIntegral b
    ri a = rev (r a) -- run inverted
    rodd a = (((r a) + 1) * 2) - 1 -- run of odd numbers
    reven a = ((r a) + 1) * 2 -- run of even numbers
    roddi a = rev (rodd a) -- run of odd numbers inverted
    reveni a = rev (reven a) -- run of even numbers inverted
    eveni = reveni
    codd a = c $ take a [1,3..] -- choose an odd number
    ceven a = c $ take a [0,2..] -- choose an even number
    thicken' x percent p = superimpose ((# pan 1) . (|* speed percent)) $ ((# speed x) . (# pan 0)) $ p
    thicken p = thicken' 1 0.8 $ p
    thick3n = thicken
    thick3n' = thicken'
    rollany x p = stutWith 2 x id $ p
    roll p = rollany (0.125*3) $ p
    roll' p = rollany (0.0625*3) $ p
    roll'' p = stutWith 2 (shift' 100000 $ choose [(0.0625*3), (0.125*3)]) id $ p
    rollAny = rollany
    preFx =    [("short", (# sus 0.1)),
                ("linger", linger 0.5),
                ("sply", ply "2" . slow 2),
                ("ply", ply "2"),
                ("lofi",(# lofi)),
                ("louder",(& gain 1.7)),
                ("fast", fast 8),
                ("stut", stut 4 0.25 0.125),
                ("panner",(# pan (slow 2 $ sine*2))),
                ("slinger", linger 0.125),
                ("stripe", stripe 2),
                ("basser", off "0.125 0.25" ((# up "-12").(# sus 0.1)).(# cut 3)),
                ("pat1", (struct "t t [f t] [f f t f]")),
                ("1st", (mask "t f f f")),
                ("2ndBeat", (mask "f t f f")),
                ("3rdBeat", (mask "f f t f")),
                ("4thBeat", (mask "f f f t")),
                ("pat2", (struct "[t f t t f]"))]
    parse' = parseBP_E . show
    urLines' x = bracks $ intercalate " , " $ map bracks $ lines x
      where bracks = (\x -> "[" ++ x ++ "]")
    urList' x = bracks $ intercalate " , " $ map bracks $ x
      where bracks = (\x -> "[" ++ x ++ "]")
    urList a b c d = ur a (parseBP_E $ urList' b) c d
    urLines a b c d = ur a (parseBP_E $ urLines' b) c d
    fli = (fast 2 . linger 0.5)
    rand' x = shiftBy x $ rand
    yUp y x = (((y + x)/ y))
    sUp y x = speed (((y + x)/ y))
    nUy y x = up (((y + x)/ y))
    -- frange x y = s((# hpf x) . (# lpf y))
    chordList =["6by9","'7f10","'7f5","'7f9","'7s5","'7s5f9","'7sus2","'7sus4","'9s5","'9sus4","'aug","'dim","'dim7","'dom7","'eleven","'elevenSharp","'five","'m11","'m11s","'m11sharp","'m13m6","'m6by9","'m7f5","'m7f9","'m7flat5","'m7flat9","'m7s5","'m7s9","'m7sharp5","'m7sharp5flat9","'m7sharp9","'m9","'m9s5","'m9sharp5","'maj","'maj11","'maj7", "maj9","'major","'major7","'min","'min7","'minor","'minor7","'msharp5","'nine","'nineSharp5","'nineSus4","'ninesus4","'one","'plus","'sevenFlat10","'sevenFlat5","'sevenFlat9","'sevenSharp5","'sevenSharp5flat9","'sevenSus2","'sevenSus4","'sharp5","'six","'sixby9","'sus2","'sus4","'thirteen"]
    fx cond pat = when cond (# gain 1) $ pat # gain 0
:}





