(
// NOTE:
// DO NOT USE:
// HAS MAJOR CLIPPING ISSUES

// UPDATE: it's good now
// I changed the 'interp: 4' argument to 'interp: 1' when declaring the type of interpolation to use
// went from cubic to linear
// My guess is that the popping was because sc couldn't calculate interpolations fast enough to send samples on time
// so occasionally, samples would be dropped -> no data -> clip


SynthDef(\beam, {
	arg out, pan, freq = 467.1, voice = 0.385, semitone = 0.452, pitch1 = 1000, resonance = 0.1, sustain = 0.5, fb_amp = 4;
	var beam_envelope, phasor, beam, feedback, transporter, reverb, activateEnv, percEnv, activate, buffer;

	buffer = LocalBuf(SampleRate.ir * 0.12);

	// feedback has to be 0 at the beginning, to avoid input
	// nil before sound has been produced
	feedback = 0;


	// Activate Sound (fig 56.3)

	activateEnv = EnvGen.ar(Env.new([0, 1, 1, 0], [0.01, 0.01, 5]));
	percEnv = EnvGen.ar(Env.new([1, 1, 0], [0.01, 0.12]));

	activate = (1 - activateEnv * 120 * freq) + (WhiteNoise.ar(0.1) + SinOsc.ar(30, mul:40));
	activate = OnePole.ar(activateEnv, exp(-2pi * (30 * SampleDur.ir))) * LFSaw.ar(activate, 1, 0.5, 0.5 );

	// adding a percussive shape at the beginning of the sound
	activate = (activate + (WhiteNoise.ar * percEnv));

	activate = Clip.ar(activate, -1, 1);
	activate = BPF.ar(activate, [775,1550,2325], 13.reciprocal).sum * 0.5;



	// Beam Sound

	beam = LFSaw.ar(freq, 1, 0.5, 0.5 ) - 0.5;
	beam = beam - (Wrap.ar(beam) - 0.5);
	// two stage FM process
	phasor = LFSaw.ar( beam * 6500 + 277, 1, 0.5, 0.5) - 0.5;
	beam = beam * (phasor - (Wrap.ar(phasor) - 0.5));
	beam = DelTapWr.ar(buffer, beam + (feedback * 0.7));

	beam_envelope = Line.ar(0,0.9,sustain);

	// CLIPPING has something to do with feedback
	feedback = DelTapRd.ar(buffer, beam,
		          (1 - beam_envelope * fb_amp + 1
		          	// flanger effect w/ variable delays spaced 12ms apart [0,12,24]
		          	+ 12 * (0..2))
		          // DelTapRd requires delaytime in seconds (the equivalence in pd [vd~]
		          // calculates with miliseconds, for it the division by 1000)
	 	          / 1000,
		          interp: 1).sum * 0.3 * fb_amp;

	// feedback = 1; // safety line

	transporter = (beam_envelope * (-1) + 1).min(beam_envelope) * 4 * feedback;
	transporter = (transporter - OnePole.ar(transporter, exp(-2pi * (100 * SampleDur.ir))));
	transporter = BPF.ar(transporter,
		// whole tone scale
		Array.geom(12, 466.164, 1.12247),
		[1200, 1100, 930, 910, 880, 840, 800, 760, 720, 680, 640, 620].reciprocal* freq/440).sum * 12;
	reverb = GVerb.ar(transporter + (activate * 0.1), 100, 8, 0.1, 0.9);
	reverb = reverb + (activate * 0.5)!2;

    OffsetOut.ar(out, DirtPan.ar((reverb) * 4.dbamp, ~dirt.numChannels, pan));
},
metadata: (
  credit: "C_ROBO",
  category: \soundfx,
  tags: [\soundfx, \misc]
)
).add;
)