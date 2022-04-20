(
~dirt.addModule('midside', { |dirtEvent|
	dirtEvent.sendSynth('midside' ++ ~dirt.numChannels,	[midside: ~midside,out: ~out])
}, { ~midside.notNil}); // play synth only if at least one of the two was given
);

(

SynthDef("midside" ++ ~dirt.numChannels, { |out, midside = 0.5|

	var in = In.ar(out, ~dirt.numChannels);
	var new_sig = Balance2.ar(in[0] + in[1], in[0] - in[1], midside);

	var signal = [new_sig[0] + new_sig[1], new_sig[0] - new_sig[1]];

	signal = signal; // this controls wet/dry
	ReplaceOut.ar(out, signal)

}).add;
)

// ~dirt.modules;