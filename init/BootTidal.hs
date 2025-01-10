:set -XOverloadedStrings
:set prompt ""
:set prompt-cont ""
:set -XDataKinds
:set -XFlexibleContexts

-- :!sclang ~/.config/tidal/init/startup-script-form.scd &
-- starts SuperDirt in the background

:{
import Sound.Tidal.Context
:}

-- https://github.com/ndmitchell/hoogle/blob/master/docs/Install.md
-- :def hoogle (\x -> return $ ":!/Users/xxx/Library/Haskell/bin/hoogle --info "++x)

:script ~/.config/tidal/init/tidalScripts/Targets.hs
:script ~/.config/tidal/init/tidalScripts/Transitions.hs
-- :script ~/.config/tidal/init/tidalScripts/SuperDirtInterface.hs
--               ^^^ broken by latest version of tidal
:script ~/.config/tidal/init/tidalScripts/Shorthands.hs
:script ~/.config/tidal/init/tidalScripts/Func.hs

-- declarations for custom synth parameters
:script ~/.config/tidal/init/tidalScripts/CustomSynthParams.hs
:script ~/.config/tidal/init/tidalScripts/CustomEffectParams.hs

:script ~/.config/tidal/init/tidalScripts/Effects.hs
:script ~/.config/tidal/init/tidalScripts/HackYourDaw.hs
-- :script ~/.config/tidal/init/tidalScripts/HackYourDawEffects.hs
-- :script ~/.config/tidal/init/tidalScripts/SuperDirtMixer.hs




-- 
-- :script ~/.config/tidal/init/tidalScripts/TidalLooper.hs
-- optional: for P5hs and VividSynth
-- :script ~/.config/tidal/init/tidalScripts/P5hs.hs
-- :script ~/.config/tidal/init/tidalScripts/BootVivid.hs

-- :script tidalScripts/Targets.hs
-- :script tidalScripts/Targets.hs
-- :script tidalScripts/Targets.hs


-- :{
-- do
--   loadSoundFiles "john"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/games/halflife/apache"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/games/halflife/gman"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/games/halflife/tentacle"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/games/halflife/player"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/tidalSamples/songSamp/mord_fustang_kit"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/tidalSamples/customSamples/rezzett"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/KrazyRemi/SAMMY DRUMS/KICKS"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/KrazyRemi/all_snares_claps_5"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/tidalSamples/findsDig1/mlazer"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/tidalSamples/games/crossniq"
--   loadSoundFiles "/media/ick/5EB068D0139EDA18/tidalSamples/games/gta"
--   bpm 85
-- :}




:set prompt "tidal> "


