
(
    SynthDef("sweeps", {
        |out=0,freq=440,sustain=1,release=0.1,pan=0,begin=0,end=1,speed=1,accelerate=0,osctype=0|
        var env,line,sig;

        env = Env.perc(attackTime: 0.01, releaseTime: release).ar(doneAction: Done.freeSelf);
        freq = freq * speed * Line.kr(1, 1+accelerate, sustain, doneAction: Done.freeSelf);

        sig = Select.ar(osctype, [SinOsc.ar(freq, 0, 0.1), LFSaw.ar(freq, 0, 0.1), LFPulse.ar(freq, 0, 0.1)]) * env;

        Out.ar(out, DirtPan.ar(sig , ~dirt.numChannels, pan));
    }).add
)