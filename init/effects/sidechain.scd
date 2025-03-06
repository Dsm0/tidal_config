(
~dirt.addModule('sidechain', { |dirtEvent|
	dirtEvent.sendSynth('sidechain' ++ ~dirt.numChannels,
		[
		sidechain: ~sidechain,
		sidechain_thresh: ~sidechain_thresh,
		sidechain_compression: ~sidechain_compression,
		sidechain_attack: ~sidechain_attack,
		sidechain_release: ~sidechain_release,
		out: ~out])
}, {~sidechain.notNil}); // play effect only if tape value was given

~busses = ~dirt.orbits.collect { |x| x.dryBus };
);

(

SynthDef("sidechain" ++ ~dirt.numChannels, {
	|out, sidechain=0, sidechain_thresh=(1/100), sidechain_compression=0.001, sidechain_attack=0.01 , sidechain_release=0.7|

	var in = In.ar(out, ~dirt.numChannels); // signal for orbit where sidechain is applied

	var sidechain_bus = Select.kr(sidechain, ~busses);
	var sidechain_signal = InFeedback.ar(sidechain_bus, ~dirt.numChannels); // signal sidechained against

	// here you get the signals directly from the node proxies, not over audio channels... easier to read
	var new_signal = Compander.ar(
		in,
		sidechain_signal,
		sidechain_thresh,
		1,
		sidechain_compression,
		sidechain_attack,
		sidechain_release
	);

	ReplaceOut.ar(out, new_signal);

}).add;
)


// NEED TO EVAL IN TIDALCYCLES:

/*
sidechain = pI "sidechain"
sidechain_thresh = pF "sidechain_thresh"
sidechain_compression = pF "sidechain_compression"
sidechain_attack = pF "sidechain_attack"
sidechain_release = pF "sidechain_release"
*/


