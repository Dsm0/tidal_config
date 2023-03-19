(
(
~dirt.addModule('master_eq', { |dirtEvent|
	dirtEvent.sendSynth('master_eq' ++ ~dirt.numChannels,
		[master_eq: ~master_eq])
}, { ~master_eq.notNil}); // play effect only if tape value was given
);


SynthDef("master_eq" ++ ~dirt.numChannels, Patch({
	|out, master_eq , freq = 1200.0, rq=1.0, db=0.0|

	var in = In.ar(out, ~dirt.numChannels);

	var new_signal = BPeakEQ.ar(in, freq, rq, db);

	ReplaceOut.ar(out, new_signal)

}).gui

)

)