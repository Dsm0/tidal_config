(
SynthDef(\noodles, {
    var sig;
    var freq = \freq.kr(440);
    var dur = \dur.kr(1);
    var amp = \amp.kr(0.1);
    var freqEnv = EnvGen.kr(Env.perc(1.8, 8.1,0.1));
    sig = SinOsc.ar(freq * (1 + freqEnv), 0, amp);
    sig = sig * Env.perc(0.01, 8.1).ar(doneAction: 2);
    Out.ar(\out.kr(0), sig);
}).add;

Synth(\noodles);
)






(
synthdef(\noodles, {
    var sig;
    var freq = \freq.kr(440);
    var dur = \dur.kr(1);
    var amp = \amp.kr(0.1);
    var freqenv = envgen.kr(env.perc(\fattack.kr(0.1), \frelease.kr(0.8),0.01));
    sig = sinosc.ar(freq * (1 + freqenv), 0, amp);
    sig = sig * env.perc(\attack.kr(0.001), \release.kr(0.8)).ar(doneaction: 2);
    out.ar(\out.kr(0), sig);
}).add;

synth(\noodles,["freq", 440, "dur", 1, "amp", 0.1]);
)


(
SynthDef(\noodles, {
    var sig;
    var freq = \freq.kr(440);
    var dur = \dur.kr(1);
    var amp = \amp.kr(0.1);
    var freqEnv = Saw.kr([XLine.kr(10, 1, 1), XLine.kr(19, 30, 1)], Env.perc(0.001, 0.8, 0.1), 0.1);
    freqEnv = freqEnv.sum;
    sig = SinOsc.ar(freq * (1 + freqEnv), 0, amp);
    sig = sig * Env.perc(\attack.kr(0.001), \release.kr(0.8)).ar(doneAction: 2);
    sig = sig ! 2;
    // sig[1] = sig[1].lag(0.1);
    Out.ar(\out.kr(0), sig);
}).add;

Synth(\noodles,["freq", 440, "dur", 1, "amp", 0.1]);
)




Env.perc(Poll.kr(SinOsc.ar(100), 0.004), 0.8).plot;

Synth(\noodles);
Help.gui;