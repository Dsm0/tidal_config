(
SynthDef(\kick, {
	arg out, pan, freq = 405, voice = 0.385, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5;

})

)




(
(
SynthDef(\Aj_RYcYKIqk,  {
	arg out, pan, freq = 405, voice = 0.385, speed = 1.0, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5;
	var snd, trig, baseFreq, env;


	baseFreq = freq * speed;

	trig = Dust.ar(16);
	snd = SinOsc.ar(TExpRand.ar(baseFreq,baseFreq*1.01,trig)) * TRand.ar(0,1,trig).lag(0.1);
	snd = SinOsc.ar(TExpRand.ar(baseFreq,baseFreq*1.01,trig) + snd);
	snd = PitchShift.ar(snd,0.003,TRand.ar(0.02,0.1,trig).lag(0.3));
	snd = snd ! 2;
	snd = snd * -6.dbamp;
	// Out.ar(\out.kr(0),snd);



	env = Env.perc(0.005, sustain, 0.5, -4).ar(Done.freeSelf);

	OffsetOut.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, env));
},
metadata: (
  credit: "Nathan Ho (c_ edit)",
  category: \soundfx,
  tags: [\beeping, \misc]
)).add;
).play;
)



(
SynthDef(\synth1, {
	arg out, pan;
}).add;

)




(
(
SynthDef(\Aj_RYcYKIqk_1,  {
	arg out, pan, freq = 405, voice = 0.385, speed = 1.0, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5;
	var snd, snd2, trig, baseFreq, env, vocoderFreqs;



	baseFreq = freq * speed;
	vocoderFreqs = (0..16).linexp(0,16,100,8000);

	trig = Dust.ar(4 ! 2);
	snd = SinOsc.ar(TExpRand.ar(100,4000,trig)) * TRand.ar(0,8000,trig).lag(0.3);
	snd = SinOsc.ar(TExpRand.ar(100,4000,trig) + snd);
	snd = PitchShift.ar(snd,0.03,TRand.ar(0.5,2,trig).lag(1.2));
	snd = (BPF.ar(snd[0],vocoderFreqs,0.3) * Amplitude.ar(BPF.ar(snd[1],vocoderFreqs,0.3), 0.01, 0.1)).sum;

	snd2 = LPF.ar(snd,TExpRand.ar(100,8000,trig),1.0);
	snd = DelayC.ar(snd,0.8,Env.perc(0.01,0.9,1.0,-0.1).ar(0, trig),1.0,snd2);

	snd = DelayN.ar(snd,0.8,Env.perc(0.01,TExpRand.ar(0.1,0.9,trig),1.0,-0.1).ar(0, trig),1.0,snd2);


	snd = snd ! 2;
	snd = snd * -6.dbamp;
	// Out.ar(\out.kr(0),snd);

	// env = Env.perc(0.005, sustain, 0.5, -4).ar(Done.freeSelf);

	OffsetOut.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, env));
},
metadata: (
  credit: "Nathan Ho (c_ edit)",
  category: \soundfx,
  tags: [\beeping, \misc]
)).add;
).play;
)




















