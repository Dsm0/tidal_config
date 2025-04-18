(
var numChannels =  ~dirt.numChannels;
// SuperDirt.maxSampleNumChannels is just 2 channels lol
(1..SuperDirt.maxSampleNumChannels).do { |numChannels|
	SynthDef("grey_h" ++ numChannels, { |dryBus, effectBus, gdelay = 1, gdamp = 0.5, gsize = 0.5 gdiff = 0.5, gfdbk = 0.5, gdepth = 0, gfreq = 0, gverb = 0|
    var signal = In.ar(dryBus, ~dirt.numChannels);
	var verbd = Greyhole.ar(
			signal,
			gdelay,
			gdamp,
			gsize,
			gdiff,
			gfdbk,
			gdepth,
			gfreq,
    ) * gverb;
    Out.ar(effectBus, verbd);
  }, [\ir, \ir]).add;
}
)

(
~dirt.orbits.do { |x|
 var grh = GlobalDirtEffect(\grey_h, [\gdelay, \gdamp, \gsize, \gdiff, \gfdbk, \gdepth, \gfreq, \gverb]);
        x.globalEffects = x.globalEffects
              .addFirst(grh);
        x.initNodeTree;
    };
)


/*
let gverb = pF "gverb" -- dry/wet (0-1)
    gdelay = pF "gdelay" -- approximate reverberation time in seconds (0.1 - 60 sec)
    gdamp = pF "gdamp" -- controls damping of high-frequencies as the reverb decays. 0 is no damping, 1 is very strong damping. Values should be between (0..1). argumentsize scales size of delay-lines within the diffusion unit, producing the impression of a larger or smaller space. Values below 1 can sound metallic. Values should be between (0.5..5).
    gsize = pF "gsize" -- 
    gdiff = pF "gdiff" -- controls pattern of echoes produced by the diffuser. At very low values, the diffuser acts like a delay-line whose length is controlled by the 'size' parameter. Medium values produce a slow build-up of echoes, giving the sound a reversed-like quality. Values of 0.707 or greater than produce smooth exponentially decaying echoes. Values should be in the range (0..1).
    gfdbk = pF "gfdbk" -- amount of feedback through the system. Sets the number of repeating echoes. A setting of 1.0 produces infinite sustain. Values should be in the range (0..1)
    gdepth = pF "gdepth" -- depth (0..1) of delay-line modulation. Use in combination with modFreq to produce chorus and pitch-variations in the echoes.
    gfreq = pF "gfreq" -- frequency (0..10 Hz) of delay-line modulation. Use in combination with modDepth to produce chorus and pitch-variations in the echoes.
*/