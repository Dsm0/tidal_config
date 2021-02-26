(

~dirt.addModule('comb_delay', { |dirtEvent|
		dirtEvent.sendSynth('comb_delay' ++ ~dirt.numChannels
		)
	}, { ~comb_delay.notNil });
)

(
	SynthDef("comb_delay" ++ ~dirt.numChannels, { |out,comb_delay=0.5,decaytime=0.1,decaysus=0.1|
    var og_sig = In.ar(out, ~dirt.numChannels);
	var sig = CombC.ar(Decay.ar(og_sig, 0.001 + (0.001*comb_delay), WhiteNoise.ar), 0.0, decaytime, decaysus);
	sig = (og_sig * (1.0 - comb_delay*0.5)) + (sig * (comb_delay*0.7));
	ReplaceOut.ar(out, sig);
	},[\ir]).add;
)

~dirt.modules