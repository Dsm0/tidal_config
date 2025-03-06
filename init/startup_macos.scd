(// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if neces sary
s.options.numInputBusChannels = 8; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.options.sampleRate = 44100;
s.waitForBoot {
	~dirtPort = 57120;
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
    //
    SynthDef(\foo1, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
    SynthDef(\foo2, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
    ~dirt.soundLibrary.addSynth(\foo1);
    ~dirt.soundLibrary.addSynth(\foo2);
	~dirt.start(~dirtPort, 0 ! 14);   // start listening on port 57120, create two busses each sending audio to channel 0
	// optional, needed for convenient access from sclang:
	~dirt.fileExtensions = ["wav","ogg","mp3","aiff","opus","aif"];

	// Load the OSC controls for sample loading
	"/Users/will/.config/tidal/init/synths/superDirtControls.scd".load;

	/*
	~looper = TidalLooper(~dirt);

    // You can adjust these parameter even in runtime
    ~looper.rLevel = 1.5;
	~looper.pLevel = 0.8;

    ~looper.linput = 4; // Set this to your main input port.
    ~looper.lname = "mybuffer";
	~looper.persistPath = "~/Music/TidalLoops/" + Date.getDate.stamp + "/";
	*/

	(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);


	"ahhhh".postln;
	s.volume = (-11);
	// thisProcess.platform.recordingsDir = "~/0_SD/Music/new_audacity/sc_recs/".standardizePath;

	thisProcess.platform.recordingsDir = "~/Music/sc_recs".standardizePath;

	// thisProcess.platform.recordingsDir = "~/Music/sc_recs/".standardizePath;



	"/Users/will/.config/tidal/init/synths/superDirtControls.scd".load;
	"SuperDirt OSC file reloading system initialized.".postln;

	"/Users/will/.config/tidal/init/effects/sidechain.scd".load;

	// "/home/wil/.config/tidal/init/effects/AnalogTape.scd".load;

	"/Users/will/.config/tidal/init/effects/multiband_comp.scd".load;


	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
// for example: ~d kljirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
// s.sync; // optionally: wait for samples to be read

	// "/home/wil/.config/tidal/init/pulu_clock.scd".load;

};

//
)


s.volume = -2


ServerOptions.devices

s.o.devices


(
// for SuperDirtMixer
~mixer = SuperDirtMixer(~dirt);
~mixer.setMasterBus(0);
~mixer.setOrbitLabels(["d1 - Lead", "d2 - Bass", "d3 - Key", "d4 - Pad"]);
~mixer.gui;
)


runInTerminal("xattr -d -r com.apple.quarantine" + shellQuote(Platform.userExtensionDir +/+ "nn.ar"))
(
// for tidal-rave

)


SuperDirt
Quarks.gui


this.interpret("~dirt.loadSoundFiles(\"/Volumes/LaCie/sd_backup_08_25_2024/Music/old_packs/VoiceSpectral_cut/vspectral102/\")")


s.volume = -12


s.options.outDevice = "BlackHole 64ch";

s.options.outDevice

s.options.outDevice = "External Headphones"


ScaleLP.aeolian

ServerOptions.devices



"/home/wil/Documents/tidalComps/dj_dave_remix/samples/Passenger_Woman2/*".pathMatch

"/home/wil/".pathMatch;

"/home/wil/.config/tidal/init/pulu_clock_no_tick.scd".load;




s.volume = 0
s.volume = 2

s.volume = 10 // love this crunch

(
// ~dirt.stop();
~dirt.freeAllSoundFiles;
// s.stop;
)

Quarks.gui

~dirt.freeSoundFiles("sc_recs")

~dirt.un

(
"/home/will/.config/tidal/init/pulu_clock.scd".load;
)



// Quarks.install("https://github.com/calumgunn/StageMaster.git");

(
StageMaster.deactivate;

StageMaster.activate(numChannels: 2, compThreshold: 0.7, limiterLevel: 1.5, highEndDb: 1.5);
)


Server.default.recordpath

Font.monospace

Quarks.gui

(
Patch({ arg bypass=0, ffreq=2200.0, boostcut=0.0, amp=0.1;
    var dry, filter;

    dry = SoundIn.ar([0,1]);

    filter = BhobHiShelf.ar(dry, ffreq, boostcut.dbamp);

    ((dry * bypass) + (filter * (bypass < 0.5))) * amp;
}).gui
)


include("SuperDirt");


EQui.new(Rect(left: 0, top: 0, width: 0, height: 0))

// post all sample info
//
~dirt.postSampleInfo

// EFFECTS
"/home/will/.config/tidal/init/effects/mid-side.scd".load
"/home/will/.config/tidal/init/effects/comb_delay.scd".load
"/home/will/.config/tidal/init/effects/fm.scd".load

s.loadSynthDefs("/home/will/.config/tidal/init/effects/")




// SYNTHS
"/home/will/.config/tidal/init/synths/beam_synth.scd".load
"/home/will/.config/tidal/init/synths/loopier_synthdefs/synthdef-brute.scd".load


// NOTE: MAY OR MAY NOT WORK
~dirt.loadSynthDefs("/home/will/.config/tidal/init/synths/")


~dirt.loadSoundFiles;

~looper.persistLoops("recm")

~dirt.modules[30]

~dirt.freeAllSoundFiles


// s.latency = 0.8; // increase this if you get "late" messages
// s.latency

// ~dirt.startSendRMSte
~dirt.maxLatency = 64
"ah".postln;
s.options.memoryLocking = true
