(// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 256; // increase this if you need to load more samples
s.options.memSize = 8192 * 32; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary
s.options.numInputBusChannels = 2; // set this to your hardware output channel size, if necessary
// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	// for example: ~dirt.loadSoundFiles("/Users/myUserName/Dirt/samples/*");
	// s.sync; // optionally: wait for samples to be read
    //
    //
    SynthDef(\foo1, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
    SynthDef(\foo2, {|out=0, freq=440| Out.ar(out, DC.ar(0)) }).add;
    ~dirt.soundLibrary.addSynth(\foo1);
    ~dirt.soundLibrary.addSynth(\foo2);
	~dirt.start(57120, 0 ! 12);   // start listening on port 57120, create two busses each sending audio to channel 0
	// optional, needed for convenient access from sclang:
	~dirt.fileExtensions = ["wav","ogg","mp3"];

	~looper = TidalLooper(~dirt);

    // You can adjust these parameter even in runtime
    ~looper.rLevel = 1.5;
    ~looper.pLevel = 0.8;
    ~looper.linput = 15; // Set this to your main input port.
    ~looper.lname = "mybuffer";

	(
		~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
		~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
		~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
		~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	);
//
};
//
)
// s.latency = 0.8; // increase this if you get "late" messages

// s.latency

// ~dirt.startSendRMSte
~dirt.maxLatency = 64


s.options.memoryLocking = true

(
~dirt.loadSoundFiles("/home/will/Music/MO3/MO3_sf2_wavs");
~dirt.loadSoundFiles("/home/will/Music/mine/Mrandom");
)


~dirt.loadSoundFiles("/home/will/Music/smb_step_and_roll/bgm_w5_s3");
~dirt.loadSoundFiles("/home/will/Music/smb_step_and_roll/bgm_marathon");
~dirt.loadSoundFiles("/home/will/Music/smb_step_and_roll/bgm_events");
~dirt.loadSoundFiles("/home/will/Music/shawn_kemp");
~dirt.loadSoundFiles("/home/will/Music/halflife/*");
~dirt.loadSoundFiles("/home/will/Music/yume_nikki");

~dirt.loadSoundFiles("/home/will/Music/halflife/*");


~dirt.loadSoundFiles("/home/will/Music/son_house")


s.volume = (5)

~dirt.loadSoundFiles("/home/will/Music/palmolive")
~dirt.loadSoundFiles("/M/tidalSamples/customSamples/longdoom")
~dirt.loadSoundFiles("/home/will/Music/serious_shit")
~dirt.loadSoundFiles("/home/will/Music/aint_it_funny")


s.sampleRate


