	// but works reasonably well for values between 0.1 and 3, depending on the sample
(

    var numChannels = ~dirt.numChannels;

	(1..SuperDirt.maxSampleNumChannels).do { |sampleNumChannels|

		var name = format("dirt_sample_%_%", sampleNumChannels, numChannels);

		SynthDef(name, { |out, bufnum, sustain = 1, begin = 0, end = 1, speed = 1, speed2 = 1, endSpeed = 1, freq = 440, pan = 0, timescale = 1, timescalewin = 1|

			var sound, rate, phase, sawrate, numFrames, index, windowIndex, window, timescaleStep;
			var sound0, sound1, windowSize, nSteps;

			// playback speed
			rate = Line.kr(0.2, endSpeed, sustain) * (freq / 60.midicps);

			// sample phase
			// BufSampleRate adjusts the rate if the sound file doesn't have the same rate as the soundcard
			//phase =  Sweep.ar(1, rate * BufSampleRate.ir(bufnum)) + (BufFrames.ir(bufnum) * begin);

			numFrames = BufFrames.ir(bufnum);
			// Picking the right window size is a tricky thing, something around 2000 samples is usually
			// OK for sounds of moderate length (around 0.5 to several seconds long).
			// But this is also scaled below to be a bit smaller/larger based on desired playback rate.
			// If it's still not good, you can use the "timescalewin" parameter to multiply the window size
			windowSize = timescale.clip(0.1,2) * 0.05 * BufSampleRate.ir(bufnum) * timescalewin;
			// Next is the (pre-scaled) number of samples between indices. Note that while windowSize
			// is clipped, timescaleStep cannot be without the duration of the resulting sound becoming
			// different from timescale * sample_duration.
			// For very small values of timescale, this means it'll "skip" through the sound, only playing
			// a few samples at regular intervals
			// For very large values of timescale, the overlap will be very large, possibly leading to
			// some audible repetition
			timescaleStep = windowSize / timescale;
			sawrate = rate * BufSampleRate.ir(bufnum) / (absdif(begin, end) * timescale * numFrames);
			phase = (speed.sign * LFSaw.ar(sawrate, 1)).range(begin,end) * numFrames * timescale;
			// do the overlap-add by running through a pair of indices, shifting weights with the window function
			nSteps = phase.div(timescaleStep) - [1.0, 0.0];
			index = nSteps * (timescaleStep / timescale - timescaleStep) + phase;
			windowIndex = phase - (nSteps * timescaleStep);
			// Gaussian window, the "50" means it's about 3.5 sigma to the edge of the window
			window = exp(-50 * squared(windowIndex/windowSize - 0.5));

			sound0 = window[0] * BufRd.ar(
				numChannels: sampleNumChannels,
				bufnum: bufnum,
				phase: index[0],
				loop: 0,
				interpolation: 4 // cubic interpolation
			);
			sound1 = window[1] * BufRd.ar(
				numChannels: sampleNumChannels,
				bufnum: bufnum,
				phase: index[1],
				loop: 0,
				interpolation: 4 // cubic interpolation
			);
			sound = (sound0 + sound1) / window.sum;

			sound = DirtPan.ar(sound, numChannels, pan);

			Out.ar(out, sound)
		}, [\ir, \ir, \ir, \ir, \ir, \ir, \ir, \ir, \kr, \ir, \ir]).add;
	};
)