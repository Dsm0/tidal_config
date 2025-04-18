(
SynthDef(\Synth1SC_Full, {
    // CONTROL INPUTS
    var freq = \freq.kr(440);
    var gate = \gate.kr(1);
    var velocity = \vel.kr(100) / 127;
    var ampGain = \ampGain.kr(0.5);
    var outBus = \out.kr(0);
    var pan = \pan.kr(0);
    var bps = \bps.kr(2); // Beats per second (120 BPM = 2 BPS)

    // VOICE PARAMETERS
    var playMode = \playMode.kr(0); // 0=Poly, 1=Mono, 2=Legato
    var polyphony = \polyphony.kr(16); // For external voice management
    var portaTime = \portamentoTime.kr(0).linexp(1, 127, 0.001, 4);
    var portaAuto = \portamentoAuto.kr(0);

    // OSC 1 PARAMETERS
    var osc1Wave = \osc1Wave.kr(0); // 0=Sine, 1=Tri, 2=Saw, 3=Square
    var osc1Coarse = \osc1Coarse.kr(0).midiratio; // -24 to +24 semitones
    var osc1Fine = \osc1Fine.kr(0).linlin(0, 127, -0.5, 0.5).midiratio; // -50 to +50 cents
    var osc1KbdTrack = \osc1KbdTrack.kr(1); // 0=Off, 1=On

    // SUB OSC PARAMETERS
    var subOscWave = \subOscWave.kr(0); // 0=Sine, 1=Triangle, 2=Saw, 3=Pulse, 4=Noise
    var subOscVol = \subOscVol.kr(0).linlin(0, 127, 0, 1);
    var subOscLfoDepth = \subOscLfoDepth.kr(0).linlin(0, 127, 0, 1);

    // OSC 2 PARAMETERS
    var osc2Wave = \osc2Wave.kr(2); // 0=Sine, 1=Tri, 2=Saw, 3=Square
    var osc2Coarse = \osc2Coarse.kr(0).midiratio; // -24 to +24 semitones
    var osc2Fine = \osc2Fine.kr(0).linlin(0, 127, -0.5, 0.5).midiratio; // -50 to +50 cents
    var osc2KbdTrack = \osc2KbdTrack.kr(1); // 0=Off, 1=On

    // SYNC & MOD PARAMETERS
    var syncMode = \syncMode.kr(0); // 0=Off, 1=Osc2->Osc1, 2=Osc1->Osc2
    var fmAmount = \fmAmount.kr(0).linlin(0, 127, 0, 1);
    var ringModulation = \ringModulation.kr(0).linlin(0, 127, 0, 1);

    // MIXER PARAMETERS
    var osc1Vol = \osc1Vol.kr(100).linlin(0, 127, 0, 1);
    var osc2Vol = \osc2Vol.kr(0).linlin(0, 127, 0, 1);
    var noiseVol = \noiseVol.kr(0).linlin(0, 127, 0, 1);

    // MODULATION ENVELOPE
    var modEnvAttack = \modEnvAttack.kr(0).linexp(0, 127, 0.001, 10);
    var modEnvDecay = \modEnvDecay.kr(30).linexp(0, 127, 0.001, 10);
    var modEnvAmount = \modEnvAmount.kr(0).linlin(0, 127, -1, 1);
    var modEnvTarget = \modEnvTarget.kr(0); // 0=Osc2Pitch, 1=FM, 2=PW

    // FILTER PARAMETERS
    var filterType = \filterType.kr(0); // 0=LPF1, 1=LPF2, 2=HPF1, 3=BPF
    var filterCutoff = \filterCutoff.kr(100).linexp(0, 127, 20, 20000);
    var filterResonance = \filterResonance.kr(0).linexp(0, 127, 0.01, 4);
    var filterEnvAmount = \filterEnvAmount.kr(0).linlin(0, 127, -1, 1);
    var filterKbdTrack = \filterKbdTrack.kr(0); // 0=Off, 1=Quarter, 2=Half, 3=Full

    // FILTER ENVELOPE
    var filterEnvAttack = \filterEnvAttack.kr(0).linexp(0, 127, 0.001, 10);
    var filterEnvDecay = \filterEnvDecay.kr(64).linexp(0, 127, 0.001, 10);
    var filterEnvSustain = \filterEnvSustain.kr(64).linlin(0, 127, 0, 1);
    var filterEnvRelease = \filterEnvRelease.kr(64).linexp(0, 127, 0.001, 10);

    // AMP ENVELOPE
    var ampEnvAttack = \ampEnvAttack.kr(0).linexp(0, 127, 0.001, 10);
    var ampEnvDecay = \ampEnvDecay.kr(20).linexp(0, 127, 0.001, 10);
    var ampEnvSustain = \ampEnvSustain.kr(100).linlin(0, 127, 0, 1);
    var ampEnvRelease = \ampEnvRelease.kr(20).linexp(0, 127, 0.001, 10);

    // LFO 1 PARAMETERS
    var lfo1Wave = \lfo1Wave.kr(0); // 0=Sine, 1=Tri, 2=Saw, 3=Square, 4=S&H
    var lfo1Dest = \lfo1Dest.kr(0); // 0=Pitch, 1=Amp, 2=Filter, 3=PWM, 4=FMAmount, 5=Pan
    var lfo1Rate = \lfo1Rate.kr(64);
    var lfo1Sync = \lfo1Sync.kr(0); // 0=Free, 1=Tempo Sync
    var lfo1Amount = \lfo1Amount.kr(32).linlin(0, 127, 0, 1);
    var lfo1Delay = \lfo1Delay.kr(0).linexp(0, 127, 0.001, 5);

    // LFO 2 PARAMETERS
    var lfo2Wave = \lfo2Wave.kr(0); // 0=Sine, 1=Tri, 2=Saw, 3=Square, 4=S&H
    var lfo2Dest = \lfo2Dest.kr(0); // 0=Pitch, 1=Amp, 2=Filter, 3=PWM, 4=FMAmount, 5=Pan
    var lfo2Rate = \lfo2Rate.kr(64);
    var lfo2Sync = \lfo2Sync.kr(0); // 0=Free, 1=Tempo Sync
    var lfo2Amount = \lfo2Amount.kr(32).linlin(0, 127, 0, 1);

    // ARPEGGIATOR PARAMETERS (for external logic)
    var arpOn = \arpOn.kr(0); // 0=Off, 1=On
    var arpType = \arpType.kr(1); // 0=Up, 1=Down, 2=UpDown, 3=Random
    var arpOctRange = \arpOctRange.kr(1); // 1-4 octaves
    var arpBeat = \arpBeat.kr(8); // Maps to note divisions
    var arpGate = \arpGate.kr(0.5); // 0-1+ range

    // DELAY PARAMETERS
    var delayOn = \delayOn.kr(1); // 0=Off, 1=On
    var delayType = \delayType.kr(0); // 0=Stereo, 1=Cross, 2=PingPong
    var delayTime = \delayTime.kr(8); // Note divisions for tempo sync
    var delaySpread = \delaySpread.kr(0.5).linlin(0, 127, -0.1, 0.1); // -100ms to +100ms
    var delayFdbk = \delayFdbk.kr(0.3).linlin(0, 127, 0, 0.99); // 0-0.99
    var delayTone = \delayTone.kr(0.5).linexp(0, 127, 200, 12000); // Filter freq
    var delayWet = \delayWet.kr(0.2).linlin(0, 127, 0, 1); // 0-1

    // CHORUS PARAMETERS
    var chorusOn = \chorusOn.kr(1); // 0=Off, 1=On
    var chorusType = \chorusType.kr(2); // 1, 2, or 4 voices
    var chorusTime = \chorusTime.kr(0.5).linexp(0, 127, 0.05/1000, 30/1000); // 0.05ms to 30ms
    var chorusDepth = \chorusDepth.kr(0.5).linlin(0, 127, 0, 1); // 0-1
    var chorusRate = \chorusRate.kr(0.5).linexp(0, 127, 0.01, 10); // 0.01Hz to 10Hz
    var chorusFdbk = \chorusFdbk.kr(0).linlin(0, 127, -0.98, 0.98); // -0.98 to +0.98
    var chorusWet = \chorusWet.kr(0.3).linlin(0, 127, 0, 1); // 0-1

    // EQ PARAMETERS
    var eqTone = \eqTone.kr(0.5).linlin(0, 127, -12, 12); // -12dB to +12dB shelf
    var eqFreq = \eqFreq.kr(500).linexp(0, 127, 50, 16000); // 50Hz to 16kHz
    var eqLevel = \eqLevel.kr(0).linlin(0, 127, -24, 24); // -24dB to +24dB
    var eqQ = \eqQ.kr(1).linexp(0, 127, 0.1, 18); // 0.1 to 18

    // EFFECT UNIT PARAMETERS
    var effectOn = \effectOn.kr(0); // 0=Off, 1=On
    var effectType = \effectType.kr(0); // 0=Dist1, 1=Dist2, 2=DigiDist...
    var effectCtrl1 = \effectCtrl1.kr(0.5).linlin(0, 127, 0, 1);
    var effectCtrl2 = \effectCtrl2.kr(0.5).linlin(0, 127, 0, 1);
    var effectWet = \effectWet.kr(0.5).linlin(0, 127, 0, 1);

    // SIGNAL CHAIN VARIABLES
    var osc1, osc2, subOsc, noise, ringMod, oscMixer;
    var modEnv, filterEnv, ampEnv;
    var lfo1, lfo2, lfo1Scaled, lfo2Scaled;
    var lfo1RateVal, lfo2RateVal;
    var filteredSignal, amplifiedSignal;
    var delayedSignal, chorusSignal, eqSignal, effectSignal;
    var finalSignal;

	var osc2Pitch, fmModAmount, filterCutoffMod, delayTimeSeconds;

    // Portamento handling
    freq = if(portaTime <= 0,
        freq,
		if(portaAuto > 0 & playMode == 2, // Auto porta only in legato mode // (lmao I suppose bitwise & instead of && actually would work)
            freq.lag(portaTime),
            freq.lag(portaTime)
        )
    );


    // LFO CALCULATIONS
    lfo1RateVal = Select.kr(lfo1Sync, [
        lfo1Rate.linexp(0, 127, 0.01, 20), // Free running: 0.01Hz to 20Hz
        Select.kr(lfo1Rate.clip(0, 18) / 2, [ // Tempo-synced values (simplified mapping)
            bps / 8, bps / 6, bps / 4, bps / 3, bps / 2, bps / 1.5, bps,
            bps * 1.5, bps * 2, bps * 3, bps * 4, bps * 6, bps * 8
        ])
    ]);


    lfo2RateVal = Select.kr(lfo2Sync, [
        lfo2Rate.linexp(0, 127, 0.01, 20), // Free running: 0.01Hz to 20Hz
        Select.kr(lfo2Rate.clip(0, 18) / 2, [ // Tempo-synced values (simplified mapping)
            bps / 8, bps / 6, bps / 4, bps / 3, bps / 2, bps / 1.5, bps,
            bps * 1.5, bps * 2, bps * 3, bps * 4, bps * 6, bps * 8
        ])
    ]);

    // Generate LFOs
    lfo1 = Select.ar(lfo1Wave, [
        SinOsc.ar(lfo1RateVal),
        LFTri.ar(lfo1RateVal),
        LFSaw.ar(lfo1RateVal),
        LFPulse.ar(lfo1RateVal, 0, 0.5),
        LFNoise0.ar(lfo1RateVal)
    ]);
    lfo1 = lfo1 * Line.kr(0, 1, lfo1Delay); // Apply LFO delay

    lfo2 = Select.ar(lfo2Wave, [
        SinOsc.ar(lfo2RateVal),
        LFTri.ar(lfo2RateVal),
        LFSaw.ar(lfo2RateVal),
        LFPulse.ar(lfo2RateVal, 0, 0.5),
        LFNoise0.ar(lfo2RateVal)
    ]);

    // Scale LFOs based on destination
    lfo1Scaled = Select.kr(lfo1Dest, [
        lfo1 * lfo1Amount * 0.5, // Pitch: +/- 0.5 octave
        lfo1.range(1-lfo1Amount, 1), // Amp: 0 to 1
        lfo1 * lfo1Amount * 5000, // Filter: +/- 5000Hz
        lfo1 * lfo1Amount * 0.45 + 0.5, // PWM: 0.05 to 0.95
        lfo1.range(0, lfo1Amount), // FM Amount: 0 to 1
        lfo1 * lfo1Amount // Pan: -1 to 1
    ]);

    lfo2Scaled = Select.kr(lfo2Dest, [
        lfo2 * lfo2Amount * 0.5, // Pitch: +/- 0.5 octave
        lfo2.range(1-lfo2Amount, 1), // Amp: 0 to 1
        lfo2 * lfo2Amount * 5000, // Filter: +/- 5000Hz
        lfo2 * lfo2Amount * 0.45 + 0.5, // PWM: 0.05 to 0.95
        lfo2.range(0, lfo2Amount), // FM Amount: 0 to 1
        lfo2 * lfo2Amount // Pan: -1 to 1
    ]);

    // MODULATION ENVELOPE
    modEnv = EnvGen.ar(
        Env.new([0, 1, 0], [modEnvAttack, modEnvDecay], [0, -4]),
        gate,
        doneAction: 0
    ) * modEnvAmount;

    // FILTER ENVELOPE
    filterEnv = EnvGen.ar(
        Env.adsr(filterEnvAttack, filterEnvDecay, filterEnvSustain, filterEnvRelease, 1, -4),
        gate,
        doneAction: 0
    ) * filterEnvAmount;

    // AMP ENVELOPE
    ampEnv = EnvGen.ar(
        Env.adsr(ampEnvAttack, ampEnvDecay, ampEnvSustain, ampEnvRelease, 1, -4),
        gate,
        doneAction: 2
    );

    // OSC 1 & SUB OSC
    osc1 = Select.ar(osc1Wave, [
        SinOsc.ar(freq * osc1Coarse * osc1Fine * (osc1KbdTrack * 1 + (1 - osc1KbdTrack) * (440 / freq))),
        LFTri.ar(freq * osc1Coarse * osc1Fine * (osc1KbdTrack * 1 + (1 - osc1KbdTrack) * (440 / freq))),
        Saw.ar(freq * osc1Coarse * osc1Fine * (osc1KbdTrack * 1 + (1 - osc1KbdTrack) * (440 / freq))),
        Pulse.ar(
            freq * osc1Coarse * osc1Fine * (osc1KbdTrack * 1 + (1 - osc1KbdTrack) * (440 / freq)),
			(lfo1Dest.eq(3)) * lfo1Scaled + (lfo2Dest.eq(3)) * lfo2Scaled + 0.5
        )
    ]);


    // Apply pitch LFO to Osc1
	osc1 = osc1 * ((lfo1Dest.eq(1)) * lfo1Scaled + (lfo2Dest.eq(1)) * lfo2Scaled + (1 - ((lfo1Dest.eq(1)) + (lfo2Dest.eq(1)))));

    // SUB OSC
    subOsc = Select.ar(subOscWave, [
        SinOsc.ar(freq * 0.5),
        LFTri.ar(freq * 0.5),
        Saw.ar(freq * 0.5),
        Pulse.ar(freq * 0.5, 0.5),
        PinkNoise.ar()
	]) * subOscVol * (1 + (subOscLfoDepth * ((lfo1Dest.eq(1)) * lfo1 + (lfo2Dest.eq(1)) * lfo2)));


    // OSC 2
    // Calculate Osc2 pitch with modulation from modEnv if needed
    osc2Pitch = freq * osc2Coarse * osc2Fine *
        (osc2KbdTrack * 1 + (1 - osc2KbdTrack) * (440 / freq)) *
	(1 + ((modEnvTarget.eq(0)) * modEnv).midiratio);



    // Apply pitch LFO to Osc2
	osc2Pitch = osc2Pitch * ((lfo1Dest.eq(0)) * lfo1Scaled.midiratio + (lfo2Dest.eq(0)) * lfo2Scaled.midiratio);



    osc2 = Select.ar(osc2Wave, [
        SinOsc.ar(osc2Pitch),
        LFTri.ar(osc2Pitch),
        Saw.ar(osc2Pitch),
        Pulse.ar(
            osc2Pitch,
			(lfo1Dest.eq(3)) * lfo1Scaled + (lfo2Dest.eq(3)) * lfo2Scaled + 0.5
        )
    ]);


    // FM MODULATION
    fmModAmount = fmAmount * (1 + ((modEnvTarget.eq(1)) * modEnv)) *
	((lfo1Dest.eq(4)) * lfo1Scaled + (lfo2Dest.eq(4)) * lfo2Scaled + (1 - ((lfo1Dest.eq(4)) + (lfo2Dest.eq(4)))));


    osc2 = Select.kr(syncMode, [
        osc2, // No sync
        SyncSaw.ar(osc2Pitch, osc1 * osc2Pitch), // Osc2 syncs to Osc1
        SyncSaw.ar(freq, osc2 * freq) // Osc1 syncs to Osc2
    ]);


    // Apply FM if needed
    osc1 = if(fmModAmount > 0, SinOsc.ar(freq, osc2 * fmModAmount * 2pi), osc1);


    // RING MODULATION
    ringMod = osc1 * osc2 * ringModulation;

    // NOISE GENERATOR
    noise = PinkNoise.ar() * noiseVol;

    // MIXER
    oscMixer = (osc1 * osc1Vol) + (subOsc * subOscVol) + (osc2 * osc2Vol) + noise + ringMod;

    // FILTER
    filterCutoffMod = filterCutoff *
        (1 + filterEnv) *
	((lfo1Dest.eq(4)) * lfo1Scaled + (lfo2Dest.eq(2)) * lfo2Scaled);



    // Add keyboard tracking to filter
    filterCutoffMod = filterCutoffMod * Select.kr(filterKbdTrack, [
        1, // No tracking
        (freq/440).sqrt, // Quarter
        (freq/440).pow(0.75), // Half
        (freq/440) // Full
    ]);

    filteredSignal = Select.ar(filterType, [
        RLPF.ar(oscMixer, filterCutoffMod.clip(20, 20000), filterResonance.reciprocal),
        MoogFF.ar(oscMixer, filterCutoffMod.clip(20, 20000), filterResonance * 4),
        RHPF.ar(oscMixer, filterCutoffMod.clip(20, 20000), filterResonance.reciprocal),
        BPF.ar(oscMixer, filterCutoffMod.clip(20, 20000), filterResonance.reciprocal)
    ]);

    // AMPLIFIER
    amplifiedSignal = filteredSignal * ampEnv *
	((lfo1Dest.eq(1)) * lfo1Scaled + (lfo2Dest.eq(1)) * lfo2Scaled + (1 - ((lfo1Dest.eq(1)) + (lfo2Dest.eq(1)))));


    // EFFECTS CHAIN

    // 1. EQUALIZER
    eqSignal = BPeakEQ.ar(
        amplifiedSignal,
        eqFreq,
        eqQ,
        eqLevel
    );

    // Apply EQ Tone (simple shelf filtering)
    eqSignal = BLowShelf.ar(eqSignal, 300, 1, eqTone * -1); // Invert for low shelf
    eqSignal = BHiShelf.ar(eqSignal, 3000, 1, eqTone);


	// TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// the "Mix.fill(numVoices)" line produces the error "Index not an Integer" b/c 'numVoices' is type "Select"
	// which can't fucking use to create an array.
	// you're basically trying to variably allocate an array, when you really shouldn't be

    // 2. CHORUS/FLANGER
	/*
	chorusSignal = if(chorusOn & 1,{
        var wet, numVoices;
		numVoices = Select.ar(chorusType,[1, 2, 4]);
		numVoices.postln;
		wet = Mix.fill(numVoices, {|i|
            var phase = i / numVoices * 2pi;
            DelayC.ar(
                eqSignal,
                0.05, // Max delay time
                chorusTime + (SinOsc.kr(chorusRate, phase) * chorusDepth * 0.01),
                chorusFdbk
            )
        }) / numVoices;
		(wet * chorusWet) + (eqSignal * (1 - chorusWet))

	},
        eqSignal
    );
	*/

	chorusSignal = eqSignal;


    // 3. DELAY
    delayTimeSeconds = Select.kr(delayTime.clip(0, 18) / 2, [
        4/bps, 3/bps, 2/bps, 1.5/bps, 1/bps, 0.75/bps, 0.5/bps,
        0.375/bps, 0.25/bps, 0.1875/bps, 0.125/bps, 0.09375/bps, 0.0625/bps
    ]);



	// weird fkn issue in here:
	// ^^ ERROR: Message 'at' not understood. Perhaps you misspelled 'as', or meant to call 'at' on another receiver?
	// something to do with chorusSignal inside one of the selected delay types, not sure what tho
    delayedSignal = if(delayOn > 0,{
        var wet, filtered;

        wet = Select.ar(delayType, [
            // Stereo Delay
            [
                CombC.ar(chorusSignal[0], 5, delayTimeSeconds * (1 - delaySpread), delayFdbk),
                CombC.ar(chorusSignal[1], 5, delayTimeSeconds * (1 + delaySpread), delayFdbk)
            ],
            // Cross Delay
            [
                CombC.ar(chorusSignal[1], 5, delayTimeSeconds * (1 - delaySpread), delayFdbk),
                CombC.ar(chorusSignal[0], 5, delayTimeSeconds * (1 + delaySpread), delayFdbk)
            ],
            // Ping-Pong Delay
            {
				var pingPong = Mix(chorusSignal);
                var a = CombC.ar(pingPong, 5, delayTimeSeconds, 0);
                var b = DelayC.ar(a, 5, delayTimeSeconds * (1 + delaySpread));
                [a, b] * delayFdbk
			}
        ]);

        // Apply delay tone (LPF)
        filtered = LPF.ar(wet, delayTone);

		(filtered * delayWet) + (chorusSignal * (1 - delayWet))},
        chorusSignal
    );



    // 4. EFFECT UNIT
    effectSignal = if(effectOn > 0,{
        var wet;

        wet = Select.ar(effectType, [
            // 0. Distortion 1 (tanh)
            (delayedSignal * (1 + (effectCtrl1 * 20))).tanh * (1 / (1 + effectCtrl1 * 3)),

            // 1. Distortion 2 (clip)
            (delayedSignal * (1 + (effectCtrl1 * 20))).clip2(effectCtrl2) * (1 / (1 + effectCtrl1)),

            // 2. Digital Distortion
            delayedSignal.round(2.pow(effectCtrl1.linlin(0, 1, -1, -16))) * effectCtrl2 * 2,

            // 3. Decimator
            Decimator.ar(
                delayedSignal,
                effectCtrl1.linexp(0, 1, 44100, 1000),
                effectCtrl2.linlin(0, 1, 24, 4)
            ),

            // 4. Phaser
			{
                var numStages = 6;
                var phaser = delayedSignal;
                numStages.do {
                    phaser = AllpassC.ar(
                        phaser,
                        0.01,
                        SinOsc.kr(
                            effectCtrl1.linexp(0, 1, 0.1, 10),
                            0,
                            0.005,
                            0.006
                        ),
                        0,
                        effectCtrl2
                    )
                };
                phaser
            },

            // 5. Ring Modulator Effect
            delayedSignal * SinOsc.ar(effectCtrl1.linexp(0, 1, 10, 1000)) * effectCtrl2,

            // 6. Compressor
            Compander.ar(
                delayedSignal,
                delayedSignal,
                thresh: effectCtrl1.linlin(0, 1, 0.9, 0.1),
                ratioBelow: 1,
                ratioAbove: effectCtrl2.linlin(0, 1, 1, 20),
                attackTime: 0.01,
                releaseTime: 0.1
            )
        ]);

		(wet * effectWet) + (delayedSignal * (1 - effectWet))},
        delayedSignal
    );

    // Final gain and panning
    finalSignal = effectSignal * ampGain * velocity;
    finalSignal = Pan2.ar(
        finalSignal,
        pan + ((lfo1Dest == 5) * lfo1Scaled + (lfo2Dest == 5) * lfo2Scaled)
    );

    Out.ar(outBus, finalSignal);
}).add;

)