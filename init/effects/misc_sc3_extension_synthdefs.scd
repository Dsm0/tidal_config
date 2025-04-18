
(

    SynthDef(\misc_sc3_extension, { |out, in, mix = 0.5, amp = 1, pan = 0|
        var sig = In.ar(in, ~dirt.numChannels);
        sig = sig * amp;
        sig = sig * mix;
        sig = sig * EnvGen.kr(Env.asr, gate, doneAction:2);
        Out.ar(out, sig);
    }).add;
)





(
{
    var sig;                            // audio signal
    var azim;                           // azimuth control


    // display transformer & decoder
    "Ambisonic transforming via % transformer".format(~transformer).postln;
    "Ambisonic decoding via % decoder".format(~decoder.kind).postln;

    // azimuth -> hard left     = back
    //            centre        = centre
    //            hard right    = back
    azim = MouseX.kr(pi, -pi);


    // ------------------------------------------------------------
    // test sig
    sig = PlayBuf.ar(~sndbuf.numChannels, ~sndbuf, BufRateScale.kr(~sndbuf), doneAction:2);   // soundfile

    // ------------------------------------------------------------
    // transform
    sig = FoaTransform.ar(sig, ~transformer, azim);


    // ------------------------------------------------------------
    // decode (via ~renderDecode)
    ~renderDecode.value(sig, ~decoder)

}.scope;
)


Help.gui







(
~dirt.addModule("transform", { |dirtEvent|
    dirtEvent.sendSynth("transform" ++ ~dirt.numChannels,
        [
            transformer: ~transformer,
            out: ~out
        ])
}, { ~transformer.notNil});
);


(

SynthDef("transform" ++ ~dirt.numChannels, { 
    |out, transformer=0.1, azimuth=0.1|
    var in, sig, sig2;
    in = In.ar(out, 2); // Assuming stereo input

    sig = in;

    sig = FoaTransform.ar(sig, 'rotate', azimuth);

    sig = XFade2.ar(in, sig, (transformer - 0.5)*2);

    ReplaceOut.ar(out, sig);
}).add;
)


(
~dirt.addModule("rotate", { |dirtEvent|
    dirtEvent.sendSynth("rotate" ++ ~dirt.numChannels,
        [
            angle: ~angle,
            out: ~out
        ])
}, { ~angle.notNil});
);

(
SynthDef("rotate" ++ ~dirt.numChannels, { 
    |out, angle=0.1|
    var in, sig;

    in = In.ar(out, 2); // Assuming stereo input

    sig = FoaTransform.ar(in, 'rotate', angle);

    ReplaceOut.ar(out, sig);
}).add;
)







SynthDef("rotate" ++ ~dirt.numChannels, { 
    |out, angle=0.1, point_x=1, point_y=1, elevation=0, wComp=0, rotate=0.0|
    var in, sig, sig2, bsig;
    var w,x,y,z;
    var left_sig,right_sig;

    var w_left,x_left,y_left,z_left;
    var w_right,x_right,y_right,z_right;

    var leftChan,rightChan;

    in = In.ar(out, 2); // Assuming stereo input

    leftChan = in[0];
    rightChan = in[1];

    // in = PinkNoise.ar;
    #w_left, x_left, y_left, z_left = BFEncode2.ar(leftChan, point_x, point_y, elevation, gain: 1, wComp: wComp);
    #w_right, x_right, y_right, z_right = BFEncode2.ar(rightChan, point_x, point_y, elevation, gain: 1, wComp: wComp);



    left_sig = BFDecode1.ar(w_left,x_left,y_left,z_left,
        [-0.25pi, 0.25pi, 0.75pi, 1.25pi,-0.25pi, 0.25pi, 0.75pi, 1.25pi],
        [0.25pi,0.25pi,0.25pi,0.25pi,-0.25pi,-0.25pi,-0.25pi,-0.25pi,]
    );

    right_sig = BFDecode1.ar(w_right,x_right,y_right,z_right,
        [-0.25pi, 0.25pi, 0.75pi, 1.25pi,-0.25pi, 0.25pi, 0.75pi, 1.25pi],
        [0.25pi,0.25pi,0.25pi,0.25pi,-0.25pi,-0.25pi,-0.25pi,-0.25pi,]
    );

    // sig = 0.0 ! 2;

    ReplaceOut.ar(out, [left_sig,right_sig]);
}).add;
)


Help.gui

FoaTransform

Quarks.gui


(
LanguageConfig.includePaths.do{ |path|
    path.postln;
};
)


Post << LanguageConfig.includePaths


(
LanguageConfig.includePaths.do({|dev|
  dev.postln;
});
)





Quarks.install("atk-sc3");
Quarks.install("https://github.com/ambisonictoolkit/atk-sc3.git");


Platform.configDir





(
SynthDef("glitchDelay" ++ ~dirt.numChannels, {
    |out=0, glitchDelayTime=0.25, glitchDelayFreeze=0, glitchDelayStutter=5, glitchDelay=0.7|
    var sig, buf, ptr, del, mix;

    mix = glitchDelay;

    sig = In.ar(out, 2);

    ptr = Phasor.ar(0, BufRateScale.kr(buf) * (1 - glitchDelayFreeze), 0, BufFrames.kr(buf));
    BufWr.ar(sig, buf, ptr);
    del = BufRd.ar(2, buf, Demand.ar(Impulse.ar(glitchDelayStutter), 0, Dseries(0, 1, inf)) * 0.6);
    sig = XFade2.ar(sig, del, mix * 2 - 1);

    ReplaceOut.ar(out, sig);
}).add;

~dirt.addModule("glitchDelay", { |dirtEvent|
	dirtEvent.sendSynth("glitchDelay" ++ ~dirt.numChannels,
		[
            glitchDelayTime: ~glitchDelayTime,
			glitchDelayFreeze: ~glitchDelayFreeze,
			glitchDelayStutter: ~glitchDelayStutter,
			glitchDelay: ~glitchDelay,
			out: ~out
		]
	)
}, { ~glitchDelay.notNil });


)




(
SynthDef("gate" ++ ~dirt.numChannels, { |out, gate = 0.2, gateAtk = 0.8, gateRel = 0.9, sustain|
	var signal, sum, amplitude, smoothedGate, gateThresh;
	//
	// gateThresh = if(0.0.equalWithPrecision(gateThresh, 0.0001), 0.2, gateThresh);
	gateAtk = if(0.0.equalWithPrecision(gateAtk, 0.0001), 0.1, gateAtk);
	gateRel = if(0.0.equalWithPrecision(gateRel, 0.0001), 0.9, gateRel);

	signal = In.ar(out, ~dirt.numChannels);
	sum = Mix.ar(signal);
	amplitude = Amplitude.ar(sum, 0.01, 0.01); // Fast amplitude tracking
	gateThresh = (amplitude > (gate/10.0)); // Binary gate
	smoothedGate = LagUD.ar(gateThresh, gateAtk, gateRel); // Smooth transitions
	signal = signal * smoothedGate; // Apply gate
	ReplaceOut.ar(out, signal);
}).add;
)









(
    SynthDef("spectralMorph" ++ ~dirt.numChannels, { 
        |out, spectralMorphShift=1, spectralMorphStretch=2, spectralMorphBlend=0.7, spectralMorphPan=0, spectralMorphAmp=1|
    var input, chain, output, chainL, chainR;
    input = In.ar(out, 2);

    chainL = FFT(LocalBuf(2048), input[0]);
    chainR = FFT(LocalBuf(2048), input[1]);

    chainL = PV_BinShift(chainL, spectralMorphShift, spectralMorphStretch);
    chainR = PV_BinShift(chainR, spectralMorphShift, spectralMorphStretch);

    chainL = IFFT(chainL) * 0.7;
    chainR = IFFT(chainR) * 0.7;

    chain = [chainL, chainR];
    output = (input * (1 - spectralMorphBlend)) + (chain * spectralMorphBlend) * spectralMorphAmp;
    ReplaceOut.ar(out, Pan2.ar(output, spectralMorphPan));
}).add;



~dirt.addModule("spectralMorph", { |dirtEvent|
    dirtEvent.sendSynth("spectralMorph" ++ ~dirt.numChannels,
        [
            spectralMorphShift: ~spectralMorphShift,
            spectralMorphStretch: ~spectralMorphStretch,
            spectralMorphBlend: ~spectralMorphBlend,
            spectralMorphPan: ~spectralMorphPan,
            spectralMorphAmp: ~spectralMorphAmp,
            out: ~out
        ]
    )
}, { ~spectralMorph.notNil });

)












Help.gui