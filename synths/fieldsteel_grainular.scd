
// if you want to use buffers already loaded in superdirt, you need to figure out how to split a stereo buffer into 2 mono buffers
// might be hard to resolve, considering the buffer data is interleaved
// so either you'd have to pull some tricks with how the data is read in real time,
// or have to allocate a new buffer every time a sample not already in mono form is passed to the synth

// which is not ideal...
// maybe look into multi-channel granular Synths in supercollider
// they probably exist



// ~dirt.buffers.at(\contort)[0]

buf = 

(
SynthDef.new(\gs, {
	arg sync=1, dens=20, baseDur=0.1, durRand=1, buf=0,
	rate=1, pos=0, posSpeed=1, posRand=0,
	grainEnv=(-1), pan=0, panHz=0.1, panRand=0,
	atk=1, sus=2, rel=1, c0=1, c1=(-1), amp=1, out=0;

	var sig, env, densCtrl, durCtrl, posCtrl, panCtrl;

	env = EnvGen.ar(Env.new([0,1,1,0],[atk,sus,rel],[c0,0,c1]),doneAction:2);

	densCtrl = Select.ar(sync, [Dust.ar(dens), Impulse.ar(dens)]);

	durCtrl = baseDur * LFNoise1.kr(100).exprange(1/durRand,durRand);

	posCtrl = Phasor.ar(0, posSpeed * BufRateScale.ir(buf), 0, BufSamples.ir(buf)-1);
	posCtrl = posCtrl + LFNoise1.kr(100).bipolar(posRand*SampleRate.ir);
	posCtrl = posCtrl / BufSamples.ir(buf);
	posCtrl = posCtrl + pos;

	panCtrl = pan + LFNoise1.kr(panHz).bipolar(panRand);

	sig = GrainBuf.ar(
		2,
		densCtrl,
		durCtrl,
		buf,
		rate,
		posCtrl,
		2,
		panCtrl,
		grainEnv
	);

	sig = sig * env * amp;

	OffsetOut.ar(out, DirtPan.ar((sig * (1/12)) * 4.dbamp, ~dirt.numChannels, pan, env));
}).add;
)






// example soundscape
// ~r0 = Routine.new({
// 	loop{
// 		(1..8).choose.do({
// 			var rate = [0,2,3,7,9,10].choose + 70;
// 			rate = rate.midicps * [2,1,0.5,0.25].choose;
// 			4.do({
// 				Synth.new(\gs, [
// 					\buf, b,
// 					\sync, 1,
// 					\dens, rate * rrand(-0.15,0.15).midiratio,
// 					\baseDur, 0.02,
// 					\pos, [0.3, 0.4, 0.5, 0.6].choose,
// 					\posSpeed, 0,
// 					\amp, exprand(0.05,0.15),
// 					\atk, exprand(1,4),
// 					\sus, 0,
// 					\rel, exprand(3,6),
// 					\pan, rrand(-0.8,0.8),
// 				]);
// 			});
// 			exprand(0.1,8).wait;
// 		});
// 	};
// }).play;

// ~r1 = Routine.new({
// 	loop{
// 		(2..5).do({
// 			Synth.new(\gs, [
// 				\buf, b,
// 				\sync, 1,
// 				\dens, [0.25,0.5,1,2,4,8].choose,
// 				\baseDur, exprand(0.001,0.025),
// 				\pos, [0.1, 0.206, 0.398, 0.877].choose,
// 				\posSpeed, 0,
// 				\rate, [-2,0,12].choose.midiratio,
// 				\panHz, exprand(0.1,1),
// 				\panRand, 0.8,
// 				\atk, 3, \sus, 1, \rel, 3,
// 				\amp, exprand(0.25,0.6),
// 			]);
// 		});
// 		exprand(0.5,4).round(0.5).wait;
// 	};
// }).play;

