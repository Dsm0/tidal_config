import Sound.Tidal.Context
-- import Control.Concurrent (threadDelay)
-- import Control.Concurrent.MVar (readMVar)
import qualified Control.Monad as CM
import qualified Sound.Tidal.Stream
import qualified Sound.Tidal.Tempo as T


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
--     osc2whOSC = OSC "/osc2wh" $ Named {requiredArgs = []}
-- :}

:{
tidal <- startStream (defaultConfig {cFrameTimespan = 1/20 , cTempoPort = 9611}) 
          [
          (tidalTarget,[superdirtShape,superdirtMessageOSC])
          -- , (p5jsDirtTarget,[p5jsDirtOSC])
          -- , (godotTarget,[godotOSC])
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
