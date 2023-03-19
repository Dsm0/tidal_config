(
SynthDef(\fm_2, {
	arg out, freq=500, mRatio=1, cRatio=1,
	index=1, iScale=5, cAtk=4, cRel=(-4),
	amp=0.2, attack=0.01, release=3, pan=0;
	var car, mod, env, iEnv;
	iEnv = EnvGen.kr(
		Env(
			[index, index*iScale, index],
			[attack, release],
			[cAtk, cRel]
		)
	);
	env = EnvGen.kr(Env.perc(attack,release, curve:[cAtk,cRel]),doneAction:2);
	mod = SinOsc.ar(freq * mRatio, mul:freq * mRatio * iEnv);
	car = SinOsc.ar(freq * cRatio + mod) * amp;
	// car = Pan2.ar(car, pan);
	// Out.ar(0, car);

	OffsetOut.ar(out, DirtPan.ar((car * (1/12)) * 4.dbamp, ~dirt.numChannels, pan, env));
},
metadata: (
	credit: "Eli Fieldsteel",
	category: \synth,
	tags: [\pitched, \fm, \sos]
)
).add;
) //todo: address end-clipping


// example of some cool audio you can get with all but 1 random parameter


/*(
p = Pbind(
	\instrument, \fm,
	\dur, 1/8,
	\carHz, 440,
	\modHz, Pexprand(1, 40),
	\modAmp, Pwhite(0, 40),
	\amp, Pexprand(0.1, 0.5),
	\atk, Pexprand(0.001, 0.05),
	\rel, Pexprand(0.05, 1.2),
	\pan, Pwhite(-1.0, 1.0),
).play;
)

p.stop*/




// holy shit, you could literally just create synths as compositions of effects