(

SynthDef(\acid, { |out, freq = 440, acid_gate = 1, attack = 0.01, sustain = 1, pan = 0.5, speed = 1, accelerate, offset, volume|
	// var amp, cutoff, resonance;
	// SynthDef(\acid, {
	// var out = \out.kr(0);
	// var sutain = \sustain.kr(1);
	// var pan = \pan.kr(0);
	// var accelerate = \accelerate.kr(0);
	// var freq = \freq.kr(440);
	var amp = \amp.kr(1) * (-12.dbamp);
	// var gate = \gate.kr(gate);
	var cutoff = \cutoff.kr(440);
	var resonance = \resonance.kr(0.3);

	var gate = acid_gate;

	// var gate = \gate.kr(1);
	// \gate.kr(gate);
	// var env1, env2, son, pitch;

	// var pitch = freq.cpsmidi;
	var pitch = Lag.kr(freq.cpsmidi, 0.12 * (1-Trig.kr(gate, 0.001)) * gate);
	var env1 = EnvGen.ar(Env.new([0, 1.0, 0, 0], [0.001, 2.0, 0.04], [0, -4, -4], 2), gate, amp, doneAction:2);
	var env2 = EnvGen.ar(Env.adsr(0.001, 0.8, 0, 0.8, 70, -4), gate);
	var son = LFPulse.ar(pitch.midicps, 0.0, 0.51, 2, -1);

	son = RLPF.ar(son, cutoff + env2.midicps, resonance);

	OffsetOut.ar(out, Pan2.ar(son * env1, pan));
	OffsetOut.ar(out,DirtPan.ar(son * env1, ~dirt.numChannels, pan))
}).add;

)
