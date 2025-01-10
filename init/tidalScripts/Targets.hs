import Sound.Tidal.Context
-- import Control.Concurrent (threadDelay)
-- import Control.Concurrent.MVar (readMVar)
import qualified Control.Monad as CM
import qualified Sound.Tidal.Stream
-- import qualified Sound.Tidal.Tempo as T


-- used for sending custom calls to superdirt functions on a specific OSC path
:{
superdirtMessageOSC :: OSC
superdirtMessageOSC = OSC "/scMessage" $ Named ["scMessage"]
:}


:{
let nannouTarget :: Target
    nannouTarget = superdirtTarget {oName = "nannou", oPort = 34254}
    nannouOSC = OSC "/nannou" $ Named {requiredArgs = []}
:}

:{
let p5jsDirtTarget :: Target
    p5jsDirtTarget = superdirtTarget {oName = "p5jsDirt", oPort = 57130}
    p5jsDirtOSC = OSC "/p5" $ Named {requiredArgs = []}
:}

:{
let godotTarget :: Target
    godotTarget = superdirtTarget {oName = "godot", oPort = 14000}
    godotOSC = OSC "/godot" $ Named {requiredArgs = []}
:}


:{
let visTarget :: Target
    visTarget = Target { oName = "Pattern handler", oAddress = "127.0.0.1", oPort = 5050, oBusPort = Nothing, oLatency = 0.02, oWindow = Nothing, oSchedule = Pre BundleStamp, oHandshake = False }
    visOSC = OSC "/vis" $ Named {requiredArgs = []}


:}
 

:{
let faustTstTarget :: Target
    faustTstTarget = superdirtTarget {oName = "faust", oPort = 5510, oHandshake = False}
    faustTstOSC = OSC "/gain" $ Named {requiredArgs = []}
:}
 

:{
let oscdumpTarget :: Target
    oscdumpTarget = superdirtTarget {oName = "oscdump", oPort = 5223, oSchedule = Live, oHandshake = False}
    oscdumpOSC = OSC "/oscdump" $ Named {requiredArgs = []}
:}
 

:{
let touchdesignerTarget :: Target
    touchdesignerTarget = superdirtTarget {oName = "touchdesigner", oPort = 5224, oSchedule = Live, oHandshake = False}
    touchdesignerOSC = OSC "/touchdesigner" $ Named {requiredArgs = []}
:}
 

:{
let ericTarget :: Target
    ericTarget = superdirtTarget {oAddress = "192.168.1.2", oPort = 5432, oHandshake = False}
    ericOSC = OSC "/freq" $ Named {requiredArgs = []}
:}


:{
let liveTarget = Target {oName = "Max", -- Give your target a name
                      oAddress = "127.0.0.1", -- the target network address
                      oPort = 2020, -- the target network port
                      oLatency = 0.1, -- the latency (to smooth network jitter
                      oSchedule = Live,
                      oWindow = Nothing,
                      oHandshake = False,
                      oBusPort = Nothing
                      }
    liveOSC = OSC "/dirt/play" $ Named {requiredArgs = []}
:}
 
:{
let liveTargetDebug = Target {oName = "Max", -- Give your target a name
                      oAddress = "127.0.0.1", -- the target network address
                      oPort = 2021, -- the target network port
                      oLatency = 0.1, -- the latency (to smooth network jitter
                      oSchedule = Live,
                      oWindow = Nothing,
                      oHandshake = False,
                      oBusPort = Nothing
                      }
    liveOSC = OSC "/dirt/play" $ Named {requiredArgs = []}
:}
 



-- :{
-- let patternTarget = OSCTarget { oName = "Pattern handler", oAddress = "127.0.0.1", oPort = 5050, oPath = "/trigger/something", oShape = Nothing, oLatency = 0.02, oPreamble = [], oTimestamp = BundleStamp }
--     -- OSCTarget for play music via SuperCollider.
--     musicTarget = superdirtTarget { oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120 }
--     config = defaultConfig {cFrameTimespan = 1/20}
--  -- Send pattern as osc both to SC and to tidal-vis
--     tidal <- startMulti [musicTarget, patternTarget] config
-- :}

-- :{
-- let scMessageTarget :: Target
--     scMessageTarget = Target {oName = "SuperDirt",
--                           oAddress = "127.0.0.1",
--                           oPort = 57120,
--                           oLatency = 0.2,
--                           oWindow = Nothing,
--                           oSchedule = Pre BundleStamp
--                          }
-- :}

import Data.List

:{
tidalTarget = superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}
:}

-- :{
-- let osc2whTarget = superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.2", oPort = 9000}
--     osc2whOSC = OSC "/osc2wh" $ $ ArgList [("s", Nothing),
--                                   ("vowel", Just $ VS "a"),
--                                   ("pan", Just $ VF 0.5),
--                                   ("volume", Just $ VF 1),
--                                   ("cut", Just $ VI 1),
--                                   ("intensity", Just $ VI 0)
--                                 ]
-- :}

:{
tidal <- startStream (defaultConfig) 
          [
          (tidalTarget,[superdirtShape,superdirtMessageOSC])
--          , (oscdumpTarget,[oscdumpOSC])
          ,(touchdesignerTarget,[touchdesignerOSC])
          ,(liveTarget, [liveOSC])
          ,(liveTargetDebug, [liveOSC])
          -- , (ericTarget,[ericOSC])
          -- , (p5jsDirtTarget,[p5jsDirtOSC])
          -- , (faustTstTarget,[faustTstOSC])
          -- , (godotTarget,[godotOSC])
          -- , (visTarget,[visOSC])
          -- , (nannouTarget,[nannouOSC])
          -- , (osc2whTarget,[osc2whOSC])
          ]
:}

-- :{
-- glslViewerTarget :: Target
-- glslViewerTarget = superdirtTarget {oName = "glslViewer",
--                            oAddress = "127.0.0.1:/u_",
--                            oPort = 57140,
--                            oLatency = 0.02
--                             }
-- :}


:{
let setI = streamSetI tidal
    setF = streamSetF tidal
    setS = streamSetS tidal
    setR = streamSetI tidal
    setB = streamSetB tidal
:}


putStrLn "loaded Targets.hs"







