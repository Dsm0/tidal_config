(
~dirt.addModule('tape', { |dirtEvent|
	dirtEvent.sendSynth('tape' ++ ~dirt.numChannels,
		[tape: ~tape,
		 tape_saturation: ~tape_saturation,
		 tape_drive: ~tape_drive,
		 tape_oversample: ~tape_oversample,
		 tape_mode: ~tape_mode,
		 out: ~out])
}, { ~tape.notNil}); // play effect only if tape value was given
);

(

SynthDef("tape" ++ ~dirt.numChannels, {
	|out, tape = 1.0, tape_saturation=0.5, tape_drive=0.2, tape_oversample=1, tape_mode=0 |

	var in = In.ar(out, ~dirt.numChannels);

	var mode = tape_mode % 4;
	var oversample = tape_oversample % 5;

	var drive = tape_drive;
	var new_signal = AnalogTape.ar(in,tape,tape_saturation,0.5 + drive,mode);

	// MODES:
	// 0 = RK2 (2nd order Runge Kutta)
	// 1 = RK4 (4th order Runge Kutta)
	// 2 = NR4 (4-iteration Newton Raphson)
	// 3 = NR8 (8-iteration Newton Raphson)

	ReplaceOut.ar(out, new_signal)

}).add;
)

// ~dirt.modules;
// Quarks.gui

// Platform.userExtensionDir