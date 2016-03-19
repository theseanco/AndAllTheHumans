p.fadeTime=3

//after the jungle
(
~vperc.fadeTime=0;
~vperc = {JPverb.ar(PlayBuf.ar(2,d["p1"][0],1,Impulse.kr(0.1)),10,0,5,0.4,0.2,2)};
~gperc = {arg time = 2, fb = 0.9; Greyhole.ar(PlayBuf.ar(2,d["p1"][3],1,1),time,0,0.2,0.707,fb,0.1,2)};
b = Buffer.alloc(s,44100 * 2, 2);
~gperc = {arg time = 0.1, fb = 1, speed=1, density = 1, sr = 44100, bit=24; LeakDC.ar(Decimator.ar(CombC.ar(PlayBuf.ar(2,d["p1"][3],speed,Dust.kr(density)),1,time,fb,1),sr,bit))};
c.knob1.onChanged = {|val| "gperctime = ".post; ~gperc.set(\time,val.linlin(0,127,0.03,1.9).postln;)};
c.knob2.onChanged = {|val| "gpercfb = ".post; ~gperc.set(\fb,val.linlin(0,127,0.1,40).postln;)};
c.knob3.onChanged = {|val| "gpercbspeed = ".post; ~gperc.set(\speed,val.linlin(0,127,0.1,3).postln;)};
c.knob4.onChanged = {|val| "gpercbdensity = ".post; ~gperc.set(\density,val.linlin(0,127,1,8).postln;)};
c.knob5.onChanged = {|val| "S/R = ".post; ~gperc.set(\sr,val.linlin(1,127,100,30100).asInt.postln;)};
c.knob6.onChanged = {|val| "BITRATE = ".post; ~gperc.set(\bit,val.linlin(0,127,1,24).asInt.postln;)};
~vperc.play;
)

//butoh movement
~vperc.play;

//charlie's speech
~gperc.play;

//get the fb thing going super madly before the end of Charlie's speech. Afterwards...

~vperc.stop;
//Turn down knob four, three full, two quarter, one three quarter
// five empty, six empty, modulate five.


//after Charlie's speech
//as squirming happens, gradually decreae duration
(
~siner = Pbind(\instrument,\sinfb,\dur,0.8,\atk,1,\rel,1,\scale,Scale.chromatic24(Tuning.et24),\root,-3,\degree,Pseq((0..24),inf),\octave,Pwrand([5,4,3],[5,2,1].normalizeSum,inf));
~siner.play;
)



(
~siner.stop(20);
~gperc.stop(20);
~vperc.stop(2);
)

//cleanup
(
~siner.clear;
~gperc.clear;
~vperc.clear;
)

// //RISSET RHYTHM DURING FIGHT SCENE. I need a cue.
// //definitely after Alys vomiting though.
//
b = Buffer.read(s,"/home/smc/Documents/Samples/SpokenUtopia/DrumGroove/SUNTUNNELSdrumsgrooveOne87bpm.wav"); // Provide a simple breakbeat loop
// (
// var ampTable = Signal.hanningWindow(1024,100).squared;
// var ampBuf = Buffer.loadCollection(s, ampTable);
//
//
// SynthDef("accelerando_inf1", { arg out=0,bufnum=0;
//
// 	var pos, posses, pitches, amps, sons;
//
// 	// "pos" is a kind of master pitch control, linear varying between one and zero
// 	pos = Phasor.ar(1, 0.007 / SampleRate.ir, 0, 1);
//
// 	posses = (pos + ((0..4)/5)).wrap(0.0, 1.0); // Evenly spaced circularly within 0 to 1
//
// 	pitches = (0.2 * 2.0.pow(posses * 5));
//
// 	amps = BufRd.kr(1, ampBuf.bufnum, posses * BufFrames.ir(ampBuf.bufnum));
//
// 	sons = (PlayBuf.ar(1, bufnum, pitches.poll(1), loop:1) * amps * 10);
//
// 	Out.ar(0,
// 		Pan2.ar(sons.mean.softclip)
// 	)
// }).add;
// )
//
// q = Synth("accelerando_inf1",[\bufnum,b])
// q.release(2)
// q.stop

//trigger THIS when fight starts
b = Buffer.read(s,"/home/smc/Documents/Samples/SpokenUtopia/DrumGroove/SUNTUNNELSdrumsgrooveOne87bpm.wav"); // Provide a simple breakbeat loop
(
var ampTable = Signal.hanningWindow(1024,100).squared;
var ampBuf = Buffer.loadCollection(s, ampTable);
~risset = { arg out=0,bufnum=0,amp=1;
	var pos, posses, pitches, amps, sons;
	// "pos" is a kind of master pitch control, linear varying between one and zero
	pos = Phasor.ar(1, 0.007 / SampleRate.ir, 0, 1);
	posses = (pos + ((0..4)/5)).wrap(0.0, 1.0); // Evenly spaced circularly within 0 to 1
 	pitches = (0.2 * 2.0.pow(posses * 5));
	amps = BufRd.kr(1, ampBuf.bufnum, posses * BufFrames.ir(ampBuf.bufnum));
	sons = (PlayBuf.ar(1, b, pitches.poll(1), loop:1) * amps * 10);
	Out.ar(0,
		Pan2.ar(sons.mean.softclip,0,amp)
	)
};
~risset.play;
c.fader1.onChanged = {|val| "rissetvol = ".post; ~risset.set(\amp,val.linlin(0,127,0,1).postln;)};
(
~siner.stop(20);
~gperc.stop(20);
~vperc.stop(2);
)
)



//fadeout of risset drums at end of war.
(
~rissetline = {Line.kr(1,0,10)};
~risset.set(\amp,~rissetline);
)


//when peter starts moving rosie off of her chair, fade out to silence


//then there's the child's birthday party section...
TODO:
//Orchestral drums?
(
~childrums = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pseq([1,0.5],inf)/3,\amp,1,\rate,Pseq([1,0.8],inf));
~childhats = Pbind(\instrument,\bplay,\buf,d["h"][5],\dur,0.5,\rate,0.8,\amp,1);
~childsnare = Pbind(\instrument,\bplay,\buf,d["sn"][4],\rate,5,\dur,1/3/2,\amp,1);
~childperc = Pbind(\instrument,\bplay,\buf,d["p1"][4],\rate,Pseq([1,0.8,0.6,0.4],inf)*Pwhite(1,5).stutter(8),\dur,1/3/2/2,\amp,3);
~childchaos = Pbind(\instrument,\bplay,\buf,d["k2"][2],\amp,1.3,\dur,Pwhite(0.5,2.0))
)

//musical chairs:

//1
(
~childrums.play;
~risset.clear;
)

//risset cleanup
(
~risset.clear;
)

//2
(
~childrums.play;
~childhats.play;
)

//3
(
~childrums.play;
~childhats.play;
~childsnare.play;
)

//4
(
~childrums.play;
~childhats.play;
~childsnare.play;
~childperc.play;
)

//5 - fight
(
~childperc = Pbind(\instrument,\bplay,\buf,d["p1"][4],\rate,Pseq([1,0.8,0.6,0.4],inf)*Pwhite(1,10).stutter(8),\dur,1/3/2/2/Pwhite(2,14).round(2).stutter(8),\amp,3);
~childrums = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pseq([1,0.5],inf)/6,\amp,1,\rate,Pseq([1,7],inf));
~childrums.play;
~childhats.play;
~childsnare.play;
~childperc.play;
~childchaos.play;
)
//stop the music when alysia sits down.


(
~childrums.stop(5);
~childhats.stop(5);
~childsnare.stop(5);
~childperc.stop(5);
~childchaos.stop(5);
~drone = Pbind(\instrument,\sinfb,\dur,1,\degree,Pwrand([0,2,4,6],[2,2,2,0.5].normalizeSum,inf),\atk,3,\rel,3,\scale,Scale.minor,\root,4,\octave,4,\fb,Pexprand(0.00001,0.6));
~drone.play;
)
