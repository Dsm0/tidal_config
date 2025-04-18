(
SynthDef("basicDelay" ++ ~dirt.numChannels, { | out=0, basicDelay_time=0.5, basicDelay_feedback=0.5, basicDelay_mix=0.5|
    var input, delayed, fbSignal;
    input = In.ar(out, 2);
    fbSignal = LocalIn.ar(2) * basicDelay_feedback;
    delayed = DelayN.ar(input + fbSignal, 2, basicDelay_time);
    LocalOut.ar(delayed);
    // Mix dry/wet
    Out.ar(out, (input * (1 - basicDelay_mix)) + (delayed * basicDelay_mix));
}).add;
)


(
SynthDef("multiTapDelay" ++ ~dirt.numChannels, { |out=0, multiTapDelay_times=#[0.2, 0.4, 0.6], multiTapDelay_amps=#[1.0, 1.0, 1.0], multiTapDelay_feedback=0.3, multiTapDelay_mix=0.5|
    var input, taps, fbSignal;
    input = In.ar(out, 2);
    fbSignal = LocalIn.ar(2) * multiTapDelay_feedback;
    taps = Mix.ar(
        DelayN.ar(input + fbSignal, 2, multiTapDelay_times) * multiTapDelay_amps
    );
    LocalOut.ar(taps);
    ReplaceOut.ar(out, (input * (1 - multiTapDelay_mix)) + (taps * multiTapDelay_mix));
}).add;
)



(
SynthDef("pingPongDelay" ++ ~dirt.numChannels, { |out=0, pingPongDelay_delayTime=0.3, pingPongDelay_feedback=0.4, pingPongDelay_mix=0.5|
    var input, left, right, ppSignal;
    input = In.ar(out, 2);
    ppSignal = LocalIn.ar(2);

	// pingPongDelay_delayTime = if(0.0.equalWithPrecision(pingPongDelay_delayTime, 0.0001), 0.3, pingPongDelay_delayTime);
	pingPongDelay_feedback = if(0.0.equalWithPrecision(pingPongDelay_feedback, 0.0001), 0.8, pingPongDelay_feedback);
	pingPongDelay_mix = if(0.0.equalWithPrecision(pingPongDelay_mix, 0.0001), 0.5, pingPongDelay_mix);

    // Process left and right with cross-feedback
    left = input[0] + (ppSignal[1] * pingPongDelay_feedback);
    right = input[1] + (ppSignal[0] * pingPongDelay_feedback);
    ppSignal = DelayN.ar([left, right], 2, pingPongDelay_delayTime);
    LocalOut.ar(ppSignal);
    // Mix dry/wet
    ReplaceOut.ar(out, (input * (1 - pingPongDelay_mix)) + (ppSignal * pingPongDelay_mix));
}).add;
)

(
SynthDef("pingPongDelay" ++ ~dirt.numChannels, { 
    |out=0, pingPongDelay_delayTime=0.3, pingPongDelay_feedback=0.4, pingPongDelay_mix=0.2|
    var input, local;

    input = In.ar(out, 2);
    local = LocalIn.ar(2) + [input, 0]; // read feedback, add to source
    local = DelayN.ar(local, 0.8, pingPongDelay_delayTime); // delay sound

    // reverse channels to give ping pong effect, apply decay factor
    LocalOut.ar(local.reverse * pingPongDelay_feedback);

    // local
    ReplaceOut.ar(out, input * (1 - pingPongDelay_mix) + (local * pingPongDelay_mix));
}).add;
)










(
SynthDef("modDelay" ++ ~dirt.numChannels, { |in=0, out=0, modDelay_baseDelay=0.2, modDelay_modRate=0.2, modDelay_modDepth=0.01, modDelay_feedback=0.3, modDelay_mix=0.5|
    var input, lfo, delayTime, delayed, fbSignal;
    input = In.ar(in, 2);
    fbSignal = LocalIn.ar(2) * modDelay_feedback;
    // LFO modulation
    lfo = SinOsc.kr(modDelay_modRate).range(modDelay_baseDelay - modDelay_modDepth, modDelay_baseDelay + modDelay_modDepth);
    delayed = DelayL.ar(input + fbSignal, 2, lfo); // Linear interpolation
    LocalOut.ar(delayed);
    // Mix dry/wet
    Out.ar(out, (input * (1 - modDelay_mix)) + (delayed * modDelay_mix));
}).add;
)

(
SynthDef("tapeDelay" ++ ~dirt.numChannels, { |in=0, out=0, tapeDelay_delayTime=0.5, tapeDelay_feedback=0.6, tapeDelay_lpfFreq=2000, tapeDelay_saturation=2.0, tapeDelay_mix=0.5|
    var input, delayed, fbSignal, processed;
    input = In.ar(in, 2);
    fbSignal = LocalIn.ar(2) * tapeDelay_feedback;
    // Add tape wow with slight delay modulation
    delayed = DelayN.ar(input + fbSignal, 2, tapeDelay_delayTime * LFNoise1.kr(0.1!2).range(0.99, 1.01));
    // Tape saturation and filtering
    processed = (delayed * tapeDelay_saturation).tanh;
    processed = LPF.ar(processed, tapeDelay_lpfFreq);
    LocalOut.ar(processed);
    // Mix dry/wet
    Out.ar(out, (input * (1 - tapeDelay_mix)) + (processed * tapeDelay_mix));
}).add;
)




// ... existing code ...

// SuperDirt declaration for \basicDelay
(
~dirt.addModule('basicDelay', { |dirtEvent|
    dirtEvent.sendSynth('basicDelay' ++ ~dirt.numChannels,
        [
            basicDelay_time: ~basicDelay_time,
            basicDelay_feedback: ~basicDelay_feedback,
            basicDelay_mix: ~basicDelay_mix,
            out: ~out
        ]
    )
}, { ~basicDelay_time.notNil or: { ~basicDelay_feedback.notNil } or: { ~basicDelay_mix.notNil } });
)

(
// SuperDirt declaration for \multiTapDelay
~dirt.addModule('multiTapDelay', { |dirtEvent|
    dirtEvent.sendSynth('multiTapDelay' ++ ~dirt.numChannels,
        [
            multiTapDelay_times: ~multiTapDelay_times,
            multiTapDelay_amps: ~multiTapDelay_amps,
            multiTapDelay_feedback: ~multiTapDelay_feedback,
            multiTapDelay_mix: ~multiTapDelay_mix,
            out: ~out
        ]
    )
}, { ~multiTapDelay_times.notNil or: { ~multiTapDelay_amps.notNil } or: { ~multiTapDelay_feedback.notNil } or: { ~multiTapDelay_mix.notNil } });
)



(
// SuperDirt declaration for \pingPongDelay
~dirt.addModule('pingPongDelay', { |dirtEvent|
    dirtEvent.sendSynth('pingPongDelay' ++ ~dirt.numChannels,
        [
            pingPongDelay_delayTime: ~pingPongDelay_delayTime,
            pingPongDelay_feedback: ~pingPongDelay_feedback,
            pingPongDelay_mix: ~pingPongDelay_mix,
            out: ~out
        ]
    )
}, { ~pingPongDelay_delayTime.notNil or: { ~pingPongDelay_feedback.notNil } or: { ~pingPongDelay_mix.notNil } });
)

(
// SuperDirt declaration for \modDelay
~dirt.addModule('modDelay', { |dirtEvent|
    dirtEvent.sendSynth('modDelay' ++ ~dirt.numChannels,
        [
            modDelay_baseDelay: ~modDelay_baseDelay,
            modDelay_modRate: ~modDelay_modRate,
            modDelay_modDepth: ~modDelay_modDepth,
            modDelay_feedback: ~modDelay_feedback,
            modDelay_mix: ~modDelay_mix,
            out: ~out
        ]
    )
}, { ~modDelay_baseDelay.notNil or: { ~modDelay_modRate.notNil } or: { ~modDelay_modDepth.notNil } or: { ~modDelay_feedback.notNil } or: { ~modDelay_mix.notNil } });
)

(
// SuperDirt declaration for \tapeDelay
~dirt.addModule('tapeDelay', { |dirtEvent|
    dirtEvent.sendSynth('tapeDelay' ++ ~dirt.numChannels,
        [
            tapeDelay_delayTime: ~tapeDelay_delayTime,
            tapeDelay_feedback: ~tapeDelay_feedback,
            tapeDelay_lpfFreq: ~tapeDelay_lpfFreq,
            tapeDelay_saturation: ~tapeDelay_saturation,
            tapeDelay_mix: ~tapeDelay_mix,
            out: ~out
        ]
    )
}, { ~tapeDelay_delayTime.notNil or: { ~tapeDelay_feedback.notNil } or: { ~tapeDelay_lpfFreq.notNil } or: { ~tapeDelay_saturation.notNil } or: { ~tapeDelay_mix.notNil } });
)






SuperDirt.postTidalParameters([\basicDelay, \multiTapDelay, \pingPongDelay, \modDelay, \tapeDelay])









// Boot server
s.boot;

// Create a dry bus
~dryBus = Bus.audio(s, 2);

// Simple sound source (saw wave)
(
SynthDef(\sawPulse, { |freq=440, amp=0.2, gate=1|
    var env = EnvGen.kr(Env.asr(0.1, 1, 0.2), gate, doneAction:2);
    var sig = Saw.ar(freq) * amp * env;
    Out.ar(~dryBus, sig!2);
}).add;
)

// Create delay effect
y = Synth(\tapeDelay, [\in, ~dryBus, \out, 0, \delayTime, 0.4, \feedback, 0.7, \mix, 0.5]);

// Play notes
Pbind(
    \instrument, \sawPulse,
    \dur, 0.5,
    \midinote, Pseq([60, 64, 67, 72], inf)
).play;