(

SynthDef(\noodles, {
    var sig;
    var freq = \freq.kr(440);
    var dur = \dur.kr(1);
    var amp = \amp.kr(0.1);
    var weirdEnv = EnvGen.kr(
        Env(
            levels: [0, 0.1, 0.2, 0.3],
            times: [0.1, 0.1, 0.1],
            curve: 8
        ),
        gate: Impulse.kr(3)
    );
    sig = SinOsc.ar(XLine.kr(freq, freq * env, dur), 0, amp);
    sig = sig * Env.perc(0.01, 0.4).ar(doneAction: 2);
    Out.ar(\out.kr(0), sig);
}).add;

Synth(\noodles);
)


Env.perc(Poll.kr(SinOsc.ar(100), 0.004), 0.8).plot;

Synth(\noodles);
Help.gui;