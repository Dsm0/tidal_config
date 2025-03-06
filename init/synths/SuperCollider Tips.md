SuperCollider Tips
- by Nathan Ho

(taken from https://nathan.ho.name/posts/supercollider-tips/)

Here are some coding tips that may be of use for people using the SuperCollider language. Mostly a “stuff I wish I knew years earlier” post.

For some softer advice concerning broader technical and artistic use of SC, I have a new blog post called “Opinionated Advice for SuperCollider Beginners.”

Updated 2023-03-16.
Levels management and volume safety

Added 2023-03-16.

I’m putting this one first because it’s very, very important!

SC is notorious for producing sounds that can damage your hearing. Luckily, accidents are preventable, and it’s 100% possible to practice safe SuperColliding by getting into good habits. I have written the article “Levels and volume safety” on scsynth.org as an extensive guide to managing levels in SC.

A quick summary:

    If you are on macOS, upgrade to at least SC 3.12 right dang now and add Server.default.options.safetyClipThreshold = 1 to your startup file so the audio output clips.

    Work at low levels in your system’s volume control, but high levels in SC. If your audio is at a comfortable level and peaks in SC at -6 dBFS, the loudest sounds can only peak at 6 dB louder than that, so a synthesis accident can be startling, but unlikely to be dangerous.

    As a corollary: if SC produces a quiet signal, do not turn up the volume using your computer’s volume control! Instead, turn it up in SC.

    Use a Limiter on the master bus.

    Type in gain amounts as e.g. * -60.dbamp instead of * 0.001.

EnvGen, Env, and done actions

Here is a standard way to write an envelope generator:

env = EnvGen.kr(Env.adsr(0.01, 0.03, 0.7, 0.1), gate, doneAction: 2);
snd = snd * env;

There is nothing wrong with this, but there are nicer ways to write it. In 3.9 (?), SuperCollider added a bunch of constants like Done.freeSelf to improve readability:

env = EnvGen.kr(Env.adsr(0.01, 0.03, 0.7, 0.1), gate, doneAction: Done.freeSelf);
snd = snd * env;

Of course Done.freeSelf is just a constant 2, but I much prefer spelling it out to make the intentions more clear. In practice, I only use Done.freeSelf and Done.none. Check the Done helpfile for the full list.

In 3.7, a particularly nice shortcut was added, the instance method Env:-kr:

env = Env.adsr(0.01, 0.03, 0.7, 0.1).kr(Done.freeSelf, gate)
snd = snd * env;

Note the order of arguments – done action first, then gate. Internally, this creates an EnvGen and does the exact thing as above, but saves you typing and looks nicer. After I started writing envelope generators this way, I’ve never looked back.

One final bit of advice I have for envelope generators: always default to writing them in audio rate (ar) and not control rate (kr). Many real-life envelopes, such as percussive signals or Ryoji Ikeda, can get fast enough that the downsampling audibly loses sharpness. I write this:

env = Env.adsr(0.01, 0.03, 0.7, 0.1).ar(Done.freeSelf, gate);
snd = snd * env;

kr technically saves you some CPU, but unless you’re actually running into performance issues with your SynthDefs, this isn’t something I’d worry about. Get into the habit of using ar, only use kr when you need it.
Alternate symbol syntax in arrays

The code [a: 3, b: 4] does the same thing as [\a, 3, \b, 4]. This is particularly nice when writing arguments Synth:

synth = Synth(\foo, [\freq, 440, \amp, 0.1]);
synth = Synth(\foo, [freq: 440, amp: 0.1]);

You can run sclang from the command line

SC can be run without the IDE like a “normal” programming language. Just run sclang script.scd at the command line.

script.scd must be formatted in a special way. Rather than the usual floating chunks of code delimited by parentheses, the script must be a single code block executed all at once. This is equivalent in the IDE to booting the interpreter and immediately running Language → Evaluate File.

Let’s look at an example. If you have IDE code like this (with apologies for the terrible “music”):

// Run this first:
Server.default.boot;

// Run this second:
(
SynthDef(\sine, {
    var snd;
    snd = SinOsc.ar(\freq.kr(440));
    snd = snd * Env.perc(0.01, 0.3).ar(Done.freeSelf);
    Out.ar(0, snd);
}).add;
)

// Run this third:
(
Routine({
    10.do {
        Synth(\sine, [freq: exprand(100, 8000), amp: 0.1]);
        rrand(0.1, 0.5).yield;
    };
}).play;
)

To run this from the command line, condense all code blocks into a single block that is the equivalent of running all in sequence:

Server.default.waitForBoot {
    SynthDef(\sine, {
        var snd;
        snd = SinOsc.ar(\freq.kr(440));
        snd = snd * Env.perc(0.01, 0.3).ar(Done.freeSelf);
        Out.ar(0, snd);
    }).add;
    Server.default.sync;
    Routine({
        10.do {
            Synth(\sine, [freq: exprand(100, 8000), amp: 0.1]);
            rrand(0.1, 0.5).yield;
        };
        0.exit;
    }).play;
};

The method Server:-sync, in a Routine, is necessary since SynthDef:-add works asynchronously. If your code consists of SynthDef definitions and then Synth instantiations, you should put a Server:-sync in between them to avoid race conditions. Note that Server:-sync must take place in a Routine (in this case, waitForBoot already wraps our code in a Routine).

You have to write 0.exit manually at the completion of your piece. sclang doesn’t do the node.js thing where it exits automatically when there are no more outstanding asynchronous tasks.

This refactoring process might seem like an enormous pain in the neck, and a complete upheaval of the standard workflow in SuperCollider. I’d make a case that the first code example is “wrong” from a software engineering standpoint. Splitting a linear program across multiple, interactively executed code blocks and guessing the timing of asynchronous tasks simply isn’t a good programming practice, and proper asynchronous programming is needed if you want to run sclang as a command-line application.

That said, instantaneous feedback on your code (in particular, without having to restart sclang and scsynth) is tremendously helpful in a music programming environment, and a big reason why the IDE’s nonlinear execution style is so dominant. Using the IDE trades off proper coding structure for the creative benefits of interactivity. I tend to write in the nonlinear style when making music, and the more structured linear style when designing something more robust and application-like.
NamedControl

I wrote a post on the scsynth.org forums about NamedControls, why they are superior in multiple ways to the typical way to write SynthDefs. Instead of this:

// Old way
SynthDef(\sine, {
    |freq = 440, amp = 0.1, out = 0|
    Out.ar(out, SinOsc.ar(freq) * amp);
}).add;

Write this:

// New way
SynthDef(\sine, {
    Out.ar(\out.kr(0), SinOsc.ar(\freq.kr(440)) * \amp.kr(0.1));
}).add;

This seems like a purely surface-level change, and maybe even a step backwards since you no longer automatically have a nice summary of the arguments at the top of the SynthDef. However, NamedControls have tremendous advantages in readability over argument-style SynthDefs when you start using rate specifiers:

// Old way 1
// WARNING: names of actual arguments are "freq", "amp", and "out"!
// Also, don't accidentally name any argument starting with "a_", "k_", "i_", or "t_" or
// you'll experience difficult-to-diagnose bugs!
SynthDef(\sine, {
    |a_freq = 440, k_amp = 0.1, i_out = 0|
    Out.ar(i_out, SinOsc.ar(a_freq) * k_amp);
}).add;

// Old way 2
// WARNING: remember to update the "rates" array if you add, remove, or reorder arguments!
SynthDef(\sine, {
    |freq = 440, amp = 0.1, out = 0|
    Out.ar(out, SinOsc.ar(freq) * amp);
}, rates: [\ar, nil, \ir]).add;

// New way
SynthDef(\sine, {
    Out.ar(\out.kr(0), SinOsc.ar(\freq.kr(440)) * \amp.kr(0.1));
}).add;

Or multichannel arguments:

// Old way
SynthDef(\sine, {
    |freqs = #[440, 440, 440, 440, 440, 440, 440, 440]|
    ...
}).add;
// WARNING: attempting to abbreviate as "freqs = (440.dup(8))" will cause silent failure!

// New way
SynthDef(\sine, {
    var freqs = \freqs.kr(440.dup(8));
    ...
}).add;

As you can see with the warnings I’ve peppered around here, the old style has some nasty surprises lying in wait. I go into more detail on these arguments in the forum post, so go check it out.
mul/add

The mul and add arguments on UGens exist entirely for historical reasons, back when the compile-time optimization of SynthDefs was less smart. Nowadays, you can simply use the * and + binary operators, at no CPU penalty:

SinOsc.ar(440) * mul + add

This seems much more readable to me than

SinOsc.ar(440, mul, add)

since you don’t need to memorize the number of arguments that SinOsc expects. Ah hell, I forgot the phase argument. I meant SinOsc.ar(440, 0, mul, add).

mul and add also have a hidden surprise. Their behavior in multichannel expansion is inconsistent with regular UGen arguments:

{ LFNoise0.ar(freq: [100, 100], mul: 1) }.plot(0.2); // two different noise signals
{ LFNoise0.ar(freq: 100, mul: [1, 1]) }.plot(0.2); // two of the same noise signal

Internally, they are expanding differently:

{ LFNoise0.multiNew(\audio, [100, 100]) * 1 }.plot(0.2);
{ LFNoise0.multiNew(\audio, 100) * [1, 1] }.plot(0.2);

To avoid this trap, and improve the readability of your code, I recommend always using the binary operators.
Amplitude

Ever tried to use the Amplitude UGen for analysis, vocoding, compressor design, or whatever, and gotten weird or unexpected results?

env = Amplitude.kr(sig);

Amplitude has poor default settings, with both attack and release coefficients at 0.01. In most practical applications of envelope followers, you will want release significantly longer than attack. A good start would be:

env = Amplitude.ar(sig, 0.01, 0.1);

You will have to adjust these coefficients to fit your specific application. For analysis, you may want to crank the attack all the way down to 0 to maximize sensitivity and responsiveness. For vocoding, you may want slow, long-term attack/release like 0.1/1.0. Adjust until it sounds good.

Also, .ar vs .kr. There is generally no need to write Amplitude.kr and throw away sharp transient information. Use Amplitude.ar unless the optimization is specifically needed.
Always wrap Synth.new and Synth:set in Server.default.bind

Added 2023-03-16.

This tip was originally a thread on scsynth.org. This is an abridged version. For more discussion, see the thread.

If you venture outside the confines of the Patterns system, there is an important gotcha rarely covered in SC tutorials. Run these examples:

(
var s;
s = Server.default;
Routine({
    SynthDef(\ping, { Out.ar(\out.kr(0), (SinOsc.ar(440) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.freeSelf)) ! 2) }).add;
    s.sync;
    loop {
        Synth(\ping);
        0.05.wait;
    };
}).play;
)

(
var s;
s = Server.default;
Routine({
    SynthDef(\ping, { Out.ar(\out.kr(0), (SinOsc.ar(440) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.freeSelf)) ! 2) }).add;
    s.sync;
    loop {
        s.bind { Synth(\ping); };
        0.05.wait;
    };
}).play;
)

The first sounds jittery and uneven, but the second one sounds fine. The same is true of Synth:set:

(
var s;
s = Server.default;
Routine({
    var synth;
    SynthDef(\ping2, { Out.ar(\out.kr(0), (SinOsc.ar(440) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.none, \trigger.tr)) ! 2) }).add;
    s.sync;
    synth = Synth(\ping2);
    loop {
        synth.set(\trigger, 1);
        0.05.wait;
    };
}).play;
)

(
var s;
s = Server.default;
Routine({
    var synth;
    SynthDef(\ping2, { Out.ar(\out.kr(0), (SinOsc.ar(440) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.none, \trigger.tr)) ! 2) }).add;
    s.sync;
    s.bind { synth = Synth(\ping2); };
    loop {
        s.bind { synth.set(\trigger, 1); };
        0.05.wait;
    };
}).play;
)

The use of Server.default.bind is especially critical if you mix Pattern and non-Pattern code:

(
var s;
s = Server.default;
Routine({
    SynthDef(\ping, { Out.ar(\out.kr(0), (SinOsc.ar(\freq.kr(440)) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.freeSelf)) ! 2) }).add;
    s.sync;
    Synth(\ping);
    Pbind(\instrument, \ping, \freq, Pseq([660], 1)).play;
    (instrument: \ping, freq: 880).play;
}).play;
)

(
var s;
s = Server.default;
Routine({
    SynthDef(\ping, { Out.ar(\out.kr(0), (SinOsc.ar(\freq.kr(440)) * -5.dbamp * Env.perc(0.001, 0.1).ar(Done.freeSelf)) ! 2) }).add;
    s.sync;
    s.bind { Synth(\ping); };
    Pbind(\instrument, \ping, \freq, Pseq([660], 1)).play;
    (instrument: \ping, freq: 880).play;
}).play;
)

The first example attempts to play a Synth, a Pattern, and an Event at the same time. The Synth arrives early in the first example, while all are on time in the second example.

The client and server communicate by OSC. OSC messages, when in bundles, can be optionally adorned with a “time tag” that indicates the exact time when the message should be executed. If no time tag is specified, or the message is not in a bundle, the receiver must execute the OSC message as soon as it is received. A common use for time tags is to pre-empt OSC messages so their timing can be accurate instead of at the mercy of any inherent latency in OSC communication.

An unadorned Synth.new sends an /s_new message with no time tag, and so the server executes the OSC message whenever it’s received.

s.bind { ... } is shorthand for s.makeBundle(s.latency, { ... }). .makeBundle causes the Server object to temporarily change the behavior of sendMsg so that attempts to send new OSC messages instead add those OSC messages to a bundle. The function is immediately executed, and after it is completed, the OSC messages are scheduled s.latency seconds ahead. You can change s.latency if you want; the default of 0.2 is rather high. (s.latency is commonly misunderstood to be related to audio latency. It isn’t. In fact, the only place it is used is in OSC pre-emption, and scsynth isn’t even aware of it. Maybe it should have been called s.oscLatency?)

It is important to note that s.bind { ... }, despite having a callback function, is not asynchronous. The function is run immediately, and s.bind does not return until after the callback has completed execution.

The Patterns system – or more accurately, the default Event type – automatically runs .makeBundle. You can override this with the \latency key in the default Event type. Try setting it to nil in a pattern, which removes the time tag.

There is one case where you shouldn’t use s.bind { ... }: real-time interaction, such as from a MIDI controller, sensor, or another application. In such cases, it’s preferable to sacrifice timing accuracy for the sake of minimizing latency.
Preventing SC from automatically starting JACK on Linux

Added 2023-03-16.

On Linux using JACK, SC automatically tries to start a JACK server if none seem to be running, and that JACK server will shut down when SC does. This can be annoying if you’d rather start JACK yourself.

This isn’t SC’s fault since this behavior is the default when creating a client in the JACK API. Fortunately, JACK allows overriding this behavior by defining the environment variable JACK_NO_START_SERVER. If you want this to be the case for all JACK applications, you can add export JACK_NO_START_SERVER=1 to your ~/.profile. To make this setting SC-specific, "JACK_NO_START_SERVER".setenv("1"); in your startup file should do the trick.
Getting help

The longest-standing SC communities are the sc-users and sc-dev mailing lists. More recent, and less well known, are the web forum at scsynth.org and the Slack chat. If you are interested in participating in the community, I recommend checking them out.
