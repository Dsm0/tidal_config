-- NOTE: should update this according to output of TidalSynth textbox


:{
let osc1_shape = pF "p0"
    osc1_detune = pF "p1"
    osc1_fm = pF "p2"
    osc2_shape = pF "p3"
    osc2_ring_modulation = pF "p4"
    osc2_sync = pF "p5"
    osc2_kbd_track = pF "p6"
    osc2_pitch = pF "p7"
    osc2_fine_tune = pF "p8"
    osc_mod_env_on_off = pF "p9"
    osc_mod_env_attack = pF "p10"
    osc_mod_env_decay = pF "p11"
    osc_mod_env_amount = pF "p12"
    osc_mod_dest = pF "p13"
    osc_mix = pF "p14"
    osc_pulse_width = pF "p15"
    osc_phase_shift = pF "p16"
    osc1_2_fine_tune = pF "p17"
    osc_key_shift = pF "p18"
    amp_attack = pF "p19"
    amp_decay = pF "p20"
    amp_sustain = pF "p21"
    osc1_sub_octave = pF "p22"
    osc1_sub_gain = pF "p23"
    amp_release = pF "p24"
    amp_gain = pF "p25"
    amp_velocity_sens = pF "p26"
    effect_on_off = pF "p27"
    effect_control1 = pF "p28"
    effect_control2 = pF "p29"
    effect_level_mix = pF "p30"
    filter_attack = pF "p31"
    filter_decay = pF "p32"
    filter_sustain = pF "p33"
    filter_release = pF "p34"
    filter_amount = pF "p35"
    filter_freq = pF "p36"
    filter_resonance = pF "p37"
    filter_saturation = pF "p38"
    filter_velocity_switch = pF "p39"
    arpeggiator_oct_range = pF "p40"
    filter_kbd_track = pF "p41"
    filter_type = pF "p42"
    osc1_sub_shape = pF "p43"
    equalizer_freq = pF "p44"
    equalizer_level = pF "p45"
    equalizer_q = pF "p46"
    equalizer_tone = pF "p47"
    pan = pF "p48"
    delay_on_off = pF "p49"
    delay_time = pF "p50"
    delay_time_spread = pF "p51"
    delay_feedback = pF "p52"
    delay_tone = pF "p53"
    delay_dry_wet = pF "p54"
    chorus_on_off = pF "p55"
    chorus_delay_time = pF "p56"
    chorus_type = pF "p57"
    chorus_depth = pF "p58"
    chorus_rate = pF "p59"
    chorus_feedback = pF "p60"
    chorus_level = pF "p61"
    lfo1_on_off = pF "p62"
    lfo1_destination = pF "p63"
    lfo1_speed = pF "p64"
    lfo1_depth = pF "p65"
    lfo1_tempo_sync = pF "p66"
    lfo1_key_sync = pF "p67"
    lfo2_destination = pF "p68"
    lfo2_on_off = pF "p69"
    lfo2_speed = pF "p70"
    lfo2_depth = pF "p71"
    lfo1_type = pF "p72"
    lfo2_key_sync = pF "p73"
    arpeggiator_on_off = pF "p74"
    arpeggiator_type = pF "p75"
    arpeggiator_beat = pF "p76"
    arpeggiator_gate = pF "p77"
    pitch_bend_range = pF "p78"
    midi_ctrl_src1 = pF "p79"
    midi_ctrl_assign1 = pF "p80"
    midi_ctrl_src2 = pF "p81"
    midi_ctrl_assign2 = pF "p82"
    effect_type = pF "p83"
    delay_type = pF "p84"
    play_mode_type = pF "p85"
    unison_mode = pF "p86"
    portament_auto_mode = pF "p87"
    portament_time = pF "p88"
    unison_voice_num = pF "p89"
    unison_detune = pF "p90"
    unison_phase_shift = pF "p91"
    unison_pan_spread = pF "p92"
    unison_pitch = pF "p93"
    lfo2_type = pF "p94"
    lfo2_tempo_sync = pF "p95"
    midi_ctrl_sens1 = pF "p96"
    midi_ctrl_sens2 = pF "p97"
:}

 
:{
let makeSynth1Preset x = osc1_shape (x!!0)
      # osc1_fm (x!!1)
      # osc1_detune (x!!2)
      # osc2_shape (x!!3)
      # osc2_pitch (x!!4)
      # osc2_fine_tune (x!!5)
      # osc2_kbd_track (x!!6)
      # osc_mix (x!!7)
      # osc2_sync (x!!8)
      # osc2_ring_modulation (x!!9)
      # osc_pulse_width (x!!10)
      # osc_key_shift (x!!11)
      # osc_mod_env_on_off (x!!12)
      # osc_mod_env_amount (x!!13)
      # osc_mod_env_attack (x!!14)
      # osc_mod_env_decay (x!!15)
      # osc_mod_dest (x!!16)
      # osc1_2_fine_tune (x!!17)
      # osc_phase_shift (x!!18)
      # osc1_sub_gain (x!!19)
      # osc1_sub_shape (x!!20)
      # osc1_sub_octave (x!!21)
      # filter_type (x!!22)
      # filter_attack (x!!23)
      # filter_decay (x!!24)
      # filter_sustain (x!!25)
      # filter_release (x!!26)
      # filter_freq (x!!27)
      # filter_resonance (x!!28)
      # filter_amount (x!!29)
      # filter_kbd_track (x!!30)
      # filter_saturation (x!!31)
      # filter_velocity_switch (x!!32)
      # amp_attack (x!!33)
      # amp_decay (x!!34)
      # amp_sustain (x!!35)
      # amp_release (x!!36)
      # amp_gain (x!!37)
      # amp_velocity_sens (x!!38)
      # arpeggiator_on_off (x!!39)
      # arpeggiator_type (x!!40)
      # arpeggiator_oct_range (x!!41)
      # arpeggiator_beat (x!!42)
      # arpeggiator_gate (x!!43)
      # delay_on_off (x!!44)
      # delay_type (x!!45)
      # delay_time (x!!46)
      # delay_time_spread (x!!47)
      # delay_feedback (x!!48)
      # delay_tone (x!!49)
      # delay_dry_wet (x!!50)
      # chorus_on_off (x!!51)
      # chorus_type (x!!52)
      # chorus_delay_time (x!!53)
      # chorus_depth (x!!54)
      # chorus_rate (x!!55)
      # chorus_feedback (x!!56)
      # chorus_level (x!!57)
      # equalizer_tone (x!!58)
      # equalizer_freq (x!!59)
      # equalizer_level (x!!60)
      # equalizer_q (x!!61)
      # pan (x!!62)
      # effect_on_off (x!!63)
      # effect_type (x!!64)
      # effect_control1 (x!!65)
      # effect_control2 (x!!66)
      # effect_level_mix (x!!67)
      # play_mode_type (x!!68)
      # portament_time (x!!69)
      # portament_auto_mode (x!!70)
      # unison_mode (x!!71)
      # unison_voice_num (x!!72)
      # unison_detune (x!!73)
      # unison_pan_spread (x!!74)
      # unison_pitch (x!!75)
      # unison_phase_shift (x!!76)
      # pitch_bend_range (x!!77)
      # midi_ctrl_src1 (x!!78)
      # midi_ctrl_sens1 (x!!79)
      # midi_ctrl_assign1 (x!!80)
      # midi_ctrl_src2 (x!!81)
      # midi_ctrl_sens2 (x!!82)
      # midi_ctrl_assign2 (x!!83)
      # lfo1_on_off (x!!84)
      # lfo1_destination (x!!85)
      # lfo1_type (x!!86)
      # lfo1_speed (x!!87)
      # lfo1_depth (x!!88)
      # lfo1_tempo_sync (x!!89)
      # lfo1_key_sync (x!!90)
      # lfo2_on_off (x!!91)
      # lfo2_destination (x!!92)
      # lfo2_type (x!!93)
      # lfo2_speed (x!!94)
      # lfo2_depth (x!!95)
      # lfo2_tempo_sync (x!!96)
      # lfo2_key_sync (x!!97)
    applyPatternFromList lst pat = innerJoin $ fit 0 lst pat
:}
 







:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_01.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_02.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_03.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_04.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_05.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_06.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_07.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_08.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_09.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_10.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/aaa_bbb_Thanks_Ms_Ichiro_11.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Alfmeister_s_Magic_Cracker.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Ami_Evan.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/aMUSEd_Atonal_Abstractions.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Argon2005_Argon.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Argon2005_Electric_Dreams.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Art_Institute_Vol_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Art_Institute_Vol_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/AZur_Studio_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/AZur_Studio_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/AZur_Studio_3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/ballacr75_BE_Random_Patch_Generator.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/barrybitter_I_Let_The_Dogs_Out.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/BIGTONE.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bigtone_synth1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Bomfunk.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Bryan_Lake.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bstageboss_Famous_Sounds_addendum.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bstageboss_Vivolator.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bwwd_s_Gold.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bwwd_s_Green.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/bwwd_s_Pads.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Chris_Feeltune_Vol.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Christoph_Mueller_Synthhunter.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Civilized_Creation.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/CommanderRobot_Chiptune_&_Lofi_Bank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/crispydinner_BonkerBank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Damien_Chamizo_Audiowhore_128.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Damien_Chamizo_Audiowhore_Techno_Essentials.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Damien_Chamizo_Audiowhore_Unison_Delights.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/devilnishy_NISH_2011_Organs_n_Stabs.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Dezma_Soundbank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/do_androids_dream_bladerunner.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Dogmeat_Saws_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Dogmeat_Saws_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/dover666.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/DrFx.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/EvilDragon.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/factory_preset.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Factory_Presets.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Filter303.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Filter303_FX.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/GeckoYamori_Gecko.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Hanz_Meyzer_Dance_In_The_Bureau_Presets.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/JamesXIIC.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/JasonMythos_Synth1_PsytrancePresets_RekkerdOrg.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/jf1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Joel_Bisson.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Joel_Bisson_Synthematic.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/JS_Hip_Hop_Collection.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/kaiyoti_bank01.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Kel.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/kevosince85_CreateAudio_Presets_45.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/KoolKool_Euro_Nam_Bank_118.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/KoolKool_EuroBeat.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/KoolKool_Star_Nam.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/KoolKool_Star_Nam__Bonus_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/KvR_Soundbank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/LiKwid_DaTaBaSsEs.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Lila_K.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_1Luck_s_Rainbow.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_Dark_Equinox_LK.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_DECA.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_Gaura_Nitai_LK.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_Janus_LK.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_LK_Kultura.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_LK_Monstronomo.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_OZAmbient.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_P0LARS_LK_2011.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_Phuturama_LK.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_X_Ploded_LK.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/lucknow13_z13_Caution_z13_lk.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Lunatique.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Madame_Eljay.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Mark_van_Schaik_Mach1_Presets.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/mickygemma_synth1_soundbank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/MisterToast_Toast.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Mr_Wobble_Vol.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Mr_Wobble_Zen.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Mutant.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/neko_s_Braindance.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/neko_s_The_80_s.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/NielsenSound_EDM.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Nine_Of_Kings.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Nolwenn_Ann_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Nolwenn_Ann_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Nolwenn_Ann_3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Ouroboros_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Ouroboros_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Ouroboros_3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Pencilgod_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Pencilgod_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Pencilgod_3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Pencilgod_4.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/peterdh_Bank2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Photonic_Signal_Lost.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Project_Mars_The_Flight_Soundbank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Pummel_s_Filtered_FM.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Reinhard_Reschner_Echopark.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/RetroHead_GMulator_Vol.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Richard_Semper.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Rob_Rouleau_Dance.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Rydeen.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/rydsound.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/S1_Project_Sound_Library.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/sagamusix_Colors_Of_Synth1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Schiffbauer_Kujashi.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Schiffbauer_Kujashi_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Schiffbauer_Kujashi_3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Schiffbauer_Kujashi_4.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/sin_night_Sinusoidal_NIghtmare__16_patches_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Sonicstyle_Trance_&_Techno.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_00.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_01.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_02.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_03.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_04.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_05.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_06.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_07.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_08.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_09.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_10.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_11.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_12.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_13.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_14.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_15.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_16.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_17.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_18.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SOS_Synth1_NordLeadII_A_19.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SSR.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Stephan_Musch_RSMUS7_1__Arp_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Stephan_Musch_RSMUS7_2__Bass_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Stephan_Musch_RSMUS7_3__Pad_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Summa_&_DocT.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Summa_Welcome2Mac.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth1_Bank2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth1_DubstepandDnB.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth1_Ouroboros_Bank3.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth1_Xenos_Signature.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth_1_Teksonik_2008Edit.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth_1Lucks_Rainbow_bank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synthematic_Techno_Illusion.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synthgeek.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Synthmorph_Pluto_Box.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/synthmorph_synth1_pluto_box_free.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/SynthSynthesizer_User_Group_EinTon.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/TC_Synth1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Techno_Essential.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_2008_Edit.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_4.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_50_More_Sounds.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_64_More_Sounds.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/test.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Tim_Conrardy.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Timfonie.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/TNK_Analog_Dream.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/tnk_analogdream.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Toast_Synthhunter_Atonal_Abstractions_Axiom_EinTon__5_in_1_.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Tonius_1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Tonius_2.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Tororo33.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/trancetechnosoundbanks.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/uncle236_Electro.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Velislav_Synth1_Presets.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/VitaminD_The_Definitive_Bank.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Wavephonic.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Wowoma.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/X_Protocol_S1.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Xenos_Dubstep_&_DnB.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Xenos_Signature.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/XIC.hs
-- :script ~/.config/tidal/init/tidalScripts/synth1Presets/Yaka.hs
 



:{
let ahhhhhhhhhhhhhhhhhhh = [ synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_01 
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_02
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_03
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_04
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_05
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_06
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_07
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_08
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_09
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_10
        ,synth1Presets_aaa_bbb_Thanks_Ms_Ichiro_11
                           -- ,synth1Presets_Alfmeister_s_Magic_Cracker
                           -- ,synth1Presets_Ami_Evan
                           -- ,synth1Presets_aMUSEd_Atonal_Abstractions
                           -- ,synth1Presets_Argon2005_Argon
                           -- ,synth1Presets_Argon2005_Electric_Dreams
                           -- ,synth1Presets_Art_Institute_Vol_1
                           -- ,synth1Presets_Art_Institute_Vol_2
                           -- ,synth1Presets_AZur_Studio_1
                           -- ,synth1Presets_AZur_Studio_2
                           -- ,synth1Presets_AZur_Studio_3
                           -- ,synth1Presets_ballacr75_BE_Random_Patch_Generator
                           -- ,synth1Presets_barrybitter_I_Let_The_Dogs_Out
                           -- ,synth1Presets_BIGTONE
                           -- ,synth1Presets_bigtone_synth1
                           -- ,synth1Presets_Bomfunk
                           -- ,synth1Presets_Bryan_Lake
                           -- ,synth1Presets_bstageboss_Famous_Sounds_addendum
                           -- ,synth1Presets_bstageboss_Vivolator
                           -- ,synth1Presets_bwwd_s_Gold
                           -- ,synth1Presets_bwwd_s_Green
                           -- ,synth1Presets_bwwd_s_Pads
                           -- ,synth1Presets_Chris_Feeltune_Vol
                           -- ,synth1Presets_Christoph_Mueller_Synthhunter
                           -- ,synth1Presets_Civilized_Creation
                           -- ,synth1Presets_CommanderRobot_Chiptune_&_Lofi_Bank
                           -- ,synth1Presets_crispydinner_BonkerBank
                           -- ,synth1Presets_Damien_Chamizo_Audiowhore_128
                           -- ,synth1Presets_Damien_Chamizo_Audiowhore_Techno_Essentials
                           -- ,synth1Presets_Damien_Chamizo_Audiowhore_Unison_Delights
                           -- ,synth1Presets_devilnishy_NISH_2011_Organs_n_Stabs
                           -- ,synth1Presets_Dezma_Soundbank
                           -- ,synth1Presets_do_androids_dream_bladerunner
                           -- ,synth1Presets_Dogmeat_Saws_1
                           -- ,synth1Presets_Dogmeat_Saws_2
                           -- ,synth1Presets_dover666
                           -- ,synth1Presets_DrFx
                           -- ,synth1Presets_EvilDragon
                           -- ,synth1Presets_factory_preset
                           -- ,synth1Presets_Factory_Presets
                           -- ,synth1Presets_Filter303
                           -- ,synth1Presets_Filter303_FX
                           -- ,synth1Presets_GeckoYamori_Gecko
                           -- ,synth1Presets_Hanz_Meyzer_Dance_In_The_Bureau_Presets
                           -- ,synth1Presets_JamesXIIC
                           -- ,synth1Presets_JasonMythos_Synth1_PsytrancePresets_RekkerdOrg
                           -- ,synth1Presets_jf1
                           -- ,synth1Presets_Joel_Bisson
                           -- ,synth1Presets_Joel_Bisson_Synthematic
                           -- ,synth1Presets_JS_Hip_Hop_Collection
                           -- ,synth1Presets_kaiyoti_bank01
                           -- ,synth1Presets_Kel
                           -- ,synth1Presets_kevosince85_CreateAudio_Presets_45
                           -- ,synth1Presets_KoolKool_Euro_Nam_Bank_118
                           -- ,synth1Presets_KoolKool_EuroBeat
                           -- ,synth1Presets_KoolKool_Star_Nam
                           -- ,synth1Presets_KoolKool_Star_Nam__Bonus_
                           -- ,synth1Presets_KvR_Soundbank
                           -- ,synth1Presets_LiKwid_DaTaBaSsEs
                           -- ,synth1Presets_Lila_K
                           -- ,synth1Presets_lucknow13_1Luck_s_Rainbow
                           -- ,synth1Presets_lucknow13_Dark_Equinox_LK
                           -- ,synth1Presets_lucknow13_DECA
                           -- ,synth1Presets_lucknow13_Gaura_Nitai_LK
                           -- ,synth1Presets_lucknow13_Janus_LK
                           -- ,synth1Presets_lucknow13_LK_Kultura
                           -- ,synth1Presets_lucknow13_LK_Monstronomo
                           -- ,synth1Presets_lucknow13_OZAmbient
                           -- ,synth1Presets_lucknow13_P0LARS_LK_2011
                           -- ,synth1Presets_lucknow13_Phuturama_LK
                           -- ,synth1Presets_lucknow13_X_Ploded_LK
                           -- ,synth1Presets_lucknow13_z13_Caution_z13_lk
                           -- ,synth1Presets_Lunatique
                           -- ,synth1Presets_Madame_Eljay
                           -- ,synth1Presets_Mark_van_Schaik_Mach1_Presets
                           -- ,synth1Presets_mickygemma_synth1_soundbank
                           -- ,synth1Presets_MisterToast_Toast
                           -- ,synth1Presets_Mr_Wobble_Vol
                           -- ,synth1Presets_Mr_Wobble_Zen
                           -- ,synth1Presets_Mutant
                           -- ,synth1Presets_neko_s_Braindance
                           -- ,synth1Presets_neko_s_The_80_s
                           -- ,synth1Presets_NielsenSound_EDM
                           -- ,synth1Presets_Nine_Of_Kings
                           -- ,synth1Presets_Nolwenn_Ann_1
                           -- ,synth1Presets_Nolwenn_Ann_2
                           -- ,synth1Presets_Nolwenn_Ann_3
                           -- ,synth1Presets_Ouroboros_1
                           -- ,synth1Presets_Ouroboros_2
                           -- ,synth1Presets_Ouroboros_3
                           -- ,synth1Presets_Pencilgod_1
                           -- ,synth1Presets_Pencilgod_2
                           -- ,synth1Presets_Pencilgod_3
                           -- ,synth1Presets_Pencilgod_4
                           -- ,synth1Presets_peterdh_Bank2
                           -- ,synth1Presets_Photonic_Signal_Lost
                           -- ,synth1Presets_Project_Mars_The_Flight_Soundbank
                           -- ,synth1Presets_Pummel_s_Filtered_FM
                           -- ,synth1Presets_Reinhard_Reschner_Echopark
                           -- ,synth1Presets_RetroHead_GMulator_Vol
                           -- ,synth1Presets_Richard_Semper
                           -- ,synth1Presets_Rob_Rouleau_Dance
                           -- ,synth1Presets_Rydeen
                           -- ,synth1Presets_rydsound
                           -- ,synth1Presets_S1_Project_Sound_Library
                           -- ,synth1Presets_sagamusix_Colors_Of_Synth1
                           -- ,synth1Presets_Schiffbauer_Kujashi
                           -- ,synth1Presets_Schiffbauer_Kujashi_2
                           -- ,synth1Presets_Schiffbauer_Kujashi_3
                           -- ,synth1Presets_Schiffbauer_Kujashi_4
                           -- ,synth1Presets_sin_night_Sinusoidal_NIghtmare__16_patches_
                           -- ,synth1Presets_Sonicstyle_Trance_&_Techno
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_00
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_01
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_02
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_03
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_04
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_05
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_06
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_07
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_08
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_09
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_10
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_11
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_12
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_13
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_14
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_15
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_16
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_17
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_18
                           -- ,synth1Presets_SOS_Synth1_NordLeadII_A_19
                           -- ,synth1Presets_SSR
                           -- ,synth1Presets_Stephan_Musch_RSMUS7_1__Arp_
                           -- ,synth1Presets_Stephan_Musch_RSMUS7_2__Bass_
                           -- ,synth1Presets_Stephan_Musch_RSMUS7_3__Pad_
                           -- ,synth1Presets_Summa_and_DocT
                           -- ,synth1Presets_Summa_Welcome2Mac
                           -- ,synth1Presets_Synth1_Bank2
                           -- ,synth1Presets_Synth1_DubstepandDnB
                           -- ,synth1Presets_Synth1_Ouroboros_Bank3
                           -- ,synth1Presets_Synth1_Xenos_Signature
                           -- ,synth1Presets_Synth_1_Teksonik_2008Edit
                           -- ,synth1Presets_Synth_1Lucks_Rainbow_bank
                           -- ,synth1Presets_Synthematic_Techno_Illusion
                           -- ,synth1Presets_Synthgeek
                           -- ,synth1Presets_Synthmorph_Pluto_Box
                           -- ,synth1Presets_synthmorph_synth1_pluto_box_free
                           -- ,synth1Presets_SynthSynthesizer_User_Group_EinTon
                           -- ,synth1Presets_TC_Synth1
                           -- ,synth1Presets_Techno_Essential
                           -- ,synth1Presets_Teksonik_1
                           -- ,synth1Presets_Teksonik_2
                           -- ,synth1Presets_Teksonik_2008_Edit
                           -- ,synth1Presets_Teksonik_4
                           -- ,synth1Presets_Teksonik_50_More_Sounds
                           -- ,synth1Presets_Teksonik_64_More_Sounds
                           -- ,synth1Presets_test
                           -- ,synth1Presets_Tim_Conrardy
                           -- ,synth1Presets_Timfonie
                           -- ,synth1Presets_TNK_Analog_Dream
                           -- ,synth1Presets_tnk_analogdream
                           -- ,synth1Presets_Toast_Synthhunter_Atonal_Abstractions_Axiom_EinTon__5_in_1_
                           -- ,synth1Presets_Tonius_1
                           -- ,synth1Presets_Tonius_2
                           -- ,synth1Presets_Tororo33
                           -- ,synth1Presets_trancetechnosoundbanks
                           -- ,synth1Presets_uncle236_Electro
                           -- ,synth1Presets_Velislav_Synth1_Presets
                           -- ,synth1Presets_VitaminD_The_Definitive_Bank
                           -- ,synth1Presets_Wavephonic
                           -- ,synth1Presets_Wowoma
                           -- ,synth1Presets_X_Protocol_S1
                           -- ,synth1Presets_Xenos_Dubstep_&_DnB
                           -- ,synth1Presets_Xenos_Signature
                           -- ,synth1Presets_XIC
                           -- ,synth1Presets_Yaka
                           ]
:}




 
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Techno_Essential.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_1.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_2.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Synth_1_Teksonik_2008Edit.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_4.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_50_More_Sounds.hs
:script ~/.config/tidal/init/tidalScripts/synth1Presets/Teksonik_64_More_Sounds.hs

:{
let synth1Presets_bigList = concat [ 
                    synth1Presets_Techno_Essential
                   ,synth1Presets_Teksonik_1
                   ,synth1Presets_Techno_Essential
                   ,synth1Presets_Teksonik_1
                   ,synth1Presets_Teksonik_2
                   ,synth1Presets_Synth_1_Teksonik_2008Edit
                   ,synth1Presets_Teksonik_4
                   ,synth1Presets_Teksonik_50_More_Sounds
                   ,synth1Presets_Teksonik_64_More_Sounds
                  ]
    synth1Patch = 
      applyPatternFromList (map makeSynth1Preset synth1Presets_bigList )
    patch x = pI "patch" x # synth1Patch x
:}



putStrLn "loaded Synth1Presets.hs"
