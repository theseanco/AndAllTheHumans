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
~partymusic.set(\speed,~partysine);
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
//trigger this when peter s.
~march.stop(5);
~whine.stop(10);
~thump.stop(15);
)

//something inside of you, this happens once everyone makes their way back to their chairs...

//4//4//4/4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4/
//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//4//ACT/4//4//4//4//4//4//4//4//4/
//4//4//4//4//4//4//4//4//4//4//4//4//4//4/4//4//4//4//4//4//4//4//4//4//4//4//4/

(
~fund = 80;
~rumble = {Pan2.ar(Mix.ar(SinOsc.ar([~fund,~fund+LFNoise1.kr(0.1,8),~fund+LFNoise1.kr(0.1,8)],0,0.4)))};
~squiz = {Blip.ar(~fund,900,1)*EnvGen.ar(Env.perc(0,0.05),Dust.kr(9))!2};
~rumbler = {PlayBuf.ar(2,d["dj"][1],0.03,1,0,1)*0.4};
Task({
	~rumble.play;
	20.wait;
	~squiz.play;
	40.wait;
	~rumbler.play;
}).start;
)

(
//lizzie moves her chair over to charlie
~hi = {Splay.ar(SinOsc.ar([~fund*10,~fund*11,~fund*12]*1.5,0,SinOsc.kr(0.1,0,Line.kr(0,0.3,40)).abs))};
~hi.play;
)

(

//TRIGGER THIS WHEN PEOPLE SCREAM INTO EACH OTHERS CHESTS
~hi.stop(90);
~squiz.stop(2);
~rumbler.stop(2);
~rumble.stop(30);
~fund = 90;
//multiplicity
~multithumper.fadeTime=0;
//this needs to be more dramatic
~multithumper = {Splay.ar(Mix.ar(PlayBuf.ar(2,d["plink"][3],Array.fill(12,{rrand(1.3,1.4)}),1,0,1)),1,1)*2};
~multithumper.play;
)

(
//when the lifting happens trigger this
~multithumper2 = {Splay.ar(Mix.ar(PlayBuf.ar(2,d["plink"][3],Array.fill(3,{rrand(0.3,0.4)}),1,0,1)),1,1)};
~multithumper2.play;
)

(
//cleanup
~hi.clear;
~squiz.clear;
~rumbler.clear;
~rumble.clear;
)

(
//when the lifting stops, trigger this, when people are on top of the chairs
~multithumper.stop(5);
)

//NEXT FILE



































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








