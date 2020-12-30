(
SynthDef.new(\fm, {
	arg carHz=500, modHz=100, modAmp=200,
	atk=0.01, rel=1, amp=0.2, pan=0;
	var car, mod, env;
	env = EnvGen.kr(Env.perc(atk, rel), doneAction:2);
	mod = SinOsc.ar(modHz, mul:modAmp);
	car = SinOsc.ar(carHz + mod) * env * amp;
	car = Pan2.ar(car, pan);
	Out.ar(0, car);
},
metadata: (
	credit: "Eli Fieldsteel",
	category: \synth,
	tags: [\pitched, \fm, \sos]
)
).add;
)

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