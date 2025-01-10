import qualified Data.Map as Map_
import Sound.Tidal.Pattern

-- :{
-- let changeFunc' stream list = sendFunc' list
--       where toEvent' ws we ps pe v = Event (Sound.Tidal.Context.Context []) (Just $ Sound.Tidal.Context.Arc ws we) (Sound.Tidal.Context.Arc ps pe) v
--               -- where [ws',we',ps',pe'] = map toRational [ws,we,ps,pe]
--             makeFakeMap list_ = Map_.fromList list_
--             makeFuncHelp :: [(String,Value)] -> ControlPattern
--             makeFuncHelp y = Pattern $ fakeEvent (makeFakeMap y:: ControlMap)
--               where fakeEvent a notARealArgument = [(toEvent' 0 1 0 1) a]
--             makeFunc :: [(String,Value)] -> [ControlPattern]
--             makeFunc x = [makeFuncHelp x]
--             sendFunc' = mapM_ (streamFirst stream) . makeFunc
--     changeFunc stream func newFunction = changeFunc' stream list
--       where list = [(func, VS (render newFunction))]
--     resetFunc stream func = changeFunc stream func (makeJSVar "")
--     makeDraw stream newFunction = changeFunc stream "draw" newFunction
--     makeSetup stream newFunction = changeFunc stream "setup" newFunction
--     makeLoad stream newFunction = changeFunc stream "load" newFunction
--       -- where list = [("scMessage",VS "loadSoundFiles"),("filePath",VS path)]
-- :}



:{

let changeFunc' stream list = sendFunc' list
      where toEvent' ws we ps pe v = Event (Sound.Tidal.Context.Context []) (Just $ Sound.Tidal.Context.Arc ws we) (Sound.Tidal.Context.Arc ps pe) v
              -- where [ws',we',ps',pe'] = map toRational [ws,we,ps,pe]
            makeFakeMap list_ = Map_.fromList list_
            makeFuncHelp :: [(String,Value)] -> ControlPattern
            makeFuncHelp y = Pattern $ fakeEvent (makeFakeMap y:: ValueMap)
              where fakeEvent a notARealArgument = [(toEvent' 0 1 0 1) a]
            makeFunc :: [(String,Value)] -> [ControlPattern]
            makeFunc x = [makeFuncHelp x]
            sendFunc' = mapM_ (streamFirst stream) . makeFunc
    vs x = VS x Nothing
    loadSoundFiles' stream path = changeFunc' stream list
      where list = [("scMessage",vs "loadSoundFiles" ),("filePath",vs path)]
    loadSynthDefs' stream path = changeFunc' stream list
      where list = [("scMessage",vs "loadSynthDefs"),("filePath",vs path)]
    loadOnly' stream path = changeFunc' stream list
      where list = [("scMessage",vs "loadOnly"),("filePath",vs path)]
    loadSoundFileFolder' stream path = changeFunc' stream list
      where list = [("scMessage",vs "loadSoundFileFolder"),("filePath",vs path)]
    loadSoundFile' stream path = changeFunc' stream list
      where list = [("scMessage",vs "loadSoundFile"),("filePath",vs path)]
    freeAllSoundFiles' stream = changeFunc' stream list
      where list = [("scMessage",vs "freeAllSoundFiles")]
    freeSoundFiles' stream name = changeFunc' stream list
      where list = [("scMessage",vs "freeSoundFiles"),("filePath",vs name)]
    postSampleInfo' stream = changeFunc' stream list
      where list = [("scMessage",vs "postSampleInfo")]
    initFreqSynthWindow' stream = changeFunc' stream list
      where list = [("scMessage",vs "initFreqSynthWindow")]

:}


:{
-- functions for sending paths to load into superDirt
let loadSoundFiles path = loadSoundFiles' tidal path 
    loadSynthDefs path = loadSynthDefs' tidal path
    loadOnly path = loadOnly' tidal path
    loadSoundFileFolder path = loadSoundFileFolder' tidal path 
    loadSoundFile path = loadSoundFile' tidal path
    freeAllSoundFiles = freeAllSoundFiles' tidal 
    freeSoundFiles name = freeSoundFiles' tidal name
    postSampleInfo = postSampleInfo' tidal
    initFreqSynthWindow = initFreqSynthWindow' tidal
:}


putStrLn "loaded SuperDirtInterface.hs"
