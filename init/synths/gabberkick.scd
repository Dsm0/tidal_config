(
SynthDef(\gabbertouch, {
	arg out, pan, freq = 110, lfoMin = 0, lfoMax = 0.001;
	var snd, freqsig, high, lfo, envelope, sustain = 0.5, attack = 0.005;

    freqsig = \freqsig.kr(freqsig) * (
		Env.perc(attack, sustain, curve: -1).ar *
		 48 * \bend.kr(1)).midiratio;
    snd = Saw.ar(freq);
	snd = (snd * 100).tanh + ((snd.sign - snd) * -8.dbamp);
	high = HPF.ar(snd, 300);
	lfo = SinOsc.ar(8, [0, 0.5pi]).range(lfoMin, lfoMax);
	high = high.dup(2) + (DelayC.ar(high, 0.1, lfo) * -2.dbamp);
	snd = LPF.ar(snd, 300).dup(2) + high;
	snd = RLPF.ar(snd, 2000, 2);
	// snd = BPeakEQ.ar(snd, \ffreq.kr(3000) * XLine.kr(1, 0.8, 0.3), 0.5, 15);
	// snd = snd * Env.asr(0.001, 1, 0.05).ar(1, \gate.kr(1));

	envelope = Env.perc(0.1, 0.5, curve: -1).ar;

//    Out.ar(\out.kr(0), snd * \amp.kr(0.1));
	OffsetOut.ar(out, DirtPan.ar((snd * (1/12)) * 4.dbamp, ~dirt.numChannels, pan, envelope));
}).add;
)
