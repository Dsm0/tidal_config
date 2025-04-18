(
SynthDef(\synth1, {
    // ==== Variable Declarations ====
    // Signal Flow Variables
    var osc1Freq, osc2Freq, subOscFreq, baseFreq;
    var osc1Signal, osc2Signal, subOscSignal, mixedOscSignal;
    var oscModEnv, oscModEnvScaled;
    var filteredSignal, filterEnv;
    var ampEnv, amplifiedSignal;
    var lfo1Signal, lfo2Signal;
    var eqSignal, delaySignal, chorusSignal, fxSignal, finalSignal;

    // Modulation Variables
    var modPW, modFMAmount, osc2PitchMod;
    var noteOffset, effectiveCutoff, filterCutoffMod, effectiveEnvAmt, finalCutoff;
    var velAmpMod, ampMod, panModulation;

    // Delay Variables
    var delayTimeValue, delayL, delayR, delayFiltered, delayOutput;

    // Chorus Variables
    var numChorusVoices, chorusSignalArray, chorusMix;

    // FX Variables
    var fxUnit;

    // ==== CONTROL DEFINITIONS ====
    // Global
    var gate = \gate.kr(1);
    var freq = \freq.kr(440);
    var velocity = \velocity.kr(100).linlin(0, 127, 0, 1);
    var keyShift = \keyShift.kr(0); // -24 to 24 semitones

    // Oscillator 1
    var osc1Shape = \osc1Shape.kr(0); // 0:Sine, 1:Saw, 2:Pulse, 3:Triangle
    var osc1FM = \osc1FM.kr(0).linlin(0, 127, 0, 1);
    var osc1Detune = \osc1Detune.kr(64).linlin(0, 127, -62, 61).midiratio;
    var oscPhaseShift = \oscPhaseShift.kr(0).linlin(0, 127, 0, 2pi);

    // Oscillator 2
    var osc2Shape = \osc2Shape.kr(1); // 1:Saw, 2:Pulse, 3:Triangle, 4:Noise
    var osc2PitchSemi = \osc2PitchSemi.kr(64).linlin(0, 127, -60, 60);
    var osc2FineTune = \osc2FineTune.kr(64).linlin(0, 127, -62, 61).midiratio;
    var osc2KbdTrack = \osc2KbdTrack.kr(1);
    var osc2Sync = \osc2Sync.kr(0);
    var osc2RingMod = \osc2RingMod.kr(0);

    // Pulse Width (shared)
    var oscPW = \oscPW.kr(64).linlin(0, 127, 0.01, 0.99);

    // Sub Oscillator
    var osc1SubShape = \osc1SubShape.kr(0); // 0:Sine, 1:Triangle, 2:Saw, 3:Pulse
    var osc1SubOctave = \osc1SubOctave.kr(0); // 0:same, 1:-1 octave
    var osc1SubGain = \osc1SubGain.kr(100).linlin(0, 127, 0, 1);

    // Oscillator Mod Envelope
    var oscModEnvAttack = \oscModEnvAttack.kr(0.01);
    var oscModEnvDecay = \oscModEnvDecay.kr(1.0);
    var oscModEnvAmt = \oscModEnvAmt.kr(64).linlin(0, 127, -1, 1);
    var oscModDest = \oscModDest.kr(0); // 0:Osc2Pitch, 1:FMAmount, 2:PulseWidth

    // Mixer
    var oscMix = \oscMix.kr(64).linlin(0, 127, 0, 1);

    // Filter
    var filtType = \filtType.kr(0); // 0:LPF12, 1:LPF24, 2:HPF, 3:BPF
    var filtFreq = \filtFreq.kr(64).linexp(0, 127, 20, 20000);
    var filtReso = \filtReso.kr(0).linlin(0, 127, 0.0, 1.0);
    var filtEnvAmt = \filtEnvAmt.kr(64).linlin(0, 127, -1, 1);
    var filtAttack = \filtAttack.kr(0.01);
    var filtDecay = \filtDecay.kr(0.3);
    var filtSustain = \filtSustain.kr(0.5);
    var filtRelease = \filtRelease.kr(1.0);
    var filtKbdTrack = \filtKbdTrack.kr(64).linlin(0, 127, 0, 1);
    var filtSat = \filtSat.kr(0).linlin(0, 127, 0, 1);
    var filtVelSwitch = \filtVelSwitch.kr(0);

    // Amplifier
    var ampAttack = \ampAttack.kr(0.01);
    var ampDecay = \ampDecay.kr(0.1);
    var ampSustain = \ampSustain.kr(0.8);
    var ampRelease = \ampRelease.kr(0.5);
    var ampGain = \ampGain.kr(100).linlin(0, 127, 0, 1);
    var ampVelSens = \ampVelSens.kr(64).linlin(0, 127, 0, 1);

    // LFO1
    var lfo1On = \lfo1On.kr(0);
    var lfo1Waveform = \lfo1Waveform.kr(0); // 0:Saw, 1:Tri, 2:Sin, 3:Pulse, 4:S&H, 5:Smooth
    var lfo1Rate = \lfo1Rate.kr(64).linexp(0, 127, 0.01, 50);
    var lfo1Depth = \lfo1Depth.kr(64).linlin(0, 127, 0, 1);
    var lfo1TempoSync = \lfo1TempoSync.kr(0);
    var lfo1KeySync = \lfo1KeySync.kr(0);
    var lfo1Dest = \lfo1Dest.kr(1); // 1-7 for destinations

    // LFO2
    var lfo2On = \lfo2On.kr(0);
    var lfo2Waveform = \lfo2Waveform.kr(0);
    var lfo2Rate = \lfo2Rate.kr(64).linexp(0, 127, 0.01, 50);
    var lfo2Depth = \lfo2Depth.kr(64).linlin(0, 127, 0, 1);
    var lfo2TempoSync = \lfo2TempoSync.kr(0);
    var lfo2KeySync = \lfo2KeySync.kr(0);
    var lfo2Dest = \lfo2Dest.kr(1);

    // Effects - EQ
    var eqTone = \eqTone.kr(64).linlin(0, 127, 0, 1);
    var eqFreq = \eqFreq.kr(64).linexp(0, 127, 50, 16000);
    var eqLevel = \eqLevel.kr(64).linlin(0, 127, -25, 24).dbamp;
    var eqQ = \eqQ.kr(64).linexp(0, 127, 0.1, 10);

    // Effects - Delay
    var delayOn = \delayOn.kr(0);
    var delayType = \delayType.kr(0); // 0:ST, 1:X, 2:PP
    var delayTime = \delayTime.kr(9); // 0-19 mapped to time divisions
    var delaySpread = \delaySpread.kr(0).linlin(0, 127, 0, 0.5);
    var delayFdbk = \delayFdbk.kr(64).linlin(0, 127, 0, 0.9);
    var delayTone = \delayTone.kr(64).linlin(0, 127, 0, 1);
    var delayWet = \delayWet.kr(64).linlin(0, 127, 0, 1);

    // Effects - Chorus
    var chorusOn = \chorusOn.kr(0);
    var chorusType = \chorusType.kr(1); // 1:x1, 2:x2, 3:x4, 4:flanger
    var chorusTimeMs = \chorusTimeMs.kr(64).linlin(0, 127, 0.05, 30) / 1000;
    var chorusDepth = \chorusDepth.kr(64).linlin(0, 127, 0, 1);
    var chorusRateHz = \chorusRateHz.kr(64).linexp(0, 127, 0.01, 10);
    var chorusFdbk = \chorusFdbk.kr(64).linlin(0, 127, 0, 0.9);
    var chorusLevel = \chorusLevel.kr(64).linlin(0, 127, 0, 1);

    // Effects - FX Unit
    var fxOn = \fxOn.kr(0);
    var fxType = \fxType.kr(0); // 0-9 for effect types
    var fxCtrl1 = \fxCtrl1.kr(64).linlin(0, 127, 0, 1);
    var fxCtrl2 = \fxCtrl2.kr(64).linlin(0, 127, 0, 1);
    var fxMix = \fxMix.kr(64).linlin(0, 127, 0, 1);

    // Pan and Output
    var pan = \pan.kr(64).linlin(0, 127, -1, 1);
    var amp = \amp.kr(0.3);

    // Unison
    var unisonOn = \unisonOn.kr(0);
    var unisonVoices = \unisonVoices.kr(2);
    var unisonDetune = \unisonDetune.kr(20).linlin(0, 127, 0, 1);
    var unisonSpread = \unisonSpread.kr(64).linlin(0, 127, 0, 1);
    var unisonPitch = \unisonPitch.kr(24).linlin(0, 48, -24, 24);
    var unisonPhase = \unisonPhase.kr(0).linlin(0, 127, 0, 2pi);

    // Portamento
    var portaTime = \portaTime.kr(0).linexp(0, 127, 0.001, 1);
    var portaAuto = \portaAuto.kr(0);
    var freqLagged = Lag.kr(freq, portaTime);

    // ==== IMPLEMENTATION ====

    // Apply key shift (affects all oscillators)
    baseFreq = freqLagged * keyShift.midiratio;

    // Generate LFOs first to use for modulation
    lfo1Signal = Select.kr(lfo1Waveform, [
        LFSaw.kr(lfo1Rate, iphase: lfo1KeySync * Impulse.kr(0)),
        LFTri.kr(lfo1Rate, iphase: lfo1KeySync * Impulse.kr(0)),
        SinOsc.kr(lfo1Rate, phase: lfo1KeySync * Impulse.kr(0)),
        LFPulse.kr(lfo1Rate, iphase: lfo1KeySync * Impulse.kr(0)),
        LFNoise0.kr(lfo1Rate),
        LFNoise1.kr(lfo1Rate)
    ]) * lfo1Depth * lfo1On;

    lfo2Signal = Select.kr(lfo2Waveform, [
        LFSaw.kr(lfo2Rate, iphase: lfo2KeySync * Impulse.kr(0)),
        LFTri.kr(lfo2Rate, iphase: lfo2KeySync * Impulse.kr(0)),
        SinOsc.kr(lfo2Rate, phase: lfo2KeySync * Impulse.kr(0)),
        LFPulse.kr(lfo2Rate, iphase: lfo2KeySync * Impulse.kr(0)),
        LFNoise0.kr(lfo2Rate),
        LFNoise1.kr(lfo2Rate)
    ]) * lfo2Depth * lfo2On;

    // Calculate modulation envelope
    oscModEnv = Env.new([0, 1, 0], [oscModEnvAttack, oscModEnvDecay], curve: -4).ar(doneAction: Done.none, gate: gate);
    oscModEnvScaled = oscModEnv * oscModEnvAmt;

    // Apply LFO and envelope modulations to parameters
    modPW = oscPW +
        Select.kr(oscModDest == 2, [0, oscModEnvScaled]) +
        ((lfo1Dest == 5) * lfo1Signal) +
        ((lfo2Dest == 5) * lfo2Signal);
    modPW = modPW.clip(0.01, 0.99);

    modFMAmount = osc1FM +
        Select.kr(oscModDest == 1, [0, oscModEnvScaled]) +
        ((lfo1Dest == 6) * lfo1Signal) +
        ((lfo2Dest == 6) * lfo2Signal);
    modFMAmount = modFMAmount.clip(0, 1);

    // Calculate oscillator frequencies with modulation
    osc1Freq = baseFreq * osc1Detune;

    osc2PitchMod =
        Select.kr(oscModDest == 0, [0, oscModEnvScaled]) +
        ((lfo1Dest == 1) * lfo1Signal) +
        ((lfo2Dest == 1) * lfo2Signal) +
        ((lfo1Dest == 2) * lfo1Signal) +
        ((lfo2Dest == 2) * lfo2Signal);

    osc2Freq = Select.kr(osc2KbdTrack > 0, [
        440 * (osc2PitchSemi + osc2PitchMod).midiratio * osc2FineTune,
        baseFreq * (osc2PitchSemi + osc2PitchMod).midiratio * osc2FineTune
    ]);

    // Calculate sub oscillator frequency
    subOscFreq = osc1Freq * Select.kr(osc1SubOctave > 0, [1.0, 0.5]);

    // Generate oscillator 1 signal
    osc1Signal = Select.ar(osc1Shape, [
        SinOsc.ar(osc1Freq + Select.kr(osc2RingMod > 0, [osc2Signal * modFMAmount * 1000, 0]), oscPhaseShift),
        Saw.ar(osc1Freq + Select.kr(osc2RingMod > 0, [osc2Signal * modFMAmount * 1000, 0])),
        Pulse.ar(osc1Freq + Select.kr(osc2RingMod > 0, [osc2Signal * modFMAmount * 1000, 0]), modPW),
        LFTri.ar(osc1Freq + Select.kr(osc2RingMod > 0, [osc2Signal * modFMAmount * 1000, 0]))
    ]);

    // Generate sub oscillator signal
    subOscSignal = Select.ar(osc1SubShape, [
        SinOsc.ar(subOscFreq),
        LFTri.ar(subOscFreq),
        Saw.ar(subOscFreq),
        Pulse.ar(subOscFreq, modPW)
    ]) * osc1SubGain;

    // Generate oscillator 2 signal with sync if needed
    osc2Signal = Select.ar(osc2Shape - 1, [
        Select.kr(osc2Sync > 0, [
            Saw.ar(osc2Freq),
            SyncSaw.ar(osc2Freq, osc1Freq)
        ]),
        Select.kr(osc2Sync > 0, [
            Pulse.ar(osc2Freq, modPW),
            SyncSaw.ar(osc2Freq, osc1Freq, modPW)
        ]),
        Select.kr(osc2Sync > 0, [
            LFTri.ar(osc2Freq),
            SyncSaw.ar(osc2Freq, osc1Freq)
        ]),
        Select.kr(osc2Sync > 0, [
            WhiteNoise.ar,
            WhiteNoise.ar * SinOsc.ar(osc1Freq).abs
        ])
    ]);

    // Apply ring modulation if enabled
    osc2Signal = Select.kr(osc2RingMod > 0, [osc2Signal, osc1Signal * osc2Signal]);

    // Mix oscillators
    mixedOscSignal = LinXFade2.ar(osc1Signal + subOscSignal, osc2Signal, oscMix.linlin(0, 1, -1, 1));

    // Implement Unison if enabled
    mixedOscSignal = Select.kr(unisonOn > 0, [
        mixedOscSignal,
        {
            var unisonArray = Array.fill(8, { |i|
                var detuneFactor = (i / 7.0 * 2 - 1) * unisonDetune * 0.1;
                var detuneRatio = detuneFactor.midiratio;
                var uniOsc1 = Select.ar(osc1Shape, [
                    SinOsc.ar(osc1Freq * detuneRatio, oscPhaseShift + (i * unisonPhase / 8)),
                    Saw.ar(osc1Freq * detuneRatio),
                    Pulse.ar(osc1Freq * detuneRatio, modPW),
                    LFTri.ar(osc1Freq * detuneRatio)
                ]);

                var uniOsc2 = Select.ar(osc2Shape - 1, [
                    Saw.ar(osc2Freq * detuneRatio),
                    Pulse.ar(osc2Freq * detuneRatio, modPW),
                    LFTri.ar(osc2Freq * detuneRatio),
                    WhiteNoise.ar
                ]);

                var uniSub = Select.ar(osc1SubShape, [
                    SinOsc.ar(subOscFreq * detuneRatio),
                    LFTri.ar(subOscFreq * detuneRatio),
                    Saw.ar(subOscFreq * detuneRatio),
                    Pulse.ar(subOscFreq * detuneRatio, modPW)
                ]) * osc1SubGain;

                LinXFade2.ar(uniOsc1 + uniSub, uniOsc2, oscMix.linlin(0, 1, -1, 1));
            });
            Splay.ar(unisonArray, unisonSpread, center: pan);
        }.value()
    ]);

    // Filter section
    // Calculate keyboard tracking for filter
    noteOffset = (freq.cpsmidi - 60) * filtKbdTrack;
    effectiveCutoff = (filtFreq * noteOffset.midiratio).clip(20, 20000);

    // Calculate modulation from LFOs for filter cutoff
    filterCutoffMod =
        ((lfo1Dest == 3) * lfo1Signal) +
        ((lfo2Dest == 3) * lfo2Signal);

    // Apply velocity to envelope amount if needed
    effectiveEnvAmt = Select.kr(filtVelSwitch > 0, [filtEnvAmt, filtEnvAmt * velocity]);

    // Generate filter envelope
    filterEnv = Env.adsr(
        filtAttack,
        filtDecay,
        filtSustain,
        filtRelease,
        curve: -4
    ).ar(doneAction: Done.none, gate: gate);

    // Calculate final cutoff with all modulations
    finalCutoff = (effectiveCutoff * (1 + (filterCutoffMod * 2))).clip(20, 20000);
    finalCutoff = finalCutoff * (1 + (filterEnv * effectiveEnvAmt * 10)).clip(20, 20000);

    // Apply filter based on type
    filteredSignal = Select.ar(filtType, [
        RLPF.ar(mixedOscSignal, finalCutoff, filtReso.linlin(0, 1, 1, 0.01)),  // LPF 12dB
        RLPF.ar(RLPF.ar(mixedOscSignal, finalCutoff, filtReso.linlin(0, 1, 1, 0.01)), finalCutoff, filtReso.linlin(0, 1, 1, 0.01)),  // LPF 24dB
        RHPF.ar(mixedOscSignal, finalCutoff, filtReso.linlin(0, 1, 1, 0.01)),  // HPF
        BPF.ar(mixedOscSignal, finalCutoff, filtReso.linlin(0, 1, 1, 0.01))  // BPF
    ]);

    // Apply saturation
    filteredSignal = (1 - filtSat) * filteredSignal + (filtSat * (filteredSignal.tanh));

    // Amplifier section
    // Calculate velocity-sensitive amplitude
    velAmpMod = velocity.linlin(0, 1, 1 - ampVelSens, 1);

    // Apply LFO modulation to amplitude if needed
    ampMod = 1 + (((lfo1Dest == 4) * lfo1Signal) + ((lfo2Dest == 4) * lfo2Signal));

    // Generate amp envelope
    ampEnv = Env.adsr(
        ampAttack,
        ampDecay,
        ampSustain,
        ampRelease,
        curve: -4
    ).ar(doneAction: Done.freeSelf, gate: gate);

    // Apply envelope and velocity
    amplifiedSignal = filteredSignal * ampEnv * ampGain * velAmpMod * ampMod;

    // EQ Section
    eqSignal = BPeakEQ.ar(amplifiedSignal, eqFreq, eqQ, eqLevel);
    eqSignal = BLowShelf.ar(eqSignal, 500, 1, eqTone.linlin(0, 1, -6, 6).dbamp - 1);

    // Delay Section
    delayTimeValue = Select.kr(delayTime, Array.fill(20, { |i|
        (i+1)/24 * TempoClock.default.tempo.reciprocal
    }));

    delayL = CombC.ar(
        eqSignal[0],
        2.0,
        delayTimeValue * (1 - delaySpread),
        delayFdbk * 4
    );

    delayR = CombC.ar(
        eqSignal[1] ? eqSignal[0],
        2.0,
        delayTimeValue * (1 + delaySpread),
        delayFdbk * 4
    );

    delayFiltered = LPF.ar([delayL, delayR], delayTone.linexp(0, 1, 500, 20000));

    // Process based on delay type
    delayOutput = Select.ar(delayType, [
        // ST - Stereo
        delayFiltered,
        // X - Cross feedback (approximated)
        [delayFiltered[1], delayFiltered[0]],
        // PP - Ping-pong (approximated)
        [delayFiltered[0], delayFiltered[1] * 0.7]
    ]);

    delaySignal = XFade2.ar(eqSignal, delayOutput, delayWet.linlin(0, 1, -1, 1));
    delaySignal = Select.ar(delayOn > 0, [eqSignal, delaySignal]);

    // Chorus Section
    numChorusVoices = Select.kr(chorusType, [1, 2, 4, 1]);
    chorusSignalArray = Array.fill(4, { |i|
        var depth = chorusDepth * (i + 1) / 4;
        var rate = chorusRateHz * (1 + (i * 0.1));
        var modulation = SinOsc.kr(rate, pi * i / 2) * depth;
        var delayTime = chorusTimeMs * (1 + modulation);
        DelayC.ar(delaySignal, 0.05, delayTime) * (i < numChorusVoices)
    });

    chorusMix = Mix(chorusSignalArray) / numChorusVoices;

    // Add feedback for chorus if needed
    chorusMix = chorusMix * (1 + (chorusFdbk * chorusMix.reverse));

    chorusSignal = XFade2.ar(delaySignal, chorusMix, chorusLevel.linlin(0, 1, -1, 1));
    chorusSignal = Select.ar(chorusOn > 0, [delaySignal, chorusSignal]);

    // FX Unit Section
    fxUnit = Select.ar(fxType, [
        // 0: Analog Dist 1
        (chorusSignal * (1 + (fxCtrl1 * 10))).tanh * fxCtrl2.linlin(0, 1, 0.5, 1.5),

        // 1: Analog Dist 2
        (chorusSignal * (1 + (fxCtrl1 * 20))).tanh * fxCtrl2.linlin(0, 1, 0.5, 1.5),

        // 2: Digital Dist
        chorusSignal.clip2(fxCtrl1) * fxCtrl2.linlin(0, 1, 0.5, 1.5),

        // 3: Bitcrush/Decimator
        Decimator.ar(
            chorusSignal,
            fxCtrl2.linexp(0, 1, 2000, 44100),
            fxCtrl1.linlin(0, 1, 24, 4)
        ),

        // 4: Phaser
        Phaser.ar(
            chorusSignal,
            fxCtrl1.linexp(0, 1, 0.1, 10),
            fxCtrl2 * 10,
            fxCtrl2 * 0.8
        ),

        // 5: Ring Mod
        chorusSignal * SinOsc.ar(fxCtrl1.linexp(0, 1, 20, 2000)) * fxCtrl2,

        // 6: AM
        chorusSignal * (1 - (fxCtrl2 * 0.5 * (1 - SinOsc.ar(fxCtrl1.linexp(0, 1, 0.1, 50))))),

        // 7: Compressor
        Compander.ar(
            chorusSignal,
            chorusSignal,
            thresh: fxCtrl1.linlin(0, 1, 1, 0.01),
            ratio: fxCtrl2.linlin(0, 1, 1, 10),
            attack: 0.01,
            release: 0.1
        ),

        // 8: Lo-Fi (simple version)
        LPF.ar(chorusSignal, fxCtrl1.linexp(0, 1, 500, 20000)) * fxCtrl2.linlin(0, 1, 0.5, 2.0),

        // 9: Enhancer (simple version)
        chorusSignal + (HPF.ar(chorusSignal, 5000) * fxCtrl1 * fxCtrl2)
    ]);

    fxSignal = XFade2.ar(chorusSignal, fxUnit, fxMix.linlin(0, 1, -1, 1));
    fxSignal = Select.ar(fxOn > 0, [chorusSignal, fxSignal]);

    // Final processing: pan and amplification
    panModulation = pan +
        ((lfo1Dest == 7) * lfo1Signal) +
        ((lfo2Dest == 7) * lfo2Signal);

    finalSignal = Pan2.ar(fxSignal[0], panModulation, amp);

    // Output
    Out.ar(\out.kr(0), finalSignal);
}).add;
)