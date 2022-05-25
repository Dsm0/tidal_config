// clock courtesy of pulu#3799
// clock courtesy of pulu#3799
// clock courtesy of pulu#3799
// clock courtesy of pulu#3799

// use
// p "tick" $ "0*4" # s "tick"
// to signal clock intervals

(
var clockMods, clockBeats, screenW, screenH, clockW, clockH, clockX, clockY, resizable, border;
clockMods = [8,8*2,8*3,8*4,8*5,8*6,8*7,8*8].reverse;
clockBeats = 4;
screenW = 1000;
screenH = 500;
clockW = 20;
clockH = 180;
clockX = screenW - clockW;
clockY = screenH - 1;
resizable = true;
border = false;


~clockText = StaticText()
.string_("[clock]")
.font_(Font.monospace(15))
.align_(\right)
.stringColor_(Color(1,1,1))
.minHeight_(20);

~updateClock = { |cycle|
    var text, beat;
    text = clockMods.collect { |m| "" ++ (cycle.floor.asInteger.mod(m) + 1) ++ "/" ++ m; }.join("\n");
    beat = (cycle.mod(1)*clockBeats).round.asInteger + 1;
    text = text ++ "\n" ++ clockBeats.collect { |i| if(i < beat, "▉ ", ""); }.join;
    ~clockText.string_(text);
};

~clockWindow = Window("clock", Rect(clockX, clockY, clockW, clockH), resizable, border)
.background_(Color(0.3,0.3,0.3))
.layout_(
    HLayout(
        ~clockText
    ).margins_(0!2)
);

~clockWindow.alwaysOnTop_(true);
~clockWindow.visible_(true);

SynthDef(\tick, { |cycle|
    SendReply.kr(Impulse.kr(0), "/tick", [cycle]);
    FreeSelf.kr(Impulse.kr(0));
}).add;

OSCdef(\tick, { |msg|
    var cycle;
    #cycle = msg[3..];
    Routine {
        { ~updateClock.(cycle); }.defer;
    }.play(SystemClock);
}, "/tick");
)