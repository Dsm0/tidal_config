(
SynthDef(\gutter, { |out=0, pan=0, gamma=0.2, omega=0.0002, c=0.01, dt=0.03, singlegain=1.4, smoothing=1, togglefilters=1, distortionmethod=1, oversampling=1, enableaudioinput=0, speed=1, pitch=1, q=80, gain1=1.5, gain2=1.5, freq = 440, accelerate = 0, sustain=1, gain=1|
	// NOTE: would be nice to add a system to more dynamically change these frequencies, would require extra parameters tho + some hard decisions about how to boil it down to a few parameters
    var baseFreqs = [104.09, 272.02, 142.54, 740.98, 3231.11, 598.49, 564.11, 152.54, 4773.62, 798.26, 729.54, 734.38, 661.90, 133.46, 1715.61, 11658.96, 6408.56, 11775.30, 857.53, 2020.25, 14168.22, 192.18, 326.56, 4386.85];
    var detuneFactors = Array.fill(24, { rrand(0.95, 1.05) });
    var qVars1 = Array.fill(24, { rrand(0.9, 1.1) });
    var qVars2 = Array.fill(24, { rrand(0.9, 1.1) });

    var pitchLag = pitch.lag3(0.1);

	var freqSpeedMult = (1+(freq/440.0)) * speed * XLine.kr(1, exp(accelerate), sustain, doneAction: Done.freeSelf);
	var freqs1 = baseFreqs * pitchLag * freqSpeedMult;
    var freqs2 = freqs1 * detuneFactors * freqSpeedMult;

    var qLag = q.lag3(0.1);
    var qs1 = qVars1 * qLag;
    var qs2 = qVars2 * qLag;

    var gains1 = gain1 ! 24; // NOTE: similar issue with the gains
    var gains2 = gain2 ! 24;

    var sig = GutterSynth.ar(
        gamma: gamma,
        omega: omega,
        c: c,
        dt: dt,
        singlegain: singlegain,
        smoothing: smoothing,
		togglefilters: 1,
        distortionmethod: distortionmethod,
        oversampling: 1,
        enableaudioinput: 0,
        audioinput: 0,
        gains1: gains1,
        gains2: gains2,
        freqs1: freqs1,
        qs1: qs1,
        freqs2: freqs2,
        qs2: qs2
    );

    sig = Pan2.ar(sig, pan,gain);
    sig = Limiter.ar(sig);
    Out.ar(out, sig);
}).add;
)


// (
// ~dirt.addModule("gutter_soundin", { |dirtEvent|
//     dirtEvent.sendSynth("gutter_soundin" ++ ~dirt.numChannels,
//         [
//             gamma: ~gamma,
//             omega: ~omega,
//             c: ~c,
//             dt: ~dt,
//             singlegain: ~singlegain,
//             smoothing: ~smoothing,
//             togglefilters: ~togglefilters,
//             orbitin: ~orbitin,
//             speed: ~speed,
//             pitch: ~pitch,
//             q: ~q,
//             gain1: ~gain1,
//             gain2: ~gain2,
//             freq: ~freq,
//             accelerate: ~accelerate,
//             sustain: ~sustain,
//             gutter_soundin_mix: ~gutter_soundin_mix,
//             out: ~out
//         ])
// }, { ~gutter_soundin_mix.notNil});
// )


// (
// SynthDef("gutter_soundin" ++ ~dirt.numChannels, { |out=0, pan=0, gamma=0.2, omega=0.0002, c=0.01, dt=0.03, gutter_soundin_mix = 0.5,singlegain=1.4, smoothing=1, togglefilters=1, distortionmethod=1, oversampling=1, orbitin=0, enableaudioinput=0, speed=1, pitch=1, q=80, gain1=1.5, gain2=1.5, gain=1,freq = 440, accelerate = 0, sustain=1|
// 	// NOTE: would be nice to add a system to more dynamically change these frequencies, would require extra parameters tho + some hard decisions about how to boil it down to a few parameters
//     var baseFreqs = [104.09, 272.02, 142.54, 740.98, 3231.11, 598.49, 564.11, 152.54, 4773.62, 798.26, 729.54, 734.38, 661.90, 133.46, 1715.61, 11658.96, 6408.56, 11775.30, 857.53, 2020.25, 14168.22, 192.18, 326.56, 4386.85];
//     var detuneFactors = Array.fill(24, { rrand(0.95, 1.05) });
//     var qVars1 = Array.fill(24, { rrand(0.9, 1.1) });
//     var qVars2 = Array.fill(24, { rrand(0.9, 1.1) });

//     var pitchLag = pitch.lag3(0.1);

// 	var freqSpeedMult = (1+(freq/440.0)) * speed * XLine.kr(1, exp(accelerate), sustain, doneAction: Done.freeSelf);
// 	var freqs1 = baseFreqs * pitchLag * freqSpeedMult;
//     var freqs2 = freqs1 * detuneFactors * freqSpeedMult;

//     var qLag = q.lag3(1);
//     var qs1 = qVars1 * qLag;
//     var qs2 = qVars2 * qLag;

//     var gains1 = gain1 ! 24; // NOTE: similar issue with the gains
//     var gains2 = gain2 ! 24;

//     var in = In.ar(out, 2); // Assuming stereo input

//     var sig = in;

//     sig = GutterSynth.ar(
//         gamma: gamma,
//         omega: omega,
//         c: c,
//         dt: dt,
//         singlegain: singlegain,
//         smoothing: smoothing,
// 		togglefilters: 1,
//         distortionmethod: distortionmethod,
//         oversampling: 1,
//         enableaudioinput: 1,
//         audioinput: in,
//         gains1: gains1,
//         gains2: gains2,
//         freqs1: freqs1,
//         qs1: qs1,
//         freqs2: freqs2,
//         qs2: qs2
//     );

//     // sig = Pan2.ar(sig, pan);

//     sig = XFade2.ar(in, sig, gutter_soundin_mix);
//     sig = LeakDC.ar(sig);

//     ReplaceOut.ar(out, sig);

// }).add;
// )

