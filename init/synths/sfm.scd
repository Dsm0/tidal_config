// from devilfish707#9946

(
SynthDef(\sfm, { |out, freq = 440, index = 1, index2 = 0, detune = 0, attack = 0.01, release = 1, matt = 0.01, mrel = 1, unison = 0, pan, speed = 1, accelerate, offset, volume|
    var carenv, modenv, dry, uni, sound;
    modenv = EnvGen.ar(Env.perc(matt, mrel));
    carenv = EnvGen.ar(Env.perc(attack,release), doneAction:2);
	freq = freq * speed;
    dry = SinOsc.ar(freq, SinOsc.ar(freq* (1+detune), SinOsc.ar(freq,modenv,index2), index)*modenv);
    uni = Splay.arFill(5, {|i| SinOsc.ar(freq+rrand(i.neg*1.7,i*1.7), SinOsc.ar(freq* (1+detune), SinOsc.ar(freq,modenv,index2), index)*modenv)},1);
    sound = SelectX.ar(unison, [dry,uni]);
    OffsetOut.ar(out,DirtPan.ar(sound, ~dirt.numChannels, pan, carenv))
}).add;
)
