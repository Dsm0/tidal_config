(
SynthDef(\theramin, {
	arg out, pan, freq = 440, rise = 10, voice = 0.385, semitone = 0.452, pitch1 = 2000, resonance = 0.3, sustain = 0.5, fb_amp = 4;

	var trigs;
	trigs = Dust.kr(170);
	freq =
		// Generally choose from a varied base freq
		TExpRand.kr(freq, freq+5, trigs)
		// Wobbly variation
		+ LFNoise2.kr(5, mul: 10)
		// General tendency for upward rise
		+ EnvGen.kr(Env.perc(1).range(0,rise), trigs)
		;
	freq = SinOsc.ar(freq, 0, 0.3);

	OffsetOut.ar(out, DirtPan.ar((freq) * 4.dbamp, ~dirt.numChannels, pan));
},
metadata: (
  credit: "C_ROBO",
  category: \soundfx,
  tags: [\soundfx, \misc]
)
).add;
)


(
x = {

}.play;
)

x.free;
