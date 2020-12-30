(SynthDef(\testSynth , {
  arg out, pan, freq = 405, voice = 0.385, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5, attack = 0.005;
  var source, noise, envelope;

  source = PMOsc.ar(Saw.ar(freq * 0.85), freq * semitone, voice);

	noise = Latch.ar(WhiteNoise.ar(0.1), Impulse.ar(1700 * 2));
	noise = BRF.ar(noise, 4 * pitch1, resonance, 0.5);
	noise = BRF.ar(noise, 2.5 * pitch1, resonance, 0.5);
	noise = BRF.ar(noise, 1.8 * pitch1, resonance, 0.5);
	noise = BRF.ar(noise, pitch1*2, resonance, Env.perc(0.005, sustain, -4).ar);
	// noise = BRF.ar(noise, Sweep.ar(1).linlin(0, 1, 0.2, 3, \minmax);
	// , resonance, Env.perc(0.005, sustain, -4).ar);
	noise = Resonz.ar(noise, pitch1, 1, 10);

  envelope = Env.perc(attack, sustain, 0.5, -4).ar(Done.freeSelf);

  OffsetOut.ar(out, DirtPan.ar((source + noise) * 4.dbamp, ~dirt.numChannels, pan, envelope));
},
metadata: (
  credit: "Renick Bell",
  category: \drums,
  tags: [\pitched, \snare, \sos]
)).add;
);


(SynthDef(\testSynth2 , {
  arg out, pan, freq = 405, voice = 0.385, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5;
  var source, noise, envelope;

  source = PMOsc.ar(Saw.ar(freq * 0.85), freq * semitone, voice);

  noise = Latch.ar(WhiteNoise.ar(0.1), Impulse.ar(1700*4));
	noise = BRF.ar(noise, 4 * pitch1, resonance, 0.5);
  noise = BRF.ar(noise, 2.5 * pitch1, resonance, 0.5);
	// noise = BLowPass.ar(noise, pitch1, resonance, 0.7);
	// noise = BRF.ar(noise, pitch1, resonance, Env.perc(0.005, sustain, -4).ar);
  noise = Resonz.ar(noise, pitch1, 1, 40);

  envelope = Env.perc(0.005, sustain, 0.5, -4).ar(Done.freeSelf);

  OffsetOut.ar(out, DirtPan.ar((source + noise) * 4.dbamp, ~dirt.numChannels, pan, envelope));
},
metadata: (
	credit: "Renick Bell",
	category: \drums,
	tags: [\pitched, \snare, \sos]
)).add;
);