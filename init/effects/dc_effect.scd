(
~dirt.addModule('dc', { |dirtEvent|
	dirtEvent.sendSynth('dc' ++ ~dirt.numChannels,
		[dc_l: ~dc_l,
		 dc_r: ~dc_r,
		 out: ~out])
}, { ~dc_l.notNil || ~dc_r.notNil}); // play effect only if tape value was given

// ~busses = ~dirt.orbits.collect { |x| x.dryBus };
);


(

SynthDef("dc" ++ ~dirt.numChannels, {
	|out, dc_l=0, dc_r=0|

	var in = In.ar(out, ~dirt.numChannels);

	var new_signal = in + DC.ar([dc_l,dc_r]);

	ReplaceOut.ar(out, new_signal);

}).add;
)

// ~dirt.modules;
// Quarks.gui

// Platform.userExtensionDir
//
// (
// SynthDef("loud" ++ ~dirt.numChannels, { |out, loud = 0|
// 	var signal = In.ar(out, ~dirt.numChannels);
// 	signal = (1 + loud) * signal / (1 + (loud * abs(signal)));
// 	signal = abs(signal);
// 	ReplaceOut.ar(out, signal)
// }, [\ir, \ir]).add;
// )
//
// (
// ~dirt.addModule('loud', { |dirtEvent|
// 	dirtEvent.sendSynth('loud' ++ ~dirt.numChannels,
// 		[loud: ~loud,
// 	out: ~out])
// }, { ~loud.notNil}); // play effect only if tape value was given
// );
