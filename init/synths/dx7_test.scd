/* analysis file written by DX7-P with write flag. see example.scd for explanation. */ 

/*
Ctls =  [ [ 0.65, 0.0, 0.92749157839181 ], [ 97.936358995437, 0.0, 0.12589254052719 ], [ 97.32230220046, 0.0, 0.92749157839181 ], [ 97.72652095046, 0.0, 0.3374478370851 ], [ 98.217608995437, 0.0, 0.12277312851816 ], [ 785.7408719635, 0.0, 0.057706305673827 ] ] 

CM Ratios =  [ 149.72661876994, 150.34849376994, 150.67132153144, 151.10401383913, 1208.8321107131 ] 

Mods =  [ [ 0, 12.566370614359, 0, 0, 0, 0 ], [ 0, 5.5417694409324, 0, 0, 0, 0 ], [ 0, 0, 0, 12.566370614359, 0, 0 ], [ 0, 0, 0, 0, 12.566370614359, 12.566370614359 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ] ] 

ALGORITHM =  15 

Out Amps =  [ 1, 0, 1, 0, 0, 0 ] 

*/ 

(
~setParamsFromPreset = {|presetIndex|
	var presetParams = ~loadedData[presetIndex];
    ~dx7_control_bufs.set(presetParams);
	// var outMult = presetParams[0];
	// var dn0 = presetParams[1];
	// var dn1 = presetParams[2];
	// var dn2 = presetParams[3];
	// var dn3 = presetParams[4];
	// var dn4 = presetParams[5];
	// var dn5 = presetParams[6];
	// var dn6 = presetParams[7];
	// var dn7 = presetParams[8];
	// var dn8 = presetParams[9];
	// var dn9 = presetParams[10];
	// var dn10 = presetParams[11];
	// var dn11 = presetParams[12];
	// var dn12 = presetParams[13];
	// var dn13 = presetParams[14];
	// var dn14 = presetParams[15];
	// var dn15 = presetParams[16];
	// var dn16 = presetParams[17];
	// var dn17 = presetParams[18];
	// var dn18 = presetParams[19];
	// var dn20 = presetParams[20];
	// var dn21 = presetParams[21];
	// var dn22 = presetParams[22];
	// var dn23 = presetParams[23];
	// var dn24 = presetParams[24];
	// var dn25 = presetParams[25];
	// var dn26 = presetParams[26];
	// var dn27 = presetParams[27];
	// var dn28 = presetParams[28];
	// var dn29 = presetParams[29];
	// var dn30 = presetParams[30];
	// var dn31 = presetParams[31];
	// var dn32 = presetParams[32];
	// var dn33 = presetParams[33];
	// var dn34 = presetParams[34];
	// var dn35 = presetParams[35];
	// var dn36 = presetParams[36];
	// var dn37 = presetParams[37];
	// var dn38 = presetParams[38];
	// var dn39 = presetParams[39];
	// var dn40 = presetParams[40];
	// var dn41 = presetParams[41];
	// var pitch = presetParams[42];
	// var amp = presetParams[43];
	// // var coars1 = presetParams[44];
	// // var fine_1 = presetParams[45];
	// var detun1 = presetParams[46];
	// var noteBlok1 = presetParams[47];
	// // var coars2 = presetParams[48];
	// // var fine_2 = presetParams[49];
	// var detun2 = presetParams[50];
	// var noteBlok2 = presetParams[51];
	// // var coars3 = presetParams[52];
	// // var fine_3 = presetParams[53];
	// var detun3 = presetParams[54];
	// var noteBlok3 = presetParams[55];
	// // var coars4 = presetParams[56];
	// // var fine_4 = presetParams[57];
	// var detun4 = presetParams[58];
	// var noteBlok4 = presetParams[59];
	// // var coars5 = presetParams[60];
	// // var fine_5 = presetParams[61];
	// var detun5 = presetParams[62];
	// var noteBlok5 = presetParams[63];
	// // var coars6 = presetParams[64];
	// // var fine_6 = presetParams[65];
	// var detun6 = presetParams[66];
	// var noteBlok6 = presetParams[67];
	// var coars1 = presetParams[68];
	// var fine_1 = presetParams[69]	;
	// var env1L0 = presetParams[70];
	// var env1L1 = presetParams[71];
	// var env1L2 = presetParams[72];
	// var env1L3 = presetParams[73];
	// var env1L4 = presetParams[74];
	// var env1R0 = presetParams[75];
	// var env1R1 = presetParams[76];
	// var env1R2 = presetParams[77];
	// var env1R3 = presetParams[78];
	// var env1C0 = presetParams[79];
	// var env1C1 = presetParams[80];
	// var env1C2 = presetParams[81];
	// var env1C3 = presetParams[82];
	// var modSens1 = presetParams[83];
	// var coars2 = presetParams[84];
	// var fine_2 = presetParams[85];
	// var env2L0 = presetParams[86];
	// var env2L1 = presetParams[87];
	// var env2L2 = presetParams[88];
	// var env2L3 = presetParams[89];
	// var env2L4 = presetParams[90];
	// var env2R0 = presetParams[91];
	// var env2R1 = presetParams[92];
	// var env2R2 = presetParams[93];
	// var env2R3 = presetParams[94];
	// var env2C0 = presetParams[95];
	// var env2C1 = presetParams[96];
	// var env2C2 = presetParams[97];
	// var env2C3 = presetParams[98];
	// var modSens2 = presetParams[99];
	// var coars3 = presetParams[100];
	// var fine_3 = presetParams[101];
	// var env3L0 = presetParams[102];
	// var env3L1 = presetParams[103];
	// var env3L2 = presetParams[104];
	// var env3L3 = presetParams[105];
	// var env3L4 = presetParams[106];
	// var env3R0 = presetParams[107];
	// var env3R1 = presetParams[108];
	// var env3R2 = presetParams[109];
	// var env3R3 = presetParams[110];
	// var env3C0 = presetParams[111];
	// var env3C1 = presetParams[112];
	// var env3C2 = presetParams[113];
	// var env3C3 = presetParams[114];
	// var modSens3 = presetParams[115];
	// var coars4 = presetParams[116];
	// var fine_4 = presetParams[117];
	// var env4L0 = presetParams[118]	;
	// var env4L1 = presetParams[119];
	// var env4L2 = presetParams[120];
	// var env4L3 = presetParams[121];
	// var env4L4 = presetParams[122];
	// var env4R0 = presetParams[123];
	// var env4R1 = presetParams[124];
	// var env4R2 = presetParams[125];
	// var env4R3 = presetParams[126];
	// var env4C0 = presetParams[127];
	// var env4C1 = presetParams[128];
	// var env4C2 = presetParams[129];
	// var env4C3 = presetParams[130];
	// var modSens4 = presetParams[131];
	// var coars5 = presetParams[132];
	// var fine_5 = presetParams[133];
	// var env5L0 = presetParams[134];
	// var env5L1 = presetParams[135];
	// var env5L2 = presetParams[136];
	// var env5L3 = presetParams[137];
	// var env5L4 = presetParams[138];
	// var env5R0 = presetParams[139];
	// var env5R1 = presetParams[140];
	// var env5R2 = presetParams[141];
	// var env5R3 = presetParams[142];
	// var env5C0 = presetParams[143];
	// var env5C1 = presetParams[144];
	// var env5C2 = presetParams[145];
	// var env5C3 = presetParams[146];
	// var modSens5 = presetParams[147];
	// var coars6 = presetParams[148];
	// var fine_6 = presetParams[149];
	// var env6L0 = presetParams[150];
	// var env6L1 = presetParams[151];
	// var env6L2 = presetParams[152];
	// var env6L3 = presetParams[153];
	// var env6L4 = presetParams[154];
	// var env6R0 = presetParams[155];
	// var env6R1 = presetParams[156];
	// var env6R2 = presetParams[157];
	// var env6R3 = presetParams[158];
	// var env6C0 = presetParams[159];
	// var env6C1 = presetParams[160];
	// var env6C2 = presetParams[161];
	// var env6C3 = presetParams[162];
	// var modSens6 = presetParams[163];
	// var envPL0 = presetParams[164];
	// var envPL1 = presetParams[165];
	// var envPL2 = presetParams[166];
	// var envPL3 = presetParams[167];
	// var envPL4 = presetParams[168];
	// var envPR0 = presetParams[169];
	// var envPR1 = presetParams[170];
	// var envPR2 = presetParams[171];
	// var envPR3 = presetParams[172];
	// var osc_sync = presetParams[173];
    // 0.0;
};
);


~setParamsFromPreset = {|presetIndex|
	var presetParams = ~loadedData[presetIndex];
	var outMult, dn0, dn1,dn2, dn3, dn4, dn5, dn6, dn7, dn8, dn9, dn10, dn11, dn12, dn13, dn14, dn15, dn16, dn17, dn18, dn20, dn21, dn22, dn23, dn24, dn25, dn26, dn27, dn28, dn29, dn30, dn31, dn32, dn33, dn34, dn35, dn36, dn37, dn38, dn39, dn40, dn41,
	pitch,amp,detun1,noteBlok1,detun2,noteBlok2,detun3,noteBlok3,detun4,noteBlok4,detun5,noteBlok5,detun6,noteBlok6, coars1, fine_1,
	env1L0 ,env1L1 ,env1L2 ,env1L3 ,env1L4 ,env1R0 ,env1R1 ,env1R2 ,env1R3 ,env1C0 ,env1C1 ,env1C2 ,env1C3 ,modSens1 ,coars2 ,fine_2 ,env2L0 ,env2L1 ,env2L2 ,env2L3 ,env2L4 ,env2R0 ,env2R1 ,env2R2 ,env2R3 ,env2C0 ,env2C1 ,env2C2 ,env2C3 ,modSens2 ,coars3 ,fine_3 ,env3L0 ,env3L1 ,env3L2 ,env3L3 ,env3L4 ,env3R0 ,env3R1 ,env3R2 ,env3R3 ,env3C0 ,env3C1 ,env3C2 ,env3C3 ,modSens3 ,coars4 ,fine_4 ,env4L0 ,env4L1 ,env4L2 ,env4L3 ,env4L4 ,env4R0 ,env4R1 ,env4R2 ,env4R3 ,env4C0 ,env4C1 ,env4C2 ,env4C3 ,modSens4 ,coars5 ,fine_5 ,env5L0 ,env5L1 ,env5L2 ,env5L3 ,env5L4 ,env5R0 ,env5R1 ,env5R2 ,env5R3 ,env5C0 ,env5C1 ,env5C2 ,env5C3 ,modSens5 ,coars6 ,fine_6 ,env6L0 ,env6L1 ,env6L2 ,env6L3 ,env6L4 ,env6R0 ,env6R1 ,env6R2 ,env6R3 ,env6C0 ,env6C1 ,env6C2 ,env6C3 ,modSens6 ,envPL0 ,envPL1 ,envPL2 ,envPL3 ,envPL4 ,envPR0 ,envPR1 ,envPR2 ,envPR3 ,osc_sync;

	// outMult = presetParams[0];
	// dn0  = presetParams[1];
	// dn1  = presetParams[2];
	// dn2  = presetParams[3];
	// dn3  = presetParams[4];
	// dn4  = presetParams[5];
	// dn5  = presetParams[6];
	// dn6  = presetParams[7];
	// dn7  = presetParams[8];
	// dn8  = presetParams[9];
	// dn9  = presetParams[10];
	// dn10 = presetParams[11];
	// dn11 = presetParams[12];
	// dn12 = presetParams[13];
	// dn13 = presetParams[14];
	// dn14 = presetParams[15];
	// dn15 = presetParams[16];
	// dn16 = presetParams[17];
	// dn17 = presetParams[18];
	// dn18 = presetParams[19];
	// dn20 = presetParams[20];
	// dn21 = presetParams[21];
	// dn22 = presetParams[22];
	// dn23 = presetParams[23];
	// dn24 = presetParams[24];
	// dn25 = presetParams[25];
	// dn26 = presetParams[26];
	// dn27 = presetParams[27];
	// dn28 = presetParams[28];
	// dn29 = presetParams[29];
	// dn30 = presetParams[30];
	// dn31 = presetParams[31];
	// dn32 = presetParams[32];
	// dn33 = presetParams[33];
	// dn34 = presetParams[34];
	// dn35 = presetParams[35];
	// dn36 = presetParams[36];
	// dn37 = presetParams[37];
	// dn38 = presetParams[38];
	// dn39 = presetParams[39];
	// dn40 = presetParams[40];
	// dn41 = presetParams[41];
	// pitch = presetParams[42];
	// amp = presetParams[43];
	// detun1 = presetParams[46];
	// noteBlok1 = presetParams[47];
	// detun2 = presetParams[50];
	// noteBlok2 = presetParams[51];
	// detun3 = presetParams[54];
	// noteBlok3 = presetParams[55];
	// detun4 = presetParams[58];
	// noteBlok4 = presetParams[59];
	// detun5 = presetParams[62];
	// noteBlok5 = presetParams[63];
	// detun6 = presetParams[66];
	// noteBlok6 = presetParams[67];
	// coars1 = presetParams[68];
	// fine_1 = presetParams[69]	;
	// env1L0 = presetParams[70];
	// env1L1 = presetParams[71];
	// env1L2 = presetParams[72];
	// env1L3 = presetParams[73];
	// env1L4 = presetParams[74];
	// env1R0 = presetParams[75];
	// env1R1 = presetParams[76];
	// env1R2 = presetParams[77];
	// env1R3 = presetParams[78];
	// env1C0 = presetParams[79];
	// env1C1 = presetParams[80];
	// env1C2 = presetParams[81];
	// env1C3 = presetParams[82];
	// modSens1 = presetParams[83];
	// coars2 = presetParams[84];
	// fine_2 = presetParams[85];
	// env2L0 = presetParams[86];
	// env2L1 = presetParams[87];
	// env2L2 = presetParams[88];
	// env2L3 = presetParams[89];
	// env2L4 = presetParams[90];
	// env2R0 = presetParams[91];
	// env2R1 = presetParams[92];
	// env2R2 = presetParams[93];
	// env2R3 = presetParams[94];
	// env2C0 = presetParams[95];
	// env2C1 = presetParams[96];
	// env2C2 = presetParams[97];
	// env2C3 = presetParams[98];
	// modSens2 = presetParams[99];
	// coars3 = presetParams[100];
	// fine_3 = presetParams[101];
	// env3L0 = presetParams[102];
	// env3L1 = presetParams[103];
	// env3L2 = presetParams[104];
	// env3L3 = presetParams[105];
	// env3L4 = presetParams[106];
	// env3R0 = presetParams[107];
	// env3R1 = presetParams[108];
	// env3R2 = presetParams[109];
	// env3R3 = presetParams[110];
	// env3C0 = presetParams[111];
	// env3C1 = presetParams[112];
	// env3C2 = presetParams[113];
	// env3C3 = presetParams[114];
	// modSens3 = presetParams[115];
	// coars4 = presetParams[116];
	// fine_4 = presetParams[117];
	// env4L0 = presetParams[118]	;
	// env4L1 = presetParams[119];
	// env4L2 = presetParams[120];
	// env4L3 = presetParams[121];
	// env4L4 = presetParams[122];
	// env4R0 = presetParams[123];
	// env4R1 = presetParams[124];
	// env4R2 = presetParams[125];
	// env4R3 = presetParams[126];
	// env4C0 = presetParams[127];
	// env4C1 = presetParams[128];
	// env4C2 = presetParams[129];
	// env4C3 = presetParams[130];
	// modSens4 = presetParams[131];
	// coars5 = presetParams[132];
	// fine_5 = presetParams[133];
	// env5L0 = presetParams[134];
	// env5L1 = presetParams[135];
	// env5L2 = presetParams[136];
	// env5L3 = presetParams[137];
	// env5L4 = presetParams[138];
	// env5R0 = presetParams[139];
	// env5R1 = presetParams[140];
	// env5R2 = presetParams[141];
	// env5R3 = presetParams[142];
	// env5C0 = presetParams[143];
	// env5C1 = presetParams[144];
	// env5C2 = presetParams[145];
	// env5C3 = presetParams[146];
	// modSens5 = presetParams[147];
	// coars6 = presetParams[148];
	// fine_6 = presetParams[149];
	// env6L0 = presetParams[150];
	// env6L1 = presetParams[151];
	// env6L2 = presetParams[152];
	// env6L3 = presetParams[153];
	// env6L4 = presetParams[154];
	// env6R0 = presetParams[155];
	// env6R1 = presetParams[156];
	// env6R2 = presetParams[157];
	// env6R3 = presetParams[158];
	// env6C0 = presetParams[159];
	// env6C1 = presetParams[160];
	// env6C2 = presetParams[161];
	// env6C3 = presetParams[162];
	// modSens6 = presetParams[163];
	// envPL0 = presetParams[164];
	// envPL1 = presetParams[165];
	// envPL2 = presetParams[166];
	// envPL3 = presetParams[167];
	// envPL4 = presetParams[168];
	// envPR0 = presetParams[169];
	// envPR1 = presetParams[170];
	// envPR2 = presetParams[171];
	// envPR3 = presetParams[172];
	// osc_sync = presetParams[173];

    ~dx7_control_bufs.set(presetParams);

    0.0;
};









// ~dx7_control_bufs = Bus.control(s, 174);

~dx7_presetCount = 20;
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
	~dx7_presets_values[i].postln;
});
// ~dx7_control_bus = Bus.control(s, 175);
~dx7_preset_buffer = Buffer.alloc(s, ~dx7_presetCount * ~dx7_presets_values[0].size, 1); // 4 presets with 4 parameters each
~dx7_preset_buffer.setn(0, ~dx7_presets_values.flat);
// ~dx7_control_bufs = Bus.control(s, 174);











/* -- LFO Synth for vibrato and tremolo -- instantiate this synth first */ 
SynthDef( 'InfEfx_tst' , {
arg outBus=0, gate = nil , lfoGet1 = 0, lfoGet2 = 1,
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



(
/* -- DX7 Synth -- use 'addToTail' when instantiating this synth */ 
SynthDef( 'DX7_tst' ,{

arg outBus=0, pitch= 97.998858995437 , gate = 1, envPL0= 0.0 , envPL1= 0.0 , envPL2= 0.0 ,envPL3= 0.0 ,
envPL4= 0.0 , envPR0= 0.0 ,envPR1= 0.0 ,
envPR2= 0.0 ,envPR3= 0.0 ,coars1= 0.5 ,
fine_1= 1.3 ,coars2= 1 ,fine_2= 1.0 ,
coars3= 0.5 ,fine_3= 1.99 ,coars4= 0.5 ,
fine_4= 1.99 ,coars5= 1 ,fine_5= 1.0 ,
coars6= 8 ,fine_6= 1.0 ,env1L0= 74.90380068726 ,
env1L1= 0.6538005016345 ,env1L2= 2.1538005053845 ,env1L3= 2.1538005053845 ,
env1L4= 74.90380068726 ,env1R0= 0.024221249 ,env1R1= 0.15341901234257 ,
env1R2= 0.0 ,env1R3= 1.8511723207791 ,env1C0= 3 ,
env1C1= -3 ,env1C2= -3 ,env1C3= -3 ,
env2L0= 87.0000002175 ,env2L1= 18.000000045 ,env2L2= 18.000000045 ,
env2L3= 18.000000045 ,env2L4= 87.0000002175 ,env2R0= 0.00035859185 ,
env2R1= 0.0 ,env2R2= 0.0 ,env2R3= 7.0695183846855 ,
env2C0= 3 ,env2C1= -3 ,env2C2= -3 ,
env2C3= -3 ,env3L0= 74.90380068726 ,env3L1= 0.6538005016345 ,
env3L2= 2.1538005053845 ,env3L3= 2.1538005053845 ,env3L4= 74.90380068726 ,
env3R0= 0.024221249 ,env3R1= 0.17141308922609 ,env3R2= 0.0 ,
env3R3= 1.8511723207791 ,env3C0= 3 ,env3C1= -3 ,
env3C2= -3 ,env3C3= -3 ,env4L0= 75.43586718859 ,
env4L1= 9.4358670235897 ,env4L2= 9.4358670235897 ,env4L3= 9.4358670235897 ,
env4L4= 75.43586718859 ,env4R0= 0.00050529185 ,env4R1= 0.0 ,
env4R2= 0.0 ,env4R3= 2.996897285981 ,env4C0= 3 ,
env4C1= -3 ,env4C2= -3 ,env4C3= -3 ,
env5L0= 92.46793373117 ,env5L1= 18.217933545545 ,env5L2= 18.217933545545 ,
env5L3= 18.217933545545 ,env5L4= 92.46793373117 ,env5R0= 0.00033414185 ,
env5R1= 0.0 ,env5R2= 0.0 ,env5R3= 3.5885856943932 ,
env5C0= 3 ,env5C1= -3 ,env5C2= -3 ,
env5C3= -3 ,env6L0= 99.025534747564 ,env6L1= 24.775534561939 ,
env6L2= 32.275534580689 ,env6L3= 32.275534580689 ,env6L4= 99.025534747564 ,
env6R0= 0.00614021685 ,env6R1= 0.017670384940926 ,env6R2= 0.0 ,
env6R3= 2.927061792015 ,env6C0= 3 ,env6C1= -3 ,
env6C2= -3 ,env6C3= -3 ,noteBlok1= 0 ,
noteBlok2= 1 ,noteBlok3= 1 ,
noteBlok4= 1 ,noteBlok5= 1 ,
noteBlok6= 1 ,
dn0= 0 ,dn1= 12.566370614359 ,dn2= 0 ,dn3= 0 ,
dn4= 0 ,dn5= 0 ,dn6= 0 ,dn7= 5.5417694409324 ,
dn8= 0 ,dn9= 0 ,dn10= 0 ,dn11= 0 ,
dn12= 0 ,dn13= 0 ,dn14= 0 ,dn15= 12.566370614359 ,
dn16= 0 ,dn17= 0 ,dn18= 0 ,dn19= 0 ,
dn20= 0 ,dn21= 0 ,dn22= 12.566370614359 ,dn23= 12.566370614359 ,
dn24= 0 ,dn25= 0 ,dn26= 0 ,dn27= 0 ,
dn28= 0 ,dn29= 0 ,dn30= 0 ,dn31= 0 ,
dn32= 0 ,dn33= 0 ,dn34= 0 ,dn35= 0 ,
dn36= 1 ,dn37= 0 ,dn38= 1 ,dn39= 0 ,
dn40= 0 ,dn41= 0 ,detun1= 39 ,
detun2= 5 ,detun3= 1 ,detun4= 14 ,
detun5= 14 ,detun6= 14 ,modSens1= 0 ,
modSens2= 0 ,modSens3= 0 ,modSens4= 0 ,
modSens5= 0 ,modSens6= 0 ,outMult= -1 ,
osc_sync= 0 ,transpose= nil ,gate1=1,gate1Rel = 1,
dx7_amp=0.1,totVol= nil, presetIndex= 0;

// PARAMS SENT BY TIDAL
// [ "/s_new", "dirt_gate2", -1, 1, 15681, "in", 132, "out", 134, "amp", 0.4, "gain", 2, "overgain", 0, "sample", 394116296, "cut", 0, "sustain", 27.4275, "fadeInTime", 0, "fadeTime", 0.001 ]

// arg outBus=(0), pitch= (-1) , gate = (-1), envPL0= (-1) , envPL1= (-1) , envPL2= (-1) ,envPL3= (-1) , envPL4= (-1) , envPR0= (-1) ,envPR1= (-1), envPR2= (-1) ,envPR3= (-1) ,coars1= (-1) , fine_1=(-1),coars2=(-1),fine_2=(-1), coars3=(-1),fine_3=(-1),coars4=(-1), fine_4=(-1),coars5=(-1),fine_5=(-1), coars6=(-1),fine_6=(-1),env1L0=(-1), env1L1=(-1),env1L2=(-1),env1L3=(-1), env1L4=(-1),env1R0=(-1),env1R1=(-1), env1R2=(-1),env1R3=(-1),env1C0=(-1), env1C1=(-1),env1C2=(-1),env1C3=(-1), env2L0=(-1),env2L1=(-1),env2L2=(-1), env2L3=(-1),env2L4=(-1),env2R0=(-1), env2R1=(-1),env2R2=(-1),env2R3=(-1), env2C0=(-1),env2C1=(-1),env2C2=(-1), env2C3=(-1),env3L0=(-1),env3L1=(-1), env3L2=(-1),env3L3=(-1),env3L4=(-1), env3R0=(-1),env3R1=(-1),env3R2=(-1), env3R3=(-1),env3C0=(-1),env3C1=(-1), env3C2=(-1),env3C3=(-1),env4L0=(-1), env4L1=(-1),env4L2=(-1),env4L3=(-1), env4L4=(-1),env4R0=(-1),env4R1=(-1), env4R2=(-1),env4R3=(-1),env4C0=(-1), env4C1=(-1),env4C2=(-1),env4C3=(-1), env5L0=(-1),env5L1=(-1),env5L2=(-1), env5L3=(-1),env5L4=(-1),env5R0=(-1), env5R1=(-1),env5R2=(-1),env5R3=(-1), env5C0=(-1),env5C1=(-1),env5C2=(-1), env5C3=(-1),env6L0=(-1),env6L1=(-1), env6L2=(-1),env6L3=(-1),env6L4=(-1), env6R0=(-1),env6R1=(-1),env6R2=(-1), env6R3=(-1),env6C0=(-1),env6C1=(-1), env6C2=(-1),env6C3=(-1),noteBlok1=(-1), noteBlok2=(-1),noteBlok3=(-1), noteBlok4=(-1),noteBlok5=(-1), noteBlok6=(-1), dn0=(-1),dn1=(-1),dn2=(-1),dn3=(-1), dn4=(-1),dn5=(-1),dn6=(-1),dn7=(-1), dn8=(-1),dn9=(-1),dn10=(-1),dn11=(-1), dn12=(-1),dn13=(-1),dn14=(-1),dn15=(-1), dn16=(-1),dn17=(-1),dn18=(-1),dn19=(-1), dn20=(-1),dn21=(-1),dn22=(-1),dn23=(-1), dn24=(-1),dn25=(-1),dn26=(-1),dn27=(-1), dn28=(-1),dn29=(-1),dn30=(-1),dn31=(-1), dn32=(-1),dn33=(-1),dn34=(-1),dn35=(-1), dn36=(-1),dn37=(-1),dn38=(-1),dn39=(-1), dn40=(-1),dn41=(-1),detun1=(-1), detun2=(-1),detun3=(-1),detun4=(-1), detun5=(-1),detun6=(-1),modSens1=(-1), modSens2=(-1),modSens3=(-1),modSens4=(-1), modSens5=(-1),modSens6=(-1),outMult=(-1), osc_sync=(-1),transpose=(-1),gate1=(-1),gate1Rel =(-1), amp=(-1),totVol=(-1), 
// presetIndex= 0;


var ctls, mods, chans, out, kilnod,
envAmp1, envEnv1, envAmp2, envEnv2, envAmp3, envEnv3 ,envAmp4, envEnv4, envAmp5, envEnv5, envAmp6, envEnv6, dca, envAmpP, envEnvP,presetParams;
var huh, amp;

// pitch = 97;

// outBus=(0); pitch= (-1) ; gate = (-1); envPL0= (-1) ; envPL1= (-1) ; envPL2= (-1) ;envPL3= (-1) ; envPL4= (-1) ; envPR0= (-1) ;envPR1= (-1); envPR2= (-1) ;envPR3= (-1) ;coars1= (-1) ; fine_1=(-1);coars2=(-1);fine_2=(-1); coars3=(-1);fine_3=(-1);coars4=(-1); fine_4=(-1);coars5=(-1);fine_5=(-1); coars6=(-1);fine_6=(-1);env1L0=(-1); env1L1=(-1);env1L2=(-1);env1L3=(-1); env1L4=(-1);env1R0=(-1);env1R1=(-1); env1R2=(-1);env1R3=(-1);env1C0=(-1); env1C1=(-1);env1C2=(-1);env1C3=(-1); env2L0=(-1);env2L1=(-1);env2L2=(-1); env2L3=(-1);env2L4=(-1);env2R0=(-1); env2R1=(-1);env2R2=(-1);env2R3=(-1); env2C0=(-1);env2C1=(-1);env2C2=(-1); env2C3=(-1);env3L0=(-1);env3L1=(-1); env3L2=(-1);env3L3=(-1);env3L4=(-1); env3R0=(-1);env3R1=(-1);env3R2=(-1); env3R3=(-1);env3C0=(-1);env3C1=(-1); env3C2=(-1);env3C3=(-1);env4L0=(-1); env4L1=(-1);env4L2=(-1);env4L3=(-1); env4L4=(-1);env4R0=(-1);env4R1=(-1); env4R2=(-1);env4R3=(-1);env4C0=(-1); env4C1=(-1);env4C2=(-1);env4C3=(-1); env5L0=(-1);env5L1=(-1);env5L2=(-1); env5L3=(-1);env5L4=(-1);env5R0=(-1); env5R1=(-1);env5R2=(-1);env5R3=(-1); env5C0=(-1);env5C1=(-1);env5C2=(-1); env5C3=(-1);env6L0=(-1);env6L1=(-1); env6L2=(-1);env6L3=(-1);env6L4=(-1); env6R0=(-1);env6R1=(-1);env6R2=(-1); env6R3=(-1);env6C0=(-1);env6C1=(-1); env6C2=(-1);env6C3=(-1);noteBlok1=(-1); noteBlok2=(-1);noteBlok3=(-1); noteBlok4=(-1);noteBlok5=(-1); noteBlok6=(-1); dn0=(-1);dn1=(-1);dn2=(-1);dn3=(-1); dn4=(-1);dn5=(-1);dn6=(-1);dn7=(-1); dn8=(-1);dn9=(-1);dn10=(-1);dn11=(-1); dn12=(-1);dn13=(-1);dn14=(-1);dn15=(-1); dn16=(-1);dn17=(-1);dn18=(-1);dn19=(-1); dn20=(-1);dn21=(-1);dn22=(-1);dn23=(-1); dn24=(-1);dn25=(-1);dn26=(-1);dn27=(-1); dn28=(-1);dn29=(-1);dn30=(-1);dn31=(-1); dn32=(-1);dn33=(-1);dn34=(-1);dn35=(-1); dn36=(-1);dn37=(-1);dn38=(-1);dn39=(-1); dn40=(-1);dn41=(-1);detun1=(-1); detun2=(-1);detun3=(-1);detun4=(-1); detun5=(-1);detun6=(-1);modSens1=(-1); modSens2=(-1);modSens3=(-1);modSens4=(-1); modSens5=(-1);modSens6=(-1);outMult=(-1); osc_sync=(-1);transpose=(-1);gate1=(-1);gate1Rel =(-1); dx7_amp=(-1);totVol=(-1); 
outMult = -1;


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

// h = {arg param, i; Select.kr((param+1).clip(0,1), [BufRd.kr(1, ~dx7_preset_buffer, i + (presetIndex * 175)), param]); };
h = {arg param, i; Select.kr(0, [BufRd.kr(1, ~dx7_preset_buffer, i + (presetIndex * 175)), param]); };

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
pitch = h.value(pitch, 43);
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
out = FM7.ar(ctls, mods).slice(chans) * -12.dbamp;
out = Mix.new([ // this is how the synthdef mutes channels - all are summed, but some are multiplied by zeros
(out[0] * 1 * dn36),
(out[1] * 1 * dn37),
(out[2] * 1 * dn38),
(out[3] * 1 * dn39),
(out[4] * 1 * dn40),
(out[5] * 1 * dn41),
]);

FreeSelfWhenDone.kr(Line.kr(0, 1, 10));
kilnod = DetectSilence.ar(out, 0.01, 0.2, doneAction:2);
out = out / outMult;
Out.ar(outBus, out.dup);
}).add;
)



