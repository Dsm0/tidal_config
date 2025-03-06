(
SynthDef(\synth1, {
    // Standard args
    var out = \out.kr(0),
        pan = \pan.kr(0),
        gate = \gate.kr(1),
        amp = \amp.kr(0.5),
        freq = \freq.kr(440);

    // Oscillator variables
    var osc1, osc2, sub, noise, mix;

    // Envelope and filter variables
    var env, filter_env, amp_env, filter, sig;

    // LFO variables
    var lfo1, lfo2;

	var debug_sig;

    // Oscillator 1
    osc1 = Select.ar(
        \osc1_shape.kr(0),
        [
            Saw.ar(freq * (2 ** \osc1_octave.kr(0)) * (2 ** (\osc1_semi.kr(0)/12)) * (1 + (\osc1_detune.kr(0)/100))),
            Pulse.ar(freq * (2 ** \osc1_octave.kr(0)), \osc1_pw.kr(0.5)),
            LFTri.ar(freq * (2 ** \osc1_octave.kr(0))),
            SinOsc.ar(freq * (2 ** \osc1_octave.kr(0)))
        ]
    ) * \osc1_level.kr(1);

    // Oscillator 2 with sync and FM
    osc2 = Select.ar(
        \osc2_shape.kr(0),
        [
            Saw.ar(freq * (2 ** \osc2_octave.kr(0)) * (2 ** (\osc2_semi.kr(0)/12)) * (1 + (\osc2_detune.kr(0)/100))),
            Pulse.ar(freq * (2 ** \osc2_octave.kr(0)), \osc2_pw.kr(0.5)),
            LFTri.ar(freq * (2 ** \osc2_octave.kr(0))),
            SinOsc.ar(freq * (2 ** \osc2_octave.kr(0)))
        ]
    ) * \osc2_level.kr(1);

    // Sub oscillator (one octave below osc1)
    sub = SinOsc.ar(freq * 0.5) * \sub_osc_level.kr(0);

    // Noise generator
    noise = WhiteNoise.ar * \noise_level.kr(0);

    // Mixer section
    mix = Mix([osc1, osc2, sub, noise]);

    // LFOs
    lfo1 = Select.kr(
        \lfo1_shape.kr(0),
        [
            SinOsc.kr(\lfo1_rate.kr(1)),
            LFTri.kr(\lfo1_rate.kr(1)),
            LFPulse.kr(\lfo1_rate.kr(1)),
            LFNoise0.kr(\lfo1_rate.kr(1)),
            LFSaw.kr(\lfo1_rate.kr(1)),
            LFSaw.kr(\lfo1_rate.kr(1)).neg
        ]
    ) * \lfo1_amount.kr(0);

    // Filter envelope
    filter_env = Env.adsr(
        \filter_attack.kr(0.01),
        \filter_decay.kr(0.3),
        \filter_sustain.kr(0.5),
        \filter_release.kr(1)
    ).ar(Done.none, gate);

    // Filter section with envelope modulation
    filter = Select.ar(
        \filter_type.kr(0),
        [
            RLPF.ar(mix,
                \cutoff.kr(2000) *
                (1 + (filter_env * \filter_env_amount.kr(0))) *
                (1 + (lfo1 * \lfo1_to_cutoff.kr(0))),
                \resonance.kr(0.2)
            ),
            LPF.ar(mix, \cutoff.kr(2000)),
            BPF.ar(mix, \cutoff.kr(2000), \resonance.kr(0.2)),
            RHPF.ar(mix, \cutoff.kr(2000), \resonance.kr(0.2)),
            Resonz.ar(mix, \cutoff.kr(2000), \resonance.kr(0.2))
        ]
    );

    // Amplitude envelope
    amp_env = Env.adsr(
        \a_attack.kr(0.01),
        \a_decay.kr(0.3),
        \a_sustain.kr(0.5),
        \a_release.kr(1)
    ).ar(Done.freeSelf, gate);


    // Apply envelopes and final amplitude
    sig = filter * amp_env * amp;


    // Effects chain
    sig = Select.ar(
        \dist_amount.kr(0) > 0,
        [
            sig,
            (sig * \dist_amount.kr(0) * 10).tanh
        ]
    );


    // Delay
    sig = sig + (DelayC.ar(
        sig,
        2,
        \delay_time.kr(0.5),
        \delay_feedback.kr(0.3)
    ) * \delay_mix.kr(0));

	debug_sig = sig;

    // Output with panning
	// sig = Pan2.ar(sig, pan);

	// Out.ar(out, sig);

	OffsetOut.ar(out, DirtPan.ar(debug_sig, ~dirt.numChannels, pan, env));
}).add;
)








/*
// FULL PARAM LIST:

let osc1_shape
    osc1_detune
    osc1_fm
    osc2_shape
    osc2_ring_modulation
    osc2_sync
    osc2_kbd_track
    osc2_pitch
    osc2_fine_tune
    osc_mod_env_on_off
    osc_mod_env_attack
    osc_mod_env_decay
    osc_mod_env_amount
    osc_mod_dest
    osc_mix
    osc_pulse_width
    osc_phase_shift
    osc1_2_fine_tune
    osc_key_shift
    amp_attack
    amp_decay
    amp_sustain
    osc1_sub_octave
    osc1_sub_gain
    amp_release
    amp_gain
    amp_velocity_sens
    effect_on_off
    effect_control1
    effect_control2
    effect_level_mix
    filter_attack
    filter_decay
    filter_sustain
    filter_release
    filter_amount
    filter_freq
    filter_resonance
    filter_saturation
    filter_velocity_switch
    arpeggiator_oct_range
    filter_kbd_track
    filter_type
    osc1_sub_shape
    equalizer_freq
    equalizer_level
    equalizer_q
    equalizer_tone
    pan
    delay_on_off
    delay_time
    delay_time_spread
    delay_feedback
    delay_tone
    delay_dry_wet
    chorus_on_off
    chorus_delay_time
    chorus_type
    chorus_depth
    chorus_rate
    chorus_feedback
    chorus_level
    lfo1_on_off
    lfo1_destination
    lfo1_speed
    lfo1_depth
    lfo1_tempo_sync
    lfo1_key_sync
    lfo2_destination
    lfo2_on_off
    lfo2_speed
    lfo2_depth
    lfo1_type
    lfo2_key_sync
    arpeggiator_on_off
    arpeggiator_type
    arpeggiator_beat
    arpeggiator_gate
    pitch_bend_range
    midi_ctrl_src1
    midi_ctrl_assign1
    midi_ctrl_src2
    midi_ctrl_assign2
    effect_type
    delay_type
    play_mode_type
    unison_mode
    portament_auto_mode
    portament_time
    unison_voice_num
    unison_detune
    unison_phase_shift
    unison_pan_spread
    unison_pitch
    lfo2_type
    lfo2_tempo_sync
    midi_ctrl_sens1
    midi_ctrl_sens2

*/


















