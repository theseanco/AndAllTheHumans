// ACT 3

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

//when peter starts moving rosie off of her chair, trigger this to fade out to silence
//fadeout of risset drums at end of war.
(
~rissetline = {Line.kr(1,0,10)};
~risset.set(\amp,~rissetline);
)



//then there's the child's birthday party section...
(
~childrums = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pseq([1,0.5],inf)/3,\amp,1,\rate,Pseq([1,0.8],inf));
~childhats = Pbind(\instrument,\bplay,\buf,d["h"][5],\dur,0.5,\rate,0.8,\amp,1);
~childsnare = Pbind(\instrument,\bplay,\buf,d["sn"][4],\rate,5,\dur,1/3/2,\amp,1);
~childperc = Pbind(\instrument,\bplay,\buf,d["p1"][4],\rate,Pseq([1,0.8,0.6,0.4],inf)*Pwhite(1,5).stutter(8),\dur,1/3/2/2,\amp,3);
~childchaos = Pbind(\instrument,\bplay,\buf,d["k2"][2],\amp,1.3,\dur,Pwhite(0.5,2.0))
)

//musical chairs, when alysia drops chair:

//1
(
~childrums.play;
~risset.clear;
)

~childrums.stop;


//2
(
~childrums.play;
~childhats.play;
)

(
~childrums.stop;
~childhats.stop;
)

//3
(
~childrums.play;
~childhats.play;
~childsnare.play;
)

(
~childrums.stop;
~childhats.stop;
~childsnare.stop;
)


//4
(
~childrums.play;
~childhats.play;
~childsnare.play;
~childperc.play;
)

(
~childrums.stop;
~childhats.stop;
~childsnare.stop;
~childperc.stop;
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

//put accordion down

//shit party begins

//set knob 1 and 2 and 4 to full, 3 to empty

p.fadeTime=3;

MIDIFunc.trace(false)

//stop drone
~drone.stop(3)

(
~partymusic.fadeTime=0;
~effectparty.fadeTime=0;
~partysine.fadeTime=0;
~partymusic = {arg speed = 1; PlayBuf.ar(2,d["party"][0],speed,1,0,1)*1.4};
~effectparty = {
	arg waveloss = 1, bit = 24, srate = 44100, freq = 440, res = 0.999999, xfade = (-1), type = 0;
	var sig = Decimator.ar(WaveLoss.ar(~partymusic.ar,waveloss,40,1),srate,bit);
	XFade2.ar(sig,DFM1.ar(sig,SinOsc.ar(0.01).range(100,3000),res,1,type),xfade);

};
~partysine = {1};
// ~partysine.fadeTime=0.1;.
// ~partymusic.set(\speed,~partysine);
~effectparty.play;
)


//As the dance scene continues, gradually modulate filter on knob 3 and 4, gradually decrease speed on knob 2

//as things get more fucked up, ratchet the speed down and increase waveloss using knob 1.

(
//here are the controls
c.knob1.onChanged = {|val| "waveloss = ".post; ~effectparty.set(\waveloss,val.linlin(0,127,40,0).asInt.postln;)};
c.knob2.onChanged = {|val| "musicspeed = ".post; ~partysine = val.linlin(0,127,0.15,1).postln;};
c.knob3.onChanged = {|val| "filterwet = ".post; ~effectparty.set(\xfade,val.linlin(0,127,-1,1.0).postln;)};
c.knob4.onChanged = {|val| "filtertype = ".post; ~effectparty.set(\type,val.linlin(0,127,0,1.0).postln;)};
)


//By the smack scene things need to be very slow with a lot of waveloss. There's some optional speed code going on VVVV

/////////OPTIONAL START

//trigger this after Peter is down.
(
~partysine = {TRand.kr(0.15,0.3,Dust.kr(1))};
~effectparty.set(\waveloss,4);
)
//as things get more fucked up
~partysine = {TChoose.kr(Dust.kr(20),[0.15!10,0.2!10,0.21!2,0.22!4,0.24!2,0.23!5,1,1.2,1.4].flat)};
///////OPTIONAL END

(
~partymusic.stop(10);
~effectparty.stop(10);
)

//TODO: Smack scene transition tidyup


//everyone has moved away

//redux of disco music
(
p.clock.tempo=135/60;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~sn = Pbind(\instrument,\bplay,\buf,d["cp"][0],\dur,2,\amp,1,\rate,1);
~stab = Pbind(\instrument,\bplay,\buf,d["edmstab"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1,0.9,1.1].stutter(3),inf));
~stab2 = Pbind(\instrument,\bplay,\buf,d["edmstab"][0],\dur,Pbjorklund2(Pwhite(2,7),8)/4,\amp,1,\rate,Pseq([1,1,0.9,1.1].stutter(3),inf)*2);
~stab3 = Pbind(\instrument,\bplay,\buf,d["edmstab"][0],\dur,Pbjorklund2(Pwhite(2,15),16)/8,\amp,1,\rate,Pseq([1,1,0.9,1.1].stutter(3),inf)*4);
~sweep = Pbind(\instrument,\bplay,\buf,d["edmsweep"][0],\amp,4,\dur,32);
~disco = Pbind(\instrument,\bplay,\buf,d["dj"][0],\amp,1,\dur,40);
)

//dance music starts, gradually bring these things in
//clear sets of two eights, every other eight.
~k.play;
~sweep.play;
~h.play;
~sn.play;
~disco.play;
~stab.play; //alys in by now
~stab2.play;
~stab3.play;


(
//trigger when howling
~k.stop(15);
~sweep.stop(8);
~h.stop(8);
~sn.stop(8);
~disco.stop(4);
~stab.stop(4);
~stab2.stop(2);
~stab3.stop(1);
)

//cleanup
(
~k.clear;
~sweep.clear;
~h.clear;
~sn.clear;
~disco.clear;
~stab.clear;
~stab2.clear;
~stab3.clear;
)

//peter's march begins

(
//when rosie stands
p.clock.tempo=120/60;
~march = Pbind(\instrument,\bplay,\buf,d["march"][0],\dur,8,\amp,2);
~thump = Pbind(\instrument,\sinfb,\dur,8,\degree,2,\octave,3,\rel,3);
~whine = {Warp1.ar(1,d["whine"][0],SinOsc.kr(0.1),0.2,0.5,-1,8,0.01,4,0.5)!2};
~march.play;
Task({
	10.wait;
	~thump.play;
	10.wait;
	~whine.play;
}).start;
)

(
//trigger this when peter comes puts the suits down.
~march.stop(5);
~whine.stop(10);
~thump.stop(15);
)
