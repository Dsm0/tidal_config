(
SynthDef(\hoover, {
	arg out, pan, n, sustain = 0.5, attack = 0.005;
    var snd, freqsig, freq_, bw, envelope;

	freqsig = \freq.kr(440)!2;
    freqsig = freqsig * Env([-5, 6, 0], [0.1, 1.7], [\lin, -4]).kr.midiratio;
    bw = 1.035;
	snd = { DelayN.ar(Saw.ar(freqsig * ExpRand(bw, 1 / bw)) + Saw.ar(freqsig * 0.5 * ExpRand(bw, 1 / bw)), 0.01, Rand(0, 0.01)) }.dup(20);
    snd = (Splay.ar(snd) * 3).atan;
    snd = snd * Env.asr(0.01, 1.0, 1.0).kr(0, \gate.kr(1));
    snd = FreeVerb2.ar(snd[0], snd[1], 0.3, 0.9);
    snd = snd * Env.asr(0, 1.0, 4, 6).kr(2, \gate.kr(1));

	envelope = Env.perc(attack, sustain, curve: -1).ar;

	// Out.ar(\out.kr(0), snd * \amp.kr(0.1));
	OffsetOut.ar(out, DirtPan.ar(snd * 0.1 * 4.dbamp, ~dirt.numChannels, pan, envelope));
},
metadata: (
  credit: "c_robo_",
  category: \soundfx,
  tags: [\hoover, \sos]
)).add;
)