//put accordion down

//shit party begins

//set knob 1 and 2 and 4 to full, 3 to empty

p.fadeTime=3;




(
~partymusic.fadeTime=0;
~effectparty.fadeTime=0;
~partysine.fadeTime=0;
~partymusic = {arg speed = 0.98; PlayBuf.ar(2,d["party"][0],speed,1,0,1)*1.4};
~effectparty = {
	arg waveloss = 1, bit = 24, srate = 44100, freq = 440, res = 0.999999, xfade = (-1), type = 0;
	var sig = Decimator.ar(WaveLoss.ar(~partymusic.ar,waveloss,40,1),srate,bit);
	XFade2.ar(sig,DFM1.ar(sig,SinOsc.ar(0.01).range(100,3000),res,1,type),xfade);
};
~partymusic.set(\speed,~partysine);
~effectparty.play;
c.knob1.onChanged = {|val| "waveloss = ".post; ~effectparty.set(\waveloss,val.linlin(0,127,40,0).asInt.postln;)};
c.knob2.onChanged = {|val| "musicspeed = ".post; ~partysine = val.linlin(0,127,0.15,1).postln;};
c.knob3.onChanged = {|val| "filterwet = ".post; ~effectparty.set(\xfade,val.linlin(0,127,-1,1.0).postln;)};
c.knob4.onChanged = {|val| "filtertype = ".post; ~effectparty.set(\type,val.linlin(0,127,0,1.0).postln;)};
)

/*

need knobs for:
Waveloss
Sample Rate
Bit Depth
Freq
res

Modulate 'Effectparty' for filter

*/

c.knob1.onChanged = {|val| "waveloss = ".post; ~effectparty.set(\waveloss,val.linlin(0,127,40,0).asInt.postln;)};
c.knob2.onChanged = {|val| "musicspeed = ".post; ~partysine = val.linlin(0,127,0.15,1).postln;};

~effectparty.play

~partysine = {SinOsc.kr(0.5).range(0.1,0.2)};
~partysine = {SinOsc.kr(0.1).range(0.1,90.9)};
~partysine = {0.25}
~partysine = {14}

//modulate effectparty for filter
~effectparty.set(\xfade,-1)


//by the time the fight is over we're into the smack scene and things need to end up around here:


//trigger this after Peter is down.
(
~partysine = {TRand.kr(0.15,0.3,Dust.kr(1))};
~effectparty.set(\waveloss,4);
)

//as things get more fucked up
~partysine = {TChoose.kr(Dust.kr(20),[0.15!10,0.2!10,0.21!2,0.22!4,0.24!2,0.23!5,1,1.2,1.4].flat)};

c.knob1.onChanged = {|val| "waveloss = ".post; ~effectparty.set(\waveloss,val.linlin(0,127,40,0).asInt.postln;)};

//GRADUALLY INCREASE WAVELOSS AS EVERYONE MOVES AWAY

~effectparty.set(\waveloss,6);

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
~march.stop;
~whine.stop;
~thump.stop;
)

//something inside of you, this happens once everyone makes their way back to their chairs...

(
~rumble = {Pan2.ar(Mix.ar(SinOsc.ar([80,80+LFNoise1.kr(0.1,8),80+LFNoise1.kr(0.1,8)],0,0.4)))};
~squiz = {Blip.ar(80,900,1)*EnvGen.ar(Env.perc(0,0.05),Dust.kr(9))!2};
~rumbler = {PlayBuf.ar(2,d["dj"][1],0.08,1,0,1)};
~rumbler.play;
Task({
	~rumble.play;
	10.wait;
	~squiz.play;
	10.wait;
	~rumbler.play;
}).start;
)





MIDIFunc.trace(false)



































///////////////////////////////////////////////////////////////////////////////////////
/*



SCRATCHPAD







*/






(
~effectparty = {
	arg waveloss = 1, bit = 24, srate = 44100, freq = 440, res = 1.01;
	var sig = Decimator.ar(WaveLoss.ar(~partymusic.ar,waveloss,40,1),srate,bit);
	XFade2.ar(sig,DFM1.ar(sig,SinOsc.ar(0.01).range(100,3000),res),-1);
}
)


~effectparty = {arg waveloss = 1, bit = 12, srate = 44100, freq = 440, res = 1.01; DFM1.ar(Decimator.ar(WaveLoss.ar(~partymusic.ar,waveloss,40,1),srate,bit),SinOsc.kr(0.01).range(100,3000),res,1,0)};


~partymusic.set(\speed,~partysine)


//pete gets pulled into the middle and the girls are still dancing while charlie is smashing peter's head in








