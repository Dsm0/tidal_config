Software Synthesizer 'Synth1' Design Outline

A subtractive synthesizer with a modular signal chain, divided into core components and modulation systems.
1. Oscillators (Osc1 & Osc2)

Signal Chain Position: First stage.
Parameters:

    Waveform: Sine, Saw, Square, Pulse, Noise, etc.

    Octave/Semi/Fine Tuning: Adjust pitch in octaves, semitones, and cents.

    Pulse Width: Controls duty cycle for square/pulse waves (with PWM modulation input).

    Unison: Number of stacked voices with detune/spread controls.

    Sub-Oscillator: Optional octave-below sine/square wave (mixed with Osc1/2).

Role: Generate raw waveforms as sound sources.
2. Mixer

Signal Chain Position: After oscillators, before filter.
Parameters:

    Osc1/Osc2 Level: Balance volume between oscillators.

    Sub-Osc Level: Adjust sub-octave volume.

    Noise Level: Blend noise generator (white/pink) into the signal.

Role: Combine oscillators, sub-osc, and noise into a single signal.
3. Filter Section

Signal Chain Position: Post-mixer, pre-amplifier.
Parameters:

    Type: Low-pass, High-pass, Band-pass (12dB/oct or 24dB/oct slopes).

    Cutoff: Frequency threshold for attenuation.

    Resonance: Emphasis around the cutoff frequency.

    Key Tracking: Adjusts cutoff based on note pitch.

    Envelope Amount: How much the filter envelope modulates cutoff.

Role: Shape timbre by attenuating specific frequencies.
4. Amplifier (VCA)

Signal Chain Position: Post-filter, pre-effects.
Parameters:

    Level: Overall output volume.

    Pan: Stereo positioning.

Role: Control final volume using the amp envelope.
5. Envelopes

Signal Chain Modulation: Applied to filter (cutoff) and amplifier (volume).
Parameters (ADSR):

    Attack: Time to reach peak level.

    Decay: Time to fall to sustain level.

    Sustain: Sustained level after decay.

    Release: Time to return to zero after note release.

Envelope Types:

    Filter Envelope: Modulates cutoff frequency.

    Amp Envelope: Modulates amplifier level.

6. LFOs (LFO1 & LFO2)

Signal Chain Modulation: Applied to oscillators, filter, or amplifier.
Parameters:

    Waveform: Sine, Square, Triangle, Sample & Hold.

    Rate: Speed (Hz or sync to tempo).

    Depth: Modulation intensity.

    Destination: Pitch, cutoff, pulse width, pan, etc.

Role: Add cyclic modulation (vibrato, tremolo, wobble).
7. Effects Section

Signal Chain Position: Post-amplifier.
Effects Types:

    Chorus: Rate, depth, and mix for thickening.

    Delay: Time, feedback, and stereo width.

    Reverb: Size, damping, and mix for spatial depth.

Role: Apply spatial and time-based effects.
8. Modulation Matrix

Role: Route modulation sources (LFOs, envelopes) to parameters.
Parameters:

    Source: LFO1, LFO2, Filter Envelope, etc.

    Destination: Osc pitch, cutoff, pulse width, etc.

    Amount: Modulation strength (positive/negative).

Flexibility: Allows custom modulation routing beyond default assignments.
9. Performance Controls

Parameters:

    Portamento/Glide: Time for sliding between notes.

    Arpeggiator: Rate, mode (up/down/random), octave range.

    Unison Mode: Voice stacking with detune/spread for thick textures.

10. Voice Settings

Parameters:

    Polyphony: Number of simultaneous voices (mono/poly).

    Detune: Global fine-tuning for oscillator drift.

    Tuning: Master pitch adjustment (A440 reference).

Signal Chain Summary

    Oscillators → Mixer → Filter → Amplifier → Effects

    Modulation Sources (LFOs, envelopes) → Modulation Matrix → Target Parameters

This design enables rich sound sculpting through waveform generation, filtering, dynamic shaping, and flexible modulation.



Relevant SuperCollider UGens for 'Synth1' Components

Below is a breakdown of SuperCollider UGens suitable for implementing each component of the subtractive synthesizer "Synth1," organized by signal chain order. Citations reference the search results provided.
1. Oscillators (Osc1 & Osc2)

    Waveform Generation

        SinOsc: Sine wave with aliasing-free output 16.

        Saw / LFSaw: Band-limited sawtooth wave 16.

        Pulse / LFPulse: Adjustable pulse width (duty cycle) 16.

        WhiteNoise / PinkNoise: Aperiodic noise sources 14.

        Blip: Band-limited pulse wave with harmonic control 1.

        VOsc / VOsc3: Wavetable oscillators for complex waveforms 14.

    Sub-Oscillator: Use SinOsc or Pulse with octave-down frequency division (e.g., freq / 2).

    Unison Detuning: Combine multiple SinOsc instances with LFNoise-modulated frequencies 46.

2. Mixer

    Signal Blending

        Mix: Sums multiple signals into a single output (e.g., Mix([osc1, osc2, noise])) 7.

        XFade2: Crossfades between two inputs with equal power 17.

    Noise Integration: Use WhiteNoise.ar scaled with mul for adjustable noise level 1.

3. Filter Section

    Low/High/Band-Pass Filters

        RLPF / RHPF: Resonant 12dB/octave filters with cutoff and resonance 14.

        Resonz: Resonant band-pass filter with uniform amplitude 1.

        MoogFF: Emulates analog ladder filters for warmer tones (not explicitly listed but commonly used).

    Key Tracking: Modulate cutoff using MouseX.kr or LinLin to map MIDI note values 10.

    Envelope Modulation: Use EnvGen to drive filter cutoff via LinLin scaling 510.

4. Amplifier (VCA)

    Volume Control

        MulAdd: Scales and offsets signals (e.g., sig * env) 5.

        EnvGen: Generates ADSR envelopes for dynamic volume shaping 510.

    Panning: Pan2 for stereo positioning (equal-power pan law) 17.

5. Envelopes

    ADSR Shaping

        Env: Defines envelope shapes (e.g., Env.adsr) 510.

        EnvGen: Triggers and processes the envelope 5.

    Filter/Amplifier Modulation: Route EnvGen outputs to cutoff or mul parameters 10.

6. LFOs

    Modulation Sources

        LFSaw / LFTri / LFPulse: Low-frequency geometric waveforms 16.

        LFNoise0 / LFNoise1: Random stepped/smoothed modulation 1.

        SinOsc.kr: Smooth sine-wave LFO for vibrato/tremolo 6.

    Destinations: Apply LFOs to freq, pulseWidth, or pan via mul/add or range 6.

7. Effects Section

    Spatial/Time-Based Effects

        Delay: CombN (feedback delay) or DelayN (simple delay) 110.

        Reverb: FreeVerb or GVerb for algorithmic reverb 110.

        Chorus: Combine DelayC with SinOsc.kr-modulated delay times 1.

8. Modulation Matrix

    Routing Flexibility

        Poll: Monitors UGen outputs for debugging 5.

        LinXFade2: Blends modulation sources dynamically 5.

        Lag / LagUD: Smooths abrupt parameter changes (e.g., LFO-to-filter) 5.

9. Performance Controls

    Portamento: Lag UGen to glide between pitches 5.

    Arpeggiator: Use Pulse or Dust for rhythmic triggers, paired with Select for note sequencing 811.

10. Voice Settings

    Polyphony: Managed by SuperCollider’s server (e.g., SynthDef voice allocation) 48.

    Detune: Apply LFNoise to oscillator frequencies for subtle pitch variations 6.

Signal Chain Implementation Example:

```
SynthDef(\synth1, {
  // Oscillators
  var osc1 = Saw.ar(\freq.kr(440));
  var osc2 = Pulse.ar(\freq.kr(440), \width.kr(0.5));
  var noise = WhiteNoise.ar(\noiseLevel.kr(0.1));
  var sub = SinOsc.ar(\freq.kr(440) / 2);
  var mix = Mix([osc1, osc2, noise, sub]);

  // Filter
  var env = EnvGen.kr(Env.adsr(), \gate.kr(1));
  var filter = RLPF.ar(mix, \cutoff.kr(1000).lag(0.1) * env, \res.kr(0.5));

  // Amplifier & Panning
  var amp = filter * EnvGen.kr(Env.perc(), doneAction: Done.freeSelf);
  var sig = Pan2.ar(amp, \pan.kr(0));

  // Effects
  sig = FreeVerb.ar(sig, \room.kr(0.5), \damp.kr(0.5));
  Out.ar(0, sig);
}).add;
```

Key References

    Oscillators & Filters: 146.

    Envelopes & Modulation: 510.

    Effects & Mixing: 1710.

    Polyphony & Voice Management: 48.

This framework leverages SuperCollider’s modular UGen architecture to replicate "Synth1" while allowing customization via parameter modulation and signal routing.