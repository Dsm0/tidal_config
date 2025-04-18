
~dirt.addModule("foaRotate", { |dirtEvent|
    dirtEvent.sendSynth("foaRotate" ++ ~dirt.numChannels,
        [
            foaRotate: ~foaRotate,
            out: ~out
        ])
}, { ~foaRotate.notNil});

SynthDef("foaRotate" ++ ~dirt.numChannels, { 
    |out, foaRotate=0.1|
    var in, sig;

    in = In.ar(out, 2); // Assuming stereo input

    sig = FoaTransform.ar(in, 'rotate', (foaRotate*360.0).degrad);

    Out.ar(out, sig);
}).add;





~dirt.addModule("foaTilt", { |dirtEvent|
    dirtEvent.sendSynth("foaTilt" ++ ~dirt.numChannels,
        [
            foaTilt: ~foaTilt,
            out: ~out
        ])
}, { ~foaTilt.notNil});

SynthDef("foaTilt" ++ ~dirt.numChannels, { 
    |out, foaTilt=0.1|
    var in, sig;

    in = In.ar(out, 2); // Assuming stereo input

    sig = FoaTransform.ar(in, 'tilt', (foaTilt*360.0).degrad);

    Out.ar(out, sig);
}).add;



~dirt.addModule("foaTumble", { |dirtEvent|
    dirtEvent.sendSynth("foaTumble" ++ ~dirt.numChannels,
        [
            foaTumble: ~foaTumble,
            out: ~out
        ])
}, { ~foaTumble.notNil});

SynthDef("foaTumble" ++ ~dirt.numChannels, { 
    |out, foaTumble=0.1|
    var in, sig;

    in = In.ar(out, 2); // Assuming stereo input

    sig = FoaTransform.ar(in, 'tumble', (foaTumble*360.0).degrad);

    Out.ar(out, sig);
}).add;





















// ------------------------------------------------------------
// Binaural (CIPIC) decoder
//
// mono pink noise source
// omni encoder


(
// define encoder / decoder matrices
                                        // free below...

SynthDef("foaPush" ++ ~dirt.numChannels, {
    |out, foaPush=0.1, foaAzim=0.1, foaAngle=0.1|
    var sig, in;// audio signal
    var angle, azim;




    // display encoder and decoder
    // "Ambisonic encoding via % encoder".format(~encoder.kind).postln;
    // "Ambisonic decoding via % decoder".format(~decoder.kind).postln;


    // angle ---> top         = push to plane wave
    //            bottom        = omni-directional
    // angle = MouseY.kr(pi/2, 0);
    angle = foaAngle;
    // angle = 0.8;

    // angle = 0.8;

    // azimuth -> hard left     = back
    //          centre     = centre
    //          hard right     = back
    // azim = MouseX.kr(pi, -pi);
    azim = foaAzim;


    // ------------------------------------------------------------
    // test sig
    in = In.ar(out, 2); // Assuming stereo input
    sig = in;
    // sig = sig[0];

    // sig = WhiteNoise.ar;
    // sig = sig * Env.perc(0.01, 1).kr(doneAction: 2);

    // ------------------------------------------------------------
    // encode
    sig = FoaEncode.ar(sig, ~encoderFoaPush);

    // ------------------------------------------------------------
    // transform
    sig = FoaTransform.ar(sig, 'push', angle, azim);


    // ------------------------------------------------------------
    // decode (to binaural)
    sig = FoaDecode.ar(sig, ~decoderFoaPush);

    // ReplaceOut.ar(out, XFade2.ar(in, sig, foaPush));
    sig = XFade2.ar(in, sig, (foaPush - 0.5)*2);
    ReplaceOut.ar(out, sig * foaPush);

}).add;

// ------------------------------------------------------------


~dirt.addModule("foaPush" + ~dirt.numChannels, { |dirtEvent|
    dirtEvent.sendSynth("foaPush" ++ ~dirt.numChannels)
}, { ~foaPush.notNil});

)