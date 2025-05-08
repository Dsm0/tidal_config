var on, off, cc;
var osc;
ServerOptions

(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256 * 2; // increase this if you need to load more samples
s.options.memSize = 8192 * 32 * 2; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32 * 2; // increase this if you are getting drop outs and the message "too many nodes"

s.options.numOutputBusChannels = 64; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 64; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
// s.options.sampleRate = 44100;
s.waitForBoot {
	~dirt = SuperDirt(2, s); // twelve output channels, increase if you want to pan across more channels

    // You can adjust these parameter even in runtime

	/*
	~looper.rLevel = 1.5;
    ~looper.pLevel = 0.8;
    ~looper.linput = 15; // Set this to your main input port.
	~looper.lname = "mybuffer";
	*/

	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	// s.sync; // optionally: wait for samples to be read


	~dirt.start(57120,outBusses: (0..63).collect({|i| i*2}));   // start listening on port 57119, create two busses each sending audio to channel 0
	// Each orbit (d1-d8) is mapped to SC-1 thru SC-8 in bitwig.
	// the index values are incremented by 2 because each orbit takes 2 audio channels

	/* ~midiOut = MIDIOut.newByName("Virtual Raw MIDI 2-0", "VirMIDI 2-0"); */
	/* ~midiOut = MIDIOut.newByName("Virtual Raw MIDI 3-0", "VirMIDI 3-0"); */
	/* ~midiOut = MIDIOut.newByName("Virtual Raw MIDI 3-0", "VirMIDI 4-0"); */
	// figure out why it changes

	// ~dirt.soundLibrary.addMIDI(\midi, ~midiOut);
	~dirt.fileExtensions = ["wav","aif","aiff","aifc","ogg","mp3"];

    s.scope;
	"/Users/will/.config/tidal/init/active_scripts.scd".load;

	// // "/home/wil/.config/tidal/init/effects/sidechain.scd".load;

	// // "/home/wil/.config/tidal/init/effects/AnalogTape.scd".load;

	// // "/home/wil/.config/tidal/init/effects/multiband_comp.scd".load;


	// "/Users/will/.config/tidal/init/effects/sidechain.scd".load;

	// // "/home/wil/.config/tidal/init/effects/AnalogTape.scd".load;

	// // "/Users/will/.config/tidal/init/effects/multiband_comp.scd".load;
	// "/Users/will/.config/tidal/init/effects/multiband_comp.scd".load;


	// "/Users/will/.config/tidal/init/synths/superDirtControls.scd".load;
	// "SuperDirt OSC file reloading system initialized.".postln;



	// "/Users/will/.config/tidal/init/synths/mi-ugens.scd".load;
	// "loaded mi-ugens.scd".postln;

	// "/Users/will/.config/tidal/init/synths/gutter_synth.scd".load;
	// // "loaded gutter_synth.scd".postln;


	// "/Users/will/.config/tidal/init/effects/gate.scd".load;
	// "/Users/will/.config/tidal/init/effects/chorus.scd".load;
	// "/Users/will/.config/tidal/init/effects/foaTransforms.scd".load;

	// ~looper = TidalLooper(~dirt);

    // You can adjust these parameter even in runtime
	// ~looper.rLevel = 1.5;
	// ~looper.pLevel = 0.8;
	// ~looper.linput = 15; // Set this to your main input port.
	// ~looper.lname = "mybuffer";
	// 1~looper.persistPath = "~/Music/tidalLooper/";
//	SynthDef(\sy1, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy2, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy3, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy4, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy5, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy6, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy7, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy8, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	SynthDef(\sy9, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
//	~dirt.soundLibrary.addSynth(\sy1);
//	~dirt.soundLibrary.addSynth(\sy2);
//	~dirt.soundLibrary.addSynth(\sy3);
//	~dirt.soundLibrary.addSynth(\sy4);
//	~dirt.soundLibrary.addSynth(\sy5);
//	~dirt.soundLibrary.addSynth(\sy6);
//	~dirt.soundLibrary.addSynth(\sy7);
//	~dirt.soundLibrary.addSynth(\sy8);
//	~dirt.soundLibrary.addSynth(\sy9);
	// s.volume = (0);
//	~dirt.loadSoundFiles("/run/media/will/5EB068D0139EDA18/rap/*");
//	~dirt.loadSoundFiles("/run/media/will/5EB068D0139EDA18/songSamp/*");
//	~dirt.loadSoundFiles("/run/media/will/5EB068D0139EDA18/customSamples/*");
	//	~dirt.loadSoundFiles("/M/Documents/unsorted_wavsÓ");

	SynthDef(\foo1, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
	SynthDef(\foo2, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
	~dirt.soundLibrary.addSynth(\foo1);
	~dirt.soundLibrary.addSynth(\foo2);


	MIDIClient.init;
	~midiOut = MIDIOut.newByName("IAC Driver", "Tidal1");
	~midiOut.latency = 0.05;
	~dirt.soundLibrary.addMIDI(\midi, ~midiOut);


    Server.default.recChannels = 18;
	thisProcess.platform.recordingsDir = "~/Music/sc_recs/multitrack".standardizePath;
	"/Users/will/.config/tidal/init/synths/dx7_test.scd".load;


	// ~dirt.orbits.do { |x|
    //         var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
    //         var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
	// 	    var warps = GlobalDirtEffect(\warps, [\warpsalgo, \warpstimb, \warpsosc, \warpsfreq, \warpsvgain, \warpseasteregg, \out]);
	s.volume = (-11);
    //           .addFirst(clouds)
    //           .addFirst(verb)
	// 	       .addFirst(warps);
    //         x.initNodeTree;
	// };
	fork {
			~dirt.orbits.do { |x|
			            var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
			            var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
					    var warps = GlobalDirtEffect(\warps, [\warpsalgo, \warpstimb, \warpsosc, \warpsfreq, \warpsvgain, \warpseasteregg, \out]);
			            x.globalEffects = x.globalEffects
			              .addFirst(clouds)
			              .addFirst(verb)
					       .addFirst(warps);
			            x.initNodeTree;
				};

			SynthDef(\p, {|out, freq = 440, pan = 0, amp = 0.1|
			}).add;
	};


};

)


(
// reset fucked delay lines
~dirt.orbits.do { |x|
	x.initNodeTree;
};
"/Users/will/.config/tidal/init/synths/superDirtControls.scd".load;
);





(
	
			~dirt.orbits.do { |x|
			            var clouds = GlobalDirtEffect(\global_mi_clouds, [\cloudspitch, \cloudspos, \cloudssize, \cloudsdens, \cloudstex, \cloudswet, \cloudsgain, \cloudsspread, \cloudsrvb, \cloudsfb, \cloudsfreeze, \cloudsmode, \cloudslofi]);
			            var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
					    var warps = GlobalDirtEffect(\warps, [\warpsalgo, \warpstimb, \warpsosc, \warpsfreq, \warpsvgain, \warpseasteregg, \out]);
			            x.globalEffects = x.globalEffects
			              .addFirst(clouds)
			              .addFirst(verb)
					       .addFirst(warps);
			            x.initNodeTree;
				};
)






// "/home/ick/.config/tidal/init/pulu_clock.scd".load;





(
~dirt.orbits.do { |x|
            var rotate = GlobalDirtEffect(\rotate, [\angle]);
            // var verb = GlobalDirtEffect(\global_mi_verb, [\verbwet, \verbtime, \verbdamp, \verbhp, \verbfreeze, \verbdiff, \verbgain]);
		    // var warps = GlobalDirtEffect(\warps, [\warpsalgo, \warpstimb, \warpsosc, \warpsfreq, \warpsvgain, \warpseasteregg, \out]);
            x.globalEffects = x.globalEffects
		       .addFirst(rotate);
            x.initNodeTree;
	};
)





Platform.userExtensionDir.openOS;  


// Evaluate the block below to start the mapping MIDI -> OSC.

MIDIClient.init;
~midiOut = MIDIOut.newByName("IAC Driver", "Tidal1");
~dirt.soundLibrary.addMIDI(\midi, ~midiOut);


Server.default.recChannels = 16







s.volume = -11





// alex
// alex says:ah ok, didn't know that
// 11:54
// alex says:for non-global/orbit effects by default the effects chain goes
// vowel, shape, hpf, bpf, crush, coarse, lpf, pshift, envelope, grenvelo, tremolo, phaser, waveloss, squiz, fshift, triode, krush, octer, ring, distort, spectral-delay, spectral-freeze, spectral-comb, spectral-smear, spectral-scram, spectral-binshift, spectral-hbrick, spectral-lbrick, spectral-conformer, spectral-enhance, dj-filter


// global effects are defined in DirtOrbit.sc (in initDefaultGlobalEffects)




(
(
SynthDef(\synth1,  {
	arg out, pan, freq = 405, voice = 0.385, speed = 1.0, semitone = 0.452, pitch1 = 2000, resonance = 0.1, sustain = 0.5;
//	OffsetOut.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, env));
},
metadata: (
  credit: "Nathan Ho (c_ edit)",
  category: \soundfx,
  tags: [\beeping, \misc]
)).add;
).play;
)






// NOTE: you can redefine effects order with ~dirt.orderModules()
https://club.tidalcycles.org/t/effects-after-reverb/1315/15?u=yaxu

















.


Server.default.recChannels


s.recChannels = 16
s.recChannels

s.volume = 0


~dirt.loadSoundFiles("/home/ick/.BitwigStudio/installed-packages/1.0/samples/JoMoX/JoMoX X-Basics/111bpm_Machine_Loops");
/*
(

//MIDIIn.connectAll;

on = MIDIFunc.noteOn({ |val, num, chan, src|

osc.sendMsg("/ctrl", "n", num); // if I remember correctly this was the bit I changed to get notes in!

});

off = MIDIFunc.noteOff({ |val, num, chan, src|
osc.sendMsg("/ctrl", "n", 0);
});

cc = MIDIFunc.cc({ |val, num, chan, src|
osc.sendMsg("/ctrl", num.asString, val/127);

});

if (~stopMidiToOsc != nil, {
~stopMidiToOsc.value;
});

~stopMidiToOsc = {
on.free;
off.free;
cc.free;
};
);
include("TidalLooper")
*/

~looper.persistLoops()

s.volume = 0

(
~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/crazy_taxi/*");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/yourLoops");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/customSamples/*");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/*");

// WARNING: 92 files, takes up 1343mb, make sure you have enough mem. allocated
~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/fzerogx");


~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/tekken3");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/rap/cosmic_void_16");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/monacoGrandPrix");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/ridgeRacer");

~dirt.loadSoundFiles("/media/ick/5EB068D0139EDA18/tidalSamples/games/smb_step_and_roll/bgm_w4_s7");


~dirt.loadSoundFiles("/home/ick/Music/drumkits/glitchy_sauce");

~dirt.loadSoundFiles("/home/ick/Music/drumkits/glitchy_sauce");
)
s.latency = 0.3; //increase this if you get "late" messages
//dirt.startSendRMS






Quarks.openFolder

Help.gui


"/tmp/ha.scd".load;







"/home/wil/.config/tidal/init/synths/synth1.scd".load;

Help.gui



(
200.do{ |i|
	("/Users/will/gitStuff/DX7-P/analysis/DX7_" ++ i ++ ".scd").load;
	// ("/Users/will/gitStuff/DX7-P/analysis/DX7_1.scd").load;
}
)





Help.gui
// "/Users/will/gitStuff/DX7-P/DX7-P.scd".load;





Ndef(\fmx7_test, \fmx7)
Ndef(\fmx7_test).gui


// 1. Define your SynthDef
SynthDef(\mySynth, { |out=0, freq=440, amp=0.1, pan=0|
    var sig = SinOsc.ar(freq) * amp;
    Out.ar(out, Pan2.ar(sig, pan));
}).add;

// 2. Bind it to an NDef
NDef(\myNDef, \mySynth);

// 3. Open the GUI
NDef(\myNDef).gui;

(
// More complex example with parameter mapping
Ndef(\myNDef, {
    // Use the same argument names as your SynthDef
    arg freq=440, amp=0.1, pan=0;
    
    // Play the SynthDef through the NDef
    SynthDef.wrap({
        |freq, amp, pan|
        var sig = SinOsc.ar(freq) * amp;
        Out.ar(0, Pan2.ar(sig, pan));
    }, prependArgs: [freq, amp, pan]);
});
)

// Open GUI - now with sliders for all parameters
Ndef(\myNDef).gui;






~dx7_control_bufs = Bus.control(s, 200);





~dropEveryOther = { |array|
    array.select({ |item, index| index.even });
    // or index.odd to drop the other set
};

// Example:
a = [10, 20, 30, 40, 50, 60];
~loadedData[0].select({|item, index| index.odd});

~loadedData[0].odd;




~setParamsFromPreset.value(1)

~loadedData[1].select({|item, index| index.odd}).size

~dx7_control_bufs.set(~loadedData[1].select({|item, index| index.odd}).slice(0, 180));














"/Users/will/.config/tidal/init/synths/dx7_test.scd".load;

"/private/tmp/analysis/analysis_1744882221.scd".load;

~loadedData.postln;

s.dumpOSC(0)

Help.gui

"/Users/will/.config/tidal/init/synths/SC-808.scd".load;

SwitchDelay.asClass.notNil

WFSLib.startup;
WFSSpeakerConfGUI;














Quarks.install("https://github.com/florian-grond/SC-HOA")






Help.gui





WFSLib

Quarks.install( "WFSCollider-Class-Library" );
Quarks.install( "Unit-Lib" );
Quarks.install( "Netlib" );

Quarks.install("Unit-Lib")


Quarks.gui

Document.gui

(0..31).collect({|i|
    i*2
});

