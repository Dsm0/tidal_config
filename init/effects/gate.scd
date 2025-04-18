(
~dirt.addModule("gate", { |dirtEvent|
	dirtEvent.sendSynth("gate" ++ ~dirt.numChannels,
		[
			gate: ~gate,
			gateAtk: ~gateAtk,
			gateRel: ~gateRel,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~gate.notNil });
);

(
SynthDef("gate" ++ ~dirt.numChannels, { |out, gate = 0.2, gateAtk = 0.8, gateRel = 0.9, sustain|
	var signal, sum, amplitude, smoothedGate, gateThresh;
	//
	// gateThresh = if(0.0.equalWithPrecision(gateThresh, 0.0001), 0.2, gateThresh);
	gateAtk = if(0.0.equalWithPrecision(gateAtk, 0.0001), 0.1, gateAtk);
	gateRel = if(0.0.equalWithPrecision(gateRel, 0.0001), 0.9, gateRel);

	signal = In.ar(out, ~dirt.numChannels);
	sum = Mix.ar(signal);
	amplitude = Amplitude.ar(sum, 0.01, 0.01); // Fast amplitude tracking
	gateThresh = (amplitude > (gate/10.0)); // Binary gate
	smoothedGate = LagUD.ar(gateThresh, gateAtk, gateRel); // Smooth transitions
	signal = signal * smoothedGate; // Apply gate
	ReplaceOut.ar(out, signal);
}).add;
)

