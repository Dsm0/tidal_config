/* analysis file written by DX7-P with write flag. see example.scd for explanation. */ 

/*
Ctls =  [ [ 0.65, 0.0, 0.92749157839181 ], [ 97.936358995437, 0.0, 0.12589254052719 ], [ 97.32230220046, 0.0, 0.92749157839181 ], [ 97.72652095046, 0.0, 0.3374478370851 ], [ 98.217608995437, 0.0, 0.12277312851816 ], [ 785.7408719635, 0.0, 0.057706305673827 ] ] 

CM Ratios =  [ 149.72661876994, 150.34849376994, 150.67132153144, 151.10401383913, 1208.8321107131 ] 

Mods =  [ [ 0, 12.566370614359, 0, 0, 0, 0 ], [ 0, 5.5417694409324, 0, 0, 0, 0 ], [ 0, 0, 0, 12.566370614359, 0, 0 ], [ 0, 0, 0, 0, 12.566370614359, 12.566370614359 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ] 

ALGORITHM =  15 

Out Amps =  [ 1, 0, 1, 0, 0, 0 ] 

*/ 




// ~dx7_control_bufs = Bus.control(s, 174);

// full # of presets: 16384
~dx7_presetCount = 16384;
~dx7_busMeAmp = Bus.audio(s, 1); // private buses used for LFO pitch and amplitudes
~dx7_busMePitch = Bus.audio(s, 1); // " "
~dx7_mainCaller = ("/Users/will/.config/tidal/init/synths/dx7-3-tidal.scd").load;
~dx7_presets = Array.newClear(~dx7_presetCount);
~dx7_presets_param_names = Array.newClear(~dx7_presetCount);
~dx7_presets_values = Array.newClear(~dx7_presetCount);
~dx7_presetCount.do({|i|
	var huh;
 	huh = ~defme2.value(55, 90, i);
	~dx7_presets[i] = huh;
	~dx7_presets_param_names = huh.select({|preset,idx| idx.even });
	~dx7_presets_values[i] = huh.select({|preset,idx| idx.odd });
	// ~dx7_presets_values[i].postln;
});
// ~dx7_control_bus = Bus.control(s, 175);
~dx7_preset_buffer = Buffer.alloc(s, ~dx7_presetCount * ~dx7_presets_values[0].size, 1); // 4 presets with 4 parameters each
// ~dx7_preset_buffer.setn(0, ~dx7_presets_values.flat);
// ~dx7_control_bufs = Bus.control(s, 174);











/* -- LFO Synth for vibrato and tremolo -- instantiate this synth first */ 
SynthDef( 'InfEfx_tst' , {
arg out=0, gate = nil , lfoGet1 = 0, lfoGet2 = 1,
lfo_speed = 5.56576 , lfo_wave = 4377 ,lfo_phase = 0 ,
lfo_delay = 1.5851515151515 ,lfo_amd = 0.0 ,pitchCons = 0.12732816161616 
, envTrig = 1 ,tameC = 0 , tameM = 1, presetIndex = -1;
var lfo, pitchenv, output, randomlfo, multiPitch, lfoAmp;

lfo = Osc.ar(lfo_wave,lfo_speed, lfo_phase, 0.5 * lfoGet2, 0.5 * lfoGet2) + LFNoise0.ar(lfo_speed, 0.5 * lfoGet1, 0.5 * lfoGet1);
lfo = lfo * EnvGen.ar(Env.asr(lfo_delay,releaseTime:0.01, curve: -5),envTrig);
multiPitch = LinLin.ar(lfo, 0, 1, (pitchCons.neg.midiratio * tameM) + tameC, pitchCons.midiratio);
lfoAmp = LinLin.ar(lfo, 0, 1, lfo_amd * (-3/4), 0);
FreeSelf.kr(gate);

Out.ar(~dx7_busMePitch, multiPitch);
Out.ar(~dx7_busMeAmp, lfoAmp)

}).add; 

fork {
	4.wait;
	~dx7_preset_buffer.loadCollection(~dx7_presets_values.flat);
};

(
/* -- DX7 Synth -- use 'addToTail' when instantiating this synth */ 
SynthDef( 'DX7_tst' ,{


arg out=(0), envPL0= (-1) , envPL1= (-1) , envPL2= (-1) ,envPL3= (-1) , envPL4= (-1) , envPR0= (-1) ,envPR1= (-1), envPR2= (-1) ,envPR3= (-1) ,coars1= (-1) , fine_1=(-1),coars2=(-1),fine_2=(-1), coars3=(-1),fine_3=(-1),coars4=(-1), fine_4=(-1),coars5=(-1),fine_5=(-1), coars6=(-1),fine_6=(-1),env1L0=(-1), env1L1=(-1),env1L2=(-1),env1L3=(-1), env1L4=(-1),env1R0=(-1),env1R1=(-1), env1R2=(-1),env1R3=(-1),env1C0=(-1), env1C1=(-1),env1C2=(-1),env1C3=(-1), env2L0=(-1),env2L1=(-1),env2L2=(-1), env2L3=(-1),env2L4=(-1),env2R0=(-1), env2R1=(-1),env2R2=(-1),env2R3=(-1), env2C0=(-1),env2C1=(-1),env2C2=(-1), env2C3=(-1),env3L0=(-1),env3L1=(-1), env3L2=(-1),env3L3=(-1),env3L4=(-1), env3R0=(-1),env3R1=(-1),env3R2=(-1), env3R3=(-1),env3C0=(-1),env3C1=(-1), env3C2=(-1),env3C3=(-1),env4L0=(-1), env4L1=(-1),env4L2=(-1),env4L3=(-1), env4L4=(-1),env4R0=(-1),env4R1=(-1), env4R2=(-1),env4R3=(-1),env4C0=(-1), env4C1=(-1),env4C2=(-1),env4C3=(-1), env5L0=(-1),env5L1=(-1),env5L2=(-1), env5L3=(-1),env5L4=(-1),env5R0=(-1), env5R1=(-1),env5R2=(-1),env5R3=(-1), env5C0=(-1),env5C1=(-1),env5C2=(-1), env5C3=(-1),env6L0=(-1),env6L1=(-1), env6L2=(-1),env6L3=(-1),env6L4=(-1), env6R0=(-1),env6R1=(-1),env6R2=(-1), env6R3=(-1),env6C0=(-1),env6C1=(-1), env6C2=(-1),env6C3=(-1),noteBlok1=(-1), noteBlok2=(-1),noteBlok3=(-1), noteBlok4=(-1),noteBlok5=(-1), noteBlok6=(-1), dn0=(-1),dn1=(-1),dn2=(-1),dn3=(-1), dn4=(-1),dn5=(-1),dn6=(-1),dn7=(-1), dn8=(-1),dn9=(-1),dn10=(-1),dn11=(-1), dn12=(-1),dn13=(-1),dn14=(-1),dn15=(-1), dn16=(-1),dn17=(-1),dn18=(-1),dn19=(-1), dn20=(-1),dn21=(-1),dn22=(-1),dn23=(-1), dn24=(-1),dn25=(-1),dn26=(-1),dn27=(-1), dn28=(-1),dn29=(-1),dn30=(-1),dn31=(-1), dn32=(-1),dn33=(-1),dn34=(-1),dn35=(-1), dn36=(-1),dn37=(-1),dn38=(-1),dn39=(-1), dn40=(-1),dn41=(-1),detun1=(-1), detun2=(-1),detun3=(-1),detun4=(-1), detun5=(-1),detun6=(-1),modSens1=(-1), modSens2=(-1),modSens3=(-1),modSens4=(-1), modSens5=(-1),modSens6=(-1),outMult=(-1), osc_sync=(-1),
gate = (1),transpose=(nil),gate1=(1),gate1Rel =(1), dx7_amp=(0.1),totVol=(nil),
presetIndex= 0, pan=0, freq=190, speed=1, begin=0, end=1, accelerate=0, dur=1;

// PARAMS SENT BY TIDAL
// [ "/s_new", "dirt_gate2", -1, 1, 15681, "in", 132, "out", 134, "amp", 0.4, "gain", 2, "overgain", 0, "sample", 394116296, "cut", 0, "sustain", 27.4275, "fadeInTime", 0, "fadeTime", 0.001 ]


var ctls, mods, chans, sig, kilnod,
envAmp1, envEnv1, envAmp2, envEnv2, envAmp3, envEnv3 ,envAmp4, envEnv4, envAmp5, envEnv5, envAmp6, envEnv6, dca, envAmpP, envEnvP,presetParams;
var huh, amp, pitch;


pitch = freq * speed * (1 + (accelerate * Line.ar(begin, end, dur, doneAction: Done.freeSelf)));

// pitch = 97;
// outBus=(0); pitch= (-1) ; gate = (-1); envPL0= (-1) ; envPL1= (-1) ; envPL2= (-1) ;envPL3= (-1) ; envPL4= (-1) ; envPR0= (-1) ;envPR1= (-1); envPR2= (-1) ;envPR3= (-1) ;coars1= (-1) ; fine_1=(-1);coars2=(-1);fine_2=(-1); coars3=(-1);fine_3=(-1);coars4=(-1); fine_4=(-1);coars5=(-1);fine_5=(-1); coars6=(-1);fine_6=(-1);env1L0=(-1); env1L1=(-1);env1L2=(-1);env1L3=(-1); env1L4=(-1);env1R0=(-1);env1R1=(-1); env1R2=(-1);env1R3=(-1);env1C0=(-1); env1C1=(-1);env1C2=(-1);env1C3=(-1); env2L0=(-1);env2L1=(-1);env2L2=(-1); env2L3=(-1);env2L4=(-1);env2R0=(-1); env2R1=(-1);env2R2=(-1);env2R3=(-1); env2C0=(-1);env2C1=(-1);env2C2=(-1); env2C3=(-1);env3L0=(-1);env3L1=(-1); env3L2=(-1);env3L3=(-1);env3L4=(-1); env3R0=(-1);env3R1=(-1);env3R2=(-1); env3R3=(-1);env3C0=(-1);env3C1=(-1); env3C2=(-1);env3C3=(-1);env4L0=(-1); env4L1=(-1);env4L2=(-1);env4L3=(-1); env4L4=(-1);env4R0=(-1);env4R1=(-1); env4R2=(-1);env4R3=(-1);env4C0=(-1); env4C1=(-1);env4C2=(-1);env4C3=(-1); env5L0=(-1);env5L1=(-1);env5L2=(-1); env5L3=(-1);env5L4=(-1);env5R0=(-1); env5R1=(-1);env5R2=(-1);env5R3=(-1); env5C0=(-1);env5C1=(-1);env5C2=(-1); env5C3=(-1);env6L0=(-1);env6L1=(-1); env6L2=(-1);env6L3=(-1);env6L4=(-1); env6R0=(-1);env6R1=(-1);env6R2=(-1); env6R3=(-1);env6C0=(-1);env6C1=(-1); env6C2=(-1);env6C3=(-1);noteBlok1=(-1); noteBlok2=(-1);noteBlok3=(-1); noteBlok4=(-1);noteBlok5=(-1); noteBlok6=(-1); dn0=(-1);dn1=(-1);dn2=(-1);dn3=(-1); dn4=(-1);dn5=(-1);dn6=(-1);dn7=(-1); dn8=(-1);dn9=(-1);dn10=(-1);dn11=(-1); dn12=(-1);dn13=(-1);dn14=(-1);dn15=(-1); dn16=(-1);dn17=(-1);dn18=(-1);dn19=(-1); dn20=(-1);dn21=(-1);dn22=(-1);dn23=(-1); dn24=(-1);dn25=(-1);dn26=(-1);dn27=(-1); dn28=(-1);dn29=(-1);dn30=(-1);dn31=(-1); dn32=(-1);dn33=(-1);dn34=(-1);dn35=(-1); dn36=(-1);dn37=(-1);dn38=(-1);dn39=(-1); dn40=(-1);dn41=(-1);detun1=(-1); detun2=(-1);detun3=(-1);detun4=(-1); detun5=(-1);detun6=(-1);modSens1=(-1); modSens2=(-1);modSens3=(-1);modSens4=(-1); modSens5=(-1);modSens6=(-1);outMult=(-1); osc_sync=(-1);transpose=(-1);gate1=(-1);gate1Rel =(-1); dx7_amp=(-1);totVol=(-1); 

// pitch=(-1); gate=(-1);

// var preset_values = BufRd.kr(~dx7_preset_buffer.numChannels, ~dx7_preset_buffer, presetIndex * ~dx7_preset_buffer.numChannels,0,0);
// var preset_values = BufRd.kr(~dx7_preset_buffer.numChannels, ~dx7_preset_buffer, presetIndex * 175,0,0);
// var preset_values = BufRd.kr(~dx7_preset_buffer.numChannels, ~dx7_preset_buffer, presetIndex * ~dx7_preset_buffer.numChannels,0,0);
// var preset_values = BufRd.kr(~dx7_preset_buffer.numChannels, ~dx7_preset_buffer, presetIndex * 175,0,0);
// var hh = BufRd.kr(1, ~dx7_preset_buffer, 2,0,0);
// var preset_values = BufRd.kr(1, ~dx7_preset_buffer, presetIndex * 175,0,0);
// preset_values.poll;
// h = {arg param, i; Select.kr((param+1).clip(0,1), [preset_values[i], param]); };
amp = dx7_amp;

presetIndex = presetIndex.wrap(0, ~dx7_presetCount-1);

h = {arg param, i; Select.kr((param+1).clip(0,1), [BufRd.kr(1, ~dx7_preset_buffer, i + (presetIndex * 175)), param]); };
// h = {arg param, i; Select.kr(0, [BufRd.kr(1, ~dx7_preset_buffer, i + (presetIndex * 175)), param]); };

outMult = h.value(outMult, 0);
dn0 = h.value(dn0, 1);
dn1 = h.value(dn1, 2);
dn2 = h.value(dn2, 3);
dn3 = h.value(dn3, 4);
dn4 = h.value(dn4, 5);
dn5 = h.value(dn5, 6);
dn6 = h.value(dn6, 7);
dn7 = h.value(dn7, 8);
dn8 = h.value(dn8, 9);
dn9 = h.value(dn9, 10);
dn10 = h.value(dn10, 11);
dn11 = h.value(dn11, 12);
dn12 = h.value(dn12, 13);
dn13 = h.value(dn13, 14);
dn14 = h.value(dn14, 15);
dn15 = h.value(dn15, 16);
dn16 = h.value(dn16, 17);
dn17 = h.value(dn17, 18);
dn18 = h.value(dn18, 19);
dn19 = h.value(dn19, 20);
dn20 = h.value(dn20, 21);
dn21 = h.value(dn21, 22);
dn22 = h.value(dn22, 23);
dn23 = h.value(dn23, 24);
dn24 = h.value(dn24, 25);
dn25 = h.value(dn25, 26);
dn26 = h.value(dn26, 27);
dn27 = h.value(dn27, 28);
dn28 = h.value(dn28, 29);
dn29 = h.value(dn29, 30);
dn30 = h.value(dn30, 31);
dn31 = h.value(dn31, 32);
dn32 = h.value(dn32, 33);
dn33 = h.value(dn33, 34);
dn34 = h.value(dn34, 35);
dn35 = h.value(dn35, 36);
dn36 = h.value(dn36, 37);
dn37 = h.value(dn37, 38);
dn38 = h.value(dn38, 39);
dn39 = h.value(dn39, 40);
dn40 = h.value(dn40, 41);
dn41 = h.value(dn41, 42);
// pitch = h.value(pitch, 43);
amp = h.value(amp, 44);
coars1 = h.value(coars1, 45);
fine_1 = h.value(fine_1, 46);
detun1 = h.value(detun1, 47);
noteBlok1 = h.value(noteBlok1, 48);
coars2 = h.value(coars2, 49);
fine_2 = h.value(fine_2, 50);
detun2 = h.value(detun2, 51);
noteBlok2 = h.value(noteBlok2, 52);
coars3 = h.value(coars3, 53);
fine_3 = h.value(fine_3, 54);
detun3 = h.value(detun3, 55);
noteBlok3 = h.value(noteBlok3, 56);
coars4 = h.value(coars4, 57);
fine_4 = h.value(fine_4, 58);
detun4 = h.value(detun4, 59);
noteBlok4 = h.value(noteBlok4, 60);
coars5 = h.value(coars5, 61);
fine_5 = h.value(fine_5, 62);
detun5 = h.value(detun5, 63);
noteBlok5 = h.value(noteBlok5, 64);
coars6 = h.value(coars6, 65);
fine_6 = h.value(fine_6, 66);
detun6 = h.value(detun6, 67);
noteBlok6 = h.value(noteBlok6, 68);
coars1 = h.value(coars1, 69);
fine_1 = h.value(fine_1, 70);
env1L0 = h.value(env1L0, 71);
env1L1 = h.value(env1L1, 72);
env1L2 = h.value(env1L2, 73);
env1L3 = h.value(env1L3, 74);
env1L4 = h.value(env1L4, 75);
env1R0 = h.value(env1R0, 76);
env1R1 = h.value(env1R1, 77);
env1R2 = h.value(env1R2, 78);
env1R3 = h.value(env1R3, 79);
env1C0 = h.value(env1C0, 80);
env1C1 = h.value(env1C1, 81);
env1C2 = h.value(env1C2, 82);
env1C3 = h.value(env1C3, 83);
modSens1 = h.value(modSens1, 84);
coars2 = h.value(coars2, 85);
fine_2 = h.value(fine_2, 86);
env2L0 = h.value(env2L0, 87);
env2L1 = h.value(env2L1, 88);
env2L2 = h.value(env2L2, 89);
env2L3 = h.value(env2L3, 90);
env2L4 = h.value(env2L4, 91);
env2R0 = h.value(env2R0, 92);
env2R1 = h.value(env2R1, 93);
env2R2 = h.value(env2R2, 94);
env2R3 = h.value(env2R3, 95);
env2C0 = h.value(env2C0, 96);
env2C1 = h.value(env2C1, 97);
env2C2 = h.value(env2C2, 98);
env2C3 = h.value(env2C3, 99);
modSens2 = h.value(modSens2, 100);
coars3 = h.value(coars3, 101);
fine_3 = h.value(fine_3, 102);
env3L0 = h.value(env3L0, 103);
env3L1 = h.value(env3L1, 104);
env3L2 = h.value(env3L2, 105);
env3L3 = h.value(env3L3, 106);
env3L4 = h.value(env3L4, 107);
env3R0 = h.value(env3R0, 108);
env3R1 = h.value(env3R1, 109);
env3R2 = h.value(env3R2, 110);
env3R3 = h.value(env3R3, 111);
env3C0 = h.value(env3C0, 112);
env3C1 = h.value(env3C1, 113);
env3C2 = h.value(env3C2, 114);
env3C3 = h.value(env3C3, 115);
modSens3 = h.value(modSens3, 116);
coars4 = h.value(coars4, 117);
fine_4 = h.value(fine_4, 118);
env4L0 = h.value(env4L0, 119);
env4L1 = h.value(env4L1, 120);
env4L2 = h.value(env4L2, 121);
env4L3 = h.value(env4L3, 122);
env4L4 = h.value(env4L4, 123);
env4R0 = h.value(env4R0, 124);
env4R1 = h.value(env4R1, 125);
env4R2 = h.value(env4R2, 126);
env4R3 = h.value(env4R3, 127);
env4C0 = h.value(env4C0, 128);
env4C1 = h.value(env4C1, 129);
env4C2 = h.value(env4C2, 130);
env4C3 = h.value(env4C3, 131);
modSens4 = h.value(modSens4, 132);
coars5 = h.value(coars5, 133);
fine_5 = h.value(fine_5, 134);
env5L0 = h.value(env5L0, 135);
env5L1 = h.value(env5L1, 136);
env5L2 = h.value(env5L2, 137);
env5L3 = h.value(env5L3, 138);
env5L4 = h.value(env5L4, 139);
env5R0 = h.value(env5R0, 140);
env5R1 = h.value(env5R1, 141);
env5R2 = h.value(env5R2, 142);
env5R3 = h.value(env5R3, 143);
env5C0 = h.value(env5C0, 144);
env5C1 = h.value(env5C1, 145);
env5C2 = h.value(env5C2, 146);
env5C3 = h.value(env5C3, 147);
modSens5 = h.value(modSens5, 148);
coars6 = h.value(coars6, 149);
fine_6 = h.value(fine_6, 150);
env6L0 = h.value(env6L0, 151);
env6L1 = h.value(env6L1, 152);
env6L2 = h.value(env6L2, 153);
env6L3 = h.value(env6L3, 154);
env6L4 = h.value(env6L4, 155);
env6R0 = h.value(env6R0, 156);
env6R1 = h.value(env6R1, 157);
env6R2 = h.value(env6R2, 158);
env6R3 = h.value(env6R3, 159);
env6C0 = h.value(env6C0, 160);
env6C1 = h.value(env6C1, 161);
env6C2 = h.value(env6C2, 162);
env6C3 = h.value(env6C3, 163);
modSens6 = h.value(modSens6, 164);
envPL0 = h.value(envPL0, 165);
envPL1 = h.value(envPL1, 166);
envPL2 = h.value(envPL2, 167);
envPL3 = h.value(envPL3, 168);
envPL4 = h.value(envPL4, 169);
envPR0 = h.value(envPR0, 170);
envPR1 = h.value(envPR1, 171);
envPR2 = h.value(envPR2, 172);
envPR3 = h.value(envPR3, 173);
osc_sync = h.value(osc_sync, 174);



envEnvP = Env.new([ envPL0, envPL1, envPL2, envPL3, envPL4], [envPR0,envPR1,envPR2,envPR3], 0, 3);
envAmpP = EnvGen.kr(envEnvP, gate, doneAction:0);
envEnv1 = Env.new([(-1 * env1L0).dbamp ,(-1 * env1L1).dbamp, (-1 * env1L2).dbamp, (-1 * env1L3).dbamp, (-1 * env1L4).dbamp], [env1R0,env1R1,env1R2,env1R3], [env1C0,env1C1,env1C2,env1C3], 3);
envAmp1 = EnvGen.kr(envEnv1, gate, doneAction:0 );
envEnv2 = Env.new([(-1 * env2L0).dbamp ,(-1 * env2L1).dbamp, (-1 * env2L2).dbamp, (-1 * env2L3).dbamp, (-1 * env2L4).dbamp], [env2R0,env2R1,env2R2,env2R3], [env2C0,env2C1,env2C2,env2C3], 3);
envAmp2 = EnvGen.kr(envEnv2, gate, doneAction:0 );
envEnv3 = Env.new([(-1 * env3L0).dbamp ,(-1 * env3L1).dbamp, (-1 * env3L2).dbamp, (-1 * env3L3).dbamp, (-1 * env3L4).dbamp], [env3R0,env3R1,env3R2,env3R3], [env3C0,env3C1,env3C2,env3C3], 3);
envAmp3 = EnvGen.kr(envEnv3, gate, doneAction:0 );
envEnv4 = Env.new([(-1 * env4L0).dbamp ,(-1 * env4L1).dbamp, (-1 * env4L2).dbamp, (-1 * env4L3).dbamp, (-1 * env4L4).dbamp], [env4R0,env4R1,env4R2,env4R3], [env4C0,env4C1,env4C2,env4C3], 3);
envAmp4 = EnvGen.kr(envEnv4, gate, doneAction:0 );
envEnv5 = Env.new([(-1 * env5L0).dbamp ,(-1 * env5L1).dbamp, (-1 * env5L2).dbamp, (-1 * env5L3).dbamp, (-1 * env5L4).dbamp], [env5R0,env5R1,env5R2,env5R3], [env5C0,env5C1,env5C2,env5C3], 3);
envAmp5 = EnvGen.kr(envEnv5, gate, doneAction:0 );
envEnv6 = Env.new([(-1 * env6L0).dbamp ,(-1 * env6L1).dbamp, (-1 * env6L2).dbamp, (-1 * env6L3).dbamp, (-1 * env6L4).dbamp], [env6R0,env6R1,env6R2,env6R3], [env6C0,env6C1,env6C2,env6C3], 3);
envAmp6 = EnvGen.kr(envEnv6, gate, doneAction:0 );

ctls = [
[coars1 * fine_1 * ((pitch * noteBlok1) + ((detun1-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp1 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens1/3)).dbamp],
[coars2 * fine_2 * ((pitch  * noteBlok2) + ((detun2-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp2 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens2/3)).dbamp],
[coars3 * fine_3 * ((pitch * noteBlok3) + ((detun3-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp3 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens3/3)).dbamp],
[coars4 * fine_4 * ((pitch  * noteBlok4) + ((detun4-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp4 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens4/3)).dbamp],
[coars5 * fine_5 * ((pitch  * noteBlok5) + ((detun5-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp5 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens5/3)).dbamp],
[coars6 * fine_6 * ((pitch  * noteBlok6) + ((detun6-7)/32)) * (envAmpP.midiratio) * Lag2.ar(In.ar(~dx7_busMePitch),0.01),  Rand(0,2pi) * osc_sync, envAmp6 * (Lag2.ar(In.ar(~dx7_busMeAmp),0.01) * (modSens6/3)).dbamp]
];

mods = [
[dn0, dn1, dn2, dn3, dn4, dn5],
[dn6, dn7, dn8, dn9, dn10, dn11],
[dn12, dn13, dn14, dn15, dn16, dn17],
[dn18, dn19, dn20, dn21, dn22, dn23],
[dn24, dn25, dn26, dn27, dn28, dn29],
[dn30, dn31, dn32, dn33, dn34, dn35]
];

chans = [0, 1, 2, 3, 4, 5];
sig = FM7.ar(ctls, mods).slice(chans) * -12.dbamp;
sig = Mix.new([ // this is how the synthdef mutes channels - all are summed, but some are multiplied by zeros
(sig[0] * 1 * dn36),
(sig[1] * 1 * dn37),
(sig[2] * 1 * dn38),
(sig[3] * 1 * dn39),
(sig[4] * 1 * dn40),
(sig[5] * 1 * dn41),
]);

FreeSelfWhenDone.kr(Line.kr(0, 1, 10));
kilnod = DetectSilence.ar(sig, 0.01, 0.2, doneAction:2);
sig = sig / outMult;


OffsetOut.ar(out, DirtPan.ar((sig) * 4.dbamp, ~dirt.numChannels, pan));
// Out.ar(out, sig.dup);
}).add;
)



