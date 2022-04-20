

(
~dirt.addModule('nonlinear', { |dirtEvent|
	dirtEvent.sendSynth('nonlinear' ++ ~dirt.numChannels,
		[nonlinear: ~nonlinear,
		 nonlinear_saturation: ~nonlinear_saturation,
		 nonlinear_shape: ~nonlinear_shape
		 nonlinear_gain: ~nonlinear_gain,
		 nonlinear_q: ~nonlinear_q,
		 nonlinear_freq: ~nonlinear_freq,
		 out: ~out])
}, { ~tape.notNil}); // play effect only if tape value was given
);

(

SynthDef("tape" ++ ~dirt.numChannels, {
	|out, nonlinear_tape = 1.0, nonlinear_freq=500,nonlinear_q=0.5
	    ,nonlinear_gain=1,nonlinear_shape=5,nonlinear_saturation=3|

	var in = In.ar(out, ~dirt.numChannels);

	var mode = tape_mode % 4;
	var oversample = tape_oversample % 5;

	// var NonlinearFilter.ar

	var new_signal = NonlinearFilter.ar(in,
		nonlinear_freq,
		nonlinear_q,
		nonlinear_gain,
		nonlinear_shape,
		nonlinear_saturation);

	ReplaceOut.ar(out, new_signal)

}).add;
)

// ~dirt.modules;
// Quarks.gui

// Platform.userExtensionDir