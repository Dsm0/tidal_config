(
~dirt.addModule("chorus", { |dirtEvent|
    dirtEvent.sendSynth("chorus" ++ ~dirt.numChannels,
        [
            chorusrate: ~chorusrate,
            chorusdepth: ~chorusdepth,
            chorusdelay: ~chorusdelay,
            chorusmix: ~chorusmix,
            sustain: ~sustain,
            out: ~out
        ])
}, { ~chorusmix.notNil});
);


(
SynthDef("chorus" ++ ~dirt.numChannels, { 
    |out, chorusrate=0.7, chorusdepth=0.5, chorusdelay=0.1, chorusmix=0.5|
    var in, sig, sig2;
    in = In.ar(out, 2); // Assuming stereo input

    sig = in;
    sig2 = DelayC.ar(in, 0.4, SinOsc.kr(chorusrate, chorusdelay, chorusdepth*0.01, 0.0));

    sig = (sig+sig2)/2.0;

    sig = XFade2.ar(in, sig, (chorusmix - 0.5)*2);

    ReplaceOut.ar(out, sig);
}).add;
)