SynthDef(\Synth1SC, {

    // Basic parameters
    var out = \out.kr(0);
    var gate = \gate.kr(1);
    var freq = \freq.kr(440);
    var amp = \amp.kr(0.5);
    var bendRate = \bendRate.kr(1);
    var modWheel = \modWheel.kr(0);
    var touch = \touch.kr(0);
    var breath = \breath.kr(0);
    var pan = \pan.kr(0);

    // Oscillator parameters
    var osc1Shape = \osc1Shape.kr(2);
    var osc2Shape = \osc2Shape.kr(1);
    var osc2Pitch = \osc2Pitch.kr(12);
    var osc2Fine = \osc2Fine.kr(0);
    var osc1Detune = \osc1Detune.kr(0);
    var osc2KbdTrack = \osc2KbdTrack.kr(1);
    var oscMix = \oscMix.kr(0.5);
    var pulseWidth = \pulseWidth.kr(0.5);
    var osc2Sync = \osc2Sync.kr(0);
    var ringMod = \ringMod.kr(0);
    var oscFMAmt = \oscFMAmt.kr(0);
    var phaseShift = \phaseShift.kr(0);
    var subGain = \subGain.kr(0.5);
    var subShape = \subShape.kr(1);
    var subOctave = \subOctave.kr(1);

    // Modulation envelope
    var modEnvAmt = \modEnvAmt.kr(0);
    var modEnvAttack = \modEnvAttack.kr(0.01);
    var modEnvDecay = \modEnvDecay.kr(0.3);
    var modEnvDest = \modEnvDest.kr(0);

    // Filter parameters
    var filterType = \filterType.kr(1);
    var filterFreq = \filterFreq.kr(2000);
    var filterRes = \filterRes.kr(0.1);
    var filterEnvAmt = \filterEnvAmt.kr(0.5);
    var filterAttack = \filterAttack.kr(0.01);
    var filterDecay = \filterDecay.kr(0.2);
    var filterSustain = \filterSustain.kr(0.5);
    var filterRelease = \filterRelease.kr(0.5);
    var filterKbdTrack = \filterKbdTrack.kr(0.5);
    var filterVelSens = \filterVelSens.kr(1);
    var filterSat = \filterSat.kr(0);

    // Amplifier parameters
    var ampAttack = \ampAttack.kr(0.01);
    var ampDecay = \ampDecay.kr(0.3);
    var ampSustain = \ampSustain.kr(0.7);
    var ampRelease = \ampRelease.kr(0.5);
    var ampGain = \ampGain.kr(0.dbamp);
    var ampVelSens = \ampVelSens.kr(0.8);

    // LFO1 parameters
    var lfo1On = \lfo1On.kr(1);
    var lfo1Rate = \lfo1Rate.kr(5);
    var lfo1Shape = \lfo1Shape.kr(1);
    var lfo1Depth = \lfo1Depth.kr(0.1);
    var lfo1Dest = \lfo1Dest.kr(2);
    var lfo1TempoSync = \lfo1TempoSync.kr(0);
    var lfo1KeySync = \lfo1KeySync.kr(0);

    // LFO2 parameters
    var lfo2On = \lfo2On.kr(1);
    var lfo2Rate = \lfo2Rate.kr(5);
    var lfo2Shape = \lfo2Shape.kr(1);
    var lfo2Depth = \lfo2Depth.kr(0.1);
    var lfo2Dest = \lfo2Dest.kr(2);
    var lfo2TempoSync = \lfo2TempoSync.kr(0);
    var lfo2KeySync = \lfo2KeySync.kr(0);

    // Unison parameters
    var unisonOn = \unisonOn.kr(0);
	var unisonNum = \unisonNum.kr(2);
    var unisonDetune = \unisonDetune.kr(0.1);
    var unisonSpread = \unisonSpread.kr(0.5);
    var unisonPhase = \unisonPhase.kr(0);

    // Signal variables
    var osc1Freq, osc2Freq, subFreq, lfo1, lfo2, modEnv;
    var osc1, osc2, subOsc, mixedOsc, filtered, output;
    var filterEnv, ampEnvVel, ampEnv;
    var lfo1Out, lfo2Out, pwMod, fmMod, pitchMod1, pitchMod2;
    var unisonSignals, filterCutoff;

    // LFO generation
    lfo1Out = Select.kr(lfo1Shape, [
        LFSaw.kr(lfo1Rate, 0, 0.5, 0.5),                // Saw
        LFTri.kr(lfo1Rate),                              // Triangle
        LFPulse.kr(lfo1Rate, 0, 0.5, 1, -0.5),          // Square
        LFNoise0.kr(lfo1Rate),                           // S&H
        Lag.kr(LFNoise0.kr(lfo1Rate), 1/lfo1Rate),      // Smooth S&H
        SinOsc.kr(lfo1Rate, 0, 0.5, 0.5)                // Sine
    ]) * lfo1Depth * lfo1On;

    lfo2Out = Select.kr(lfo2Shape, [
        LFSaw.kr(lfo2Rate, 0, 0.5, 0.5),                // Saw
        LFTri.kr(lfo2Rate),                              // Triangle
        LFPulse.kr(lfo2Rate, 0, 0.5, 1, -0.5),          // Square
        LFNoise0.kr(lfo2Rate),                           // S&H
        Lag.kr(LFNoise0.kr(lfo2Rate), 1/lfo2Rate),      // Smooth S&H
        SinOsc.kr(lfo2Rate, 0, 0.5, 0.5)                // Sine
    ]) * lfo2Depth * lfo2On;

    // Mod envelope (AD)
    modEnv = Env.perc(modEnvAttack, modEnvDecay).ar(gate: gate) * modEnvAmt;



    // Route LFOs and Mod Env to targets
    pwMod = 0;
    fmMod = 0;
    pitchMod1 = 0;
    pitchMod2 = 0;

    // LFO1 routing - using if statements instead of boolean multiplication
    pitchMod2 = pitchMod2 + (lfo1Dest == 0).if(lfo1Out, 0);
    pitchMod1 = pitchMod1 + (lfo1Dest == 1).if(lfo1Out, 0);
    pitchMod2 = pitchMod2 + (lfo1Dest == 1).if(lfo1Out, 0);
    // Filter freq modulation is handled later
    // Amp modulation is handled later
    pwMod = pwMod + (lfo1Dest == 4).if(lfo1Out, 0);
    fmMod = fmMod + (lfo1Dest == 5).if(lfo1Out, 0);
    // Pan modulation is handled later


    // LFO2 routing (similar to LFO1)
    pitchMod2 = pitchMod2 + (lfo2Dest == 0).if(lfo2Out, 0);
    pitchMod1 = pitchMod1 + (lfo2Dest == 1).if(lfo2Out, 0);
    pitchMod2 = pitchMod2 + (lfo2Dest == 1).if(lfo2Out, 0);
    // Filter freq modulation is handled later
    // Amp modulation is handled later
    pwMod = pwMod + (lfo2Dest == 4).if(lfo2Out, 0);
    fmMod = fmMod + (lfo2Dest == 5).if(lfo2Out, 0);
    // Pan modulation is handled later

    // Mod Env routing
    pitchMod2 = pitchMod2 + (modEnvDest == 0).if(modEnv, 0);
    fmMod = fmMod + (modEnvDest == 1).if(modEnv, 0);
    pwMod = pwMod + (modEnvDest == 2).if(modEnv, 0);

    // Calculate oscillator frequencies
    osc1Freq = freq * bendRate * (2.midiratio(osc1Detune/100));
    osc2Freq = freq * bendRate * (osc2KbdTrack * (2.midiratio(osc2Pitch + (osc2Fine/100)))) * (2.midiratio(pitchMod2 * 24)); // Scale for semitones
    subFreq = osc1Freq * (0.5 ** subOctave);


    // Pulse width with modulation
    pulseWidth = (pulseWidth + pwMod).clip(0.01, 0.99);


    // FM amount with modulation
    oscFMAmt = oscFMAmt + fmMod;

	// // Oscillator 1
	// osc1 = Select.ar(osc1Shape, [
	// 	SinOsc.ar(osc1Freq, (oscFMAmt * 2pi * osc2)),
	// 	Saw.ar(osc1Freq + (oscFMAmt * 500 * osc2)),
	// 	Pulse.ar(osc1Freq + (oscFMAmt * 500 * osc2), pulseWidth),
	// 	LFTri.ar(osc1Freq + (oscFMAmt * 500 * osc2))
	// ]);


    // Sub oscillator
    subOsc = Select.ar(subShape, [
        SinOsc.ar(subFreq),
        LFTri.ar(subFreq),
        Saw.ar(subFreq),
        Pulse.ar(subFreq, 0.5)
    ]) * subGain;


    // Oscillator 2 with sync option
    osc2 = Select.ar(osc2Shape, [
        Select.ar(osc2Sync, [
            SinOsc.ar(osc2Freq),
            SinOsc.ar(osc2Freq, SinOsc.ar(osc1Freq).range(0, 2pi))
        ]),
        Select.ar(osc2Sync, [
            Saw.ar(osc2Freq),
            SyncSaw.ar(osc1Freq, osc2Freq)
        ]),
        Select.ar(osc2Sync, [
            Pulse.ar(osc2Freq, pulseWidth),
            LFPulse.ar(osc1Freq) * Pulse.ar(osc2Freq, pulseWidth)
        ]),
        Select.ar(osc2Sync, [
            LFTri.ar(osc2Freq),
            LFTri.ar(osc2Freq).max(0) * LFPulse.ar(osc1Freq)
        ]),
        Select.ar(osc2Sync, [
            LFNoise0.ar(osc2Freq),
            LFNoise0.ar(osc2Freq) * LFPulse.ar(osc1Freq)
        ])
    ]);


		    // Oscillator 1
    osc1 = Select.ar(osc1Shape, [
        SinOsc.ar(osc1Freq, (oscFMAmt * 2pi * osc2)),
        Saw.ar(osc1Freq + (oscFMAmt * 500 * osc2)),
        Pulse.ar(osc1Freq + (oscFMAmt * 500 * osc2), pulseWidth),
        LFTri.ar(osc1Freq + (oscFMAmt * 500 * osc2))
    ]);

    // Ring modulation
    osc1 = XFade2.ar(osc1, osc1 * osc2, ringMod * 2 - 1);

    // Oscillator mix
    mixedOsc = XFade2.ar(osc1 + subOsc, osc2, oscMix * 2 - 1);

    // Filter envelope
    filterEnv = Env.adsr(filterAttack, filterDecay, filterSustain, filterRelease).ar(gate: gate, doneAction: 0);

    // Keyboard tracking for filter
    filterCutoff = filterFreq * (freq/440).pow(filterKbdTrack * 2);


    // Apply filter envelope with velocity sensitivity
    filterCutoff = filterCutoff * ((filterEnv - 0.5) * filterEnvAmt * (1 + (amp - 0.5) * filterVelSens) + 1).clip(0.01, 1);

    // LFO modulation for filter
    filterCutoff = filterCutoff * (
        (1 + ((lfo1Dest == 2).if(lfo1Out * 4, 0))) *
        (1 + ((lfo2Dest == 2).if(lfo2Out * 4, 0)))
    ).clip(20, 20000);




    // Apply filter saturation (pre-filter)
    mixedOsc = (mixedOsc * (1 + filterSat * 5)).tanh;


    // Apply filter
    filtered = Select.ar(filterType, [
        RLPF.ar(mixedOsc, filterCutoff.clip(20, 20000), filterRes.linlin(0, 1, 1, 0.01)),  // LP12
        RLPF.ar(RLPF.ar(mixedOsc, filterCutoff.clip(20, 20000), filterRes.linlin(0, 1, 1, 0.01)),
                filterCutoff.clip(20, 20000), filterRes.linlin(0, 1, 1, 0.01)),            // LP24
        RHPF.ar(mixedOsc, filterCutoff.clip(20, 20000), filterRes.linlin(0, 1, 1, 0.01)),  // HP12
        BPF.ar(mixedOsc, filterCutoff.clip(20, 20000), filterRes.linlin(0, 1, 1, 0.1))     // BP12
    ]);

    // Amp envelope with velocity sensitivity
    ampEnv = Env.adsr(ampAttack, ampDecay, ampSustain, ampRelease).ar(gate: gate, doneAction: Done.freeSelf);
    ampEnvVel = ampEnv * (amp * ampVelSens + (1 - ampVelSens));


    // LFO modulation for amplitude
    ampEnvVel = ampEnvVel *
        (1 - (lfo1Dest == 3).if(lfo1Out * 0.99, 0)) *
        (1 - (lfo2Dest == 3).if(lfo2Out * 0.99, 0));

    // Apply amp envelope
    output = filtered * ampEnvVel * ampGain;


    // Pan modulation from LFOs
    pan = pan + (lfo1Dest == 6).if(lfo1Out, 0) + (lfo2Dest == 6).if(lfo2Out, 0);


    // Output with panning
    output = Pan2.ar(output, pan.clip(-1, 1));


    // // Apply unison if enabled
    // if(unisonOn > 0.0, {
    //     unisonSignals = Array.fill(unisonNum.asInteger, { |i|
    //         var detune = (i / (unisonNum - 1) * 2 - 1) * unisonDetune * 0.1;
    //         var spreadPos = (i / (unisonNum - 1) * 2 - 1) * unisonSpread;
    //         var detuneRatio = 2.midiratio(detune);

    //         // Create a detuned instance of the synth
    //         var detuned = SinOsc.ar(osc1Freq * detuneRatio) * ampEnv;  // Simplified for demonstration

    //         // Pan the detuned signal
    //         Pan2.ar(detuned, pan + spreadPos);
    //     });

    //     // Mix the unison signals and normalize
    //     output = Mix.ar(unisonSignals) / sqrt(unisonNum);
    // });


    // Final output
    Out.ar(out, output * 0.5); // Scaling to prevent clipping
}).add;

/*
SYNTH1SC PARAMETER DOCUMENTATION

Basic Parameters:
- out: Output bus number (default: 0)
- gate: Trigger for note on/off (1 = on, 0 = off) (default: 1)
- freq: Base frequency in Hz (default: 440)
- amp: Overall amplitude (0-1) (default: 0.5)
- bendRate: Pitch bend multiplier (default: 1)
- modWheel: Mod wheel value (0-1) (default: 0)
- touch: Aftertouch value (0-1) (default: 0)
- breath: Breath controller value (0-1) (default: 0)
- pan: Stereo position (-1 = left, 1 = right) (default: 0)

Oscillator Parameters:
- osc1Shape: Oscillator 1 waveform (0=sine, 1=saw, 2=pulse, 3=triangle) (default: 2)
- osc2Shape: Oscillator 2 waveform (0=sine, 1=saw, 2=pulse, 3=triangle, 4=noise) (default: 1)
- osc2Pitch: Oscillator 2 semitone offset (default: 12)
- osc2Fine: Oscillator 2 fine tune in cents (default: 0)
- osc1Detune: Oscillator 1 detune in cents (default: 0)
- osc2KbdTrack: Oscillator 2 keyboard tracking (0-1) (default: 1)
- oscMix: Balance between oscillators (-1 = osc1, 1 = osc2) (default: 0.5)
- pulseWidth: Width of pulse waveform (0.01-0.99) (default: 0.5)
- osc2Sync: Hard sync oscillator 2 to oscillator 1 (0=off, 1=on) (default: 0)
- ringMod: Ring modulation amount (0-1) (default: 0)
- oscFMAmt: Frequency modulation amount (0-1) (default: 0)
- phaseShift: Phase offset between oscillators (0-1) (default: 0)
- subGain: Sub oscillator level (0-1) (default: 0.5)
- subShape: Sub oscillator waveform (0=sine, 1=triangle, 2=saw, 3=pulse) (default: 1)
- subOctave: Sub oscillator octave shift (1=one octave down, 2=two octaves down) (default: 1)

Modulation Envelope:
- modEnvAmt: Modulation envelope amount (0-1) (default: 0)
- modEnvAttack: Attack time in seconds (default: 0.01)
- modEnvDecay: Decay time in seconds (default: 0.3)
- modEnvDest: Modulation destination (0=pitch, 1=FM, 2=PWM) (default: 0)

Filter Parameters:
- filterType: Filter type (0=LP12, 1=LP24, 2=HP12, 3=BP12) (default: 1)
- filterFreq: Filter cutoff frequency in Hz (default: 2000)
- filterRes: Filter resonance (0-1) (default: 0.1)
- filterEnvAmt: Filter envelope amount (0-1) (default: 0.5)
- filterAttack: Filter envelope attack time (default: 0.01)
- filterDecay: Filter envelope decay time (default: 0.2)
- filterSustain: Filter envelope sustain level (default: 0.5)
- filterRelease: Filter envelope release time (default: 0.5)
- filterKbdTrack: Filter keyboard tracking (0-1) (default: 0.5)
- filterVelSens: Filter velocity sensitivity (0-1) (default: 1)
- filterSat: Filter saturation amount (0-1) (default: 0)

Amplifier Parameters:
- ampAttack: Amplitude envelope attack time (default: 0.01)
- ampDecay: Amplitude envelope decay time (default: 0.3)
- ampSustain: Amplitude envelope sustain level (default: 0.7)
- ampRelease: Amplitude envelope release time (default: 0.5)
- ampGain: Output gain in dB (default: 0)
- ampVelSens: Amplitude velocity sensitivity (0-1) (default: 0.8)

LFO1 Parameters:
- lfo1On: Enable LFO1 (0=off, 1=on) (default: 1)
- lfo1Rate: LFO1 frequency in Hz (default: 5)
- lfo1Shape: LFO1 waveform (0=saw, 1=triangle, 2=square, 3=S&H, 4=smooth S&H, 5=sine) (default: 1)
- lfo1Depth: LFO1 modulation amount (0-1) (default: 0.1)
- lfo1Dest: LFO1 destination (0=osc2 pitch, 1=both osc pitch, 2=filter, 3=amp, 4=PWM, 5=FM, 6=pan) (default: 2)
- lfo1TempoSync: Sync to tempo (0=off, 1=on) (default: 0)
- lfo1KeySync: Restart LFO on key press (0=off, 1=on) (default: 0)

LFO2 Parameters:
- lfo2On: Enable LFO2 (0=off, 1=on) (default: 1)
- lfo2Rate: LFO2 frequency in Hz (default: 5)
- lfo2Shape: LFO2 waveform (0=saw, 1=triangle, 2=square, 3=S&H, 4=smooth S&H, 5=sine) (default: 1)
- lfo2Depth: LFO2 modulation amount (0-1) (default: 0.1)
- lfo2Dest: LFO2 destination (0=osc2 pitch, 1=both osc pitch, 2=filter, 3=amp, 4=PWM, 5=FM, 6=pan) (default: 2)
- lfo2TempoSync: Sync to tempo (0=off, 1=on) (default: 0)
- lfo2KeySync: Restart LFO on key press (0=off, 1=on) (default: 0)

Unison Parameters:
- unisonOn: Enable unison mode (0=off, 1=on) (default: 0)
- unisonNum: Number of unison voices (default: 2)
- unisonDetune: Detuning amount between voices in cents (default: 0.1)
- unisonSpread: Stereo spread of voices (0-1) (default: 0.5)
- unisonPhase: Phase offset between voices (0-1) (default: 0)
*/






