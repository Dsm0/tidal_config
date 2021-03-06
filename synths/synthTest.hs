 {-# SCC "" #-} do
  hush
  d1 $ ply 2 $ n (fast 2 $ arp "up" "'13") # "testSynth2" # sus 2
     # resonance 0.1 # attack 0.1 # shape 0.3

do
  hush
  d1 $ stack [
    "[gabbertouch*4]" # freq ("220"/2) # gain 1.1
       -- # attack 0.005
       -- # freq 1.3
    # lfoMax 0.001
       -- # lfoMax (slow 2 $ "[0.0001@2 0.0001 0.02]")
     ,

      d2 $ stack [chop 1 $ "roland727:2(5,16,<0 4 5 7>)"
       # shape 0.5 # gain 1.1 # distort 0.3 # room 0.2 # speed 0.8
       # room 0.2] |*| gain 1.5


  
do
  hush
  d1 $ stack [
    "[gabbertouch*16]" # freq ("110"/2)
     # gain 1.1 # distort 0.1 # sus 0.2 # legato 1
     , chop 2 $ "roland727:2(5,16,<0 4 5 7>)"
       # shape 0.5 # gain 1.1 # distort 0.3 # room 0.2 # speed 0.8
       # room 0.2] |*| gain 1.5



lfoMax = pF "lfoMax"
lfoMin = pF "lfoMin"
attack = pF "attack"


-- fm_2

let mRatio = pF "mRatio"
    cRatio = pF "cRatio"
    fmIndex = pF "index"
    iScale = pF "iScale"
    cAttack = pF "cAttack"
    cRel = pF "cRel"
    rel = pF "release"

setcps (80/120)

  -- pretty good
do
  hush
  d1
     $ fast 4
     $ release "2 2.5 0.5 <3 4 0.2 5>"
     # n (slow 64 $ "[-24 -12]")
     # "fm_2"
     # iScale (slow 16 $ range 0.1 2 $ saw)
     # cAttack 2
     # cRel (-0.1)
     # fmIndex 2
     # attack 0.002
     # mRatio (iter 4 $ "[1 2 3 3.1]"/2)
     # gain 1.4
     # distort 0.5
     # orbit 0
     # cut 1
  d2 $ stack
      ["[roland727:2](5,16,<0 4 5 7>)"
       # shape 0.99 # gain 1.4 # distort 0.3
       # orbit 0 # room 0.2
       ] # cut 0

do
  hush
  d1 $ n (arp "up" "<'maj9>" + "<0 [0 7] [5@3 3] -2>/2") # "fm_2" |+| n "-12"
     # sus (slow 2 $ range (0.2) (4) $ saw)
     # release 0.7
     # iScale 0.05
     # cAttack 0.4
     # fmIndex 20
     # attack 0.2
     # shape 0.3
     # mRatio 0.5
