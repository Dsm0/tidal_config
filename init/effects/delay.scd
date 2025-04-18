(

SynthDef("delay2" ++ ~dirt.numChannels, { |out, delay, delaytime, delayfeedback, delaySend = 1, lock = 0, cps = 1|
	var sig;
	var input = In.ar(out, ~dirt.numChannels);
	var maxDelayTime = 4;

    var delayAmp = delay ? delay : 0.0;

	input = input * delaySend.lag(LFNoise1.kr(1).range(0.01, 0.02)); // regulate input

	delayfeedback = delayfeedback.max(0);
	delaytime = delaytime * if(lock, reciprocal(cps), 1);
	delaytime = delaytime.clip(0, maxDelayTime); // just to be sure
	// from sc3-plugins
	signal = \SwitchDelay.asClass.ar(input, 1, 1, delaytime, delayfeedback, maxDelayTime);

	signal = signal * EnvGen.kr(Env.asr, gate, doneAction:2);
	signal = signal * delayAmp.lag(0.01);

	// DirtPause.ar(signal, graceTime:4);

    sig = XFade2.ar(in, sig, (chorusmix - 0.5)*2);

    ReplaceOut.ar(out, sig);

}, [\ir, \ir]).add;
)


(
    ~dirt.orbits.do { |x|
        x.globalEffects = x.globalEffects.addFirst(GlobalDirtEffect(\delay2, [\delaytime, \delayfeedback, \delaySend, \lock, \cps]));
        x.initNodeTree;
    };
)

// (
// ~dirt.addModule("delay", { |dirtEvent|
//     dirtEvent.sendSynth("delay2" ++ ~dirt.numChannels,
//         [
//             delay: ~delay,
//             delaytime: ~delaytime,
//             delayfeedback: ~delayfeedback,
//             out: ~out
//         ])
// }, { ~delay.notNil});
// );