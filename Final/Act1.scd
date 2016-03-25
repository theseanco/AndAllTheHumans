//I, as the manipulator, will start this one. Make this trigger very visible, lift hand up make a big bang etc.

(
Task({
	~one = {Pan2.ar(Warp1.ar(1,d["hiss"][0],LFTri.kr(0.09),1,0.9,-1,8,0,2,2))};
	~one.play;
	~pperc = Pbind(\instrument,\vplay,\buf,Prand(d["pp"],inf),\rate,Pwhite(-0.2,0.2),\pos,Pwhite(0.5,0.99),\amp,Pexprand(0.1,3),\dur,Pexprand(0.2,1),\rel,2,\rate,Pwhite(0.1,1).round(0.1));
	~ppercw = {WaveLoss.ar(~pperc.ar)};
	50.wait;
~ppercw.play;
}).start;
)

(
//when alysia breathes
~breath = {Pan2.ar(RHPF.ar(WhiteNoise.ar(Line.kr(0.01,0.03,2)),LFNoise1.ar(2).range(7000,15000),0.2),LFNoise1.kr(0.1,0.6))};
~breath.play;
)

//trigger dust and lizbass in anticipation of clap. SET FADERS 1 and 2 TO MINIMUM

//WHEN PEOPLE START SINGING TO THEMSELVES


(
~dust = {arg amp=0, density = 90, dmul=1; PitchShift.ar(Dust2.ar(density!2,amp),0.8,dmul,0.0,0)};
c.topBt1.onPress = {"dust on".postln; ~dust.set(\amp,2)};
c.topBt1.onRelease = {"dust off".postln; ~dust.set(\amp,0)};
c.bottomBt1.onPress = {"dust density 9000".postln;~dust.set(\density,9000)};
c.bottomBt1.onRelease = {"dust density 200".postln; ~dust.set(\density,200)};
c.knob1.onChanged = {|msg| ~dust.set("dust pitch ".post;\dmul,msg.linlin(0,127,0.01,2).postln;)};
~dust.play;
)

(
~lizbass = Pbind(\instrument,\multiwave,\dur,Pseq([0.5,2],inf),\scale,Scale.major,\octave,3,\rel,3,\which,Pwhite(1,5.0),\degree,Pwrand([0,4],[0.8,0.2],inf),\atk,3,\amp,0.7,\focus,3,\ffreq,Pkey(\freq),\res,Pexprand(0.8,1.5));
~lizbass2 = Pbind(\instrument,\sinfb,\dur,3,\atk,3,\rel,3,\amp,0.2,\degree,Prand([[0,2,4],[4,6,8],[3,5,7]],inf),\scale,Scale.major,\octave,6,\fb,2);
~lizbass2lpf = {LPF.ar(~lizbass2,800)};
c.knob2.onChanged = {|msg| "bassgain ".post; ~lizbass.set(\igain,msg.linlin(0,127,0.5,40).postln)};
c.knob3.onChanged = {|msg| "bassres ".post; ~lizbass.set(\res,msg.linlin(0,127,0.5,10).postln)};
c.fader2.onChanged = {|val| "acc. bass vol: ".post; ~lizbass.vol=val.linlin(0,127,0,1.5).postln};
c.fader3.onChanged = {|val| ~thebirds.vol=val.linlin(0,127,0,1.5)};
	c.fader1.onChanged = {|val| "acc. chords vol: ".post; ~lizbass2lpf.vol=val.linlin(0,127,0,1.5).postln;};
)

(
//set fader 1 and 2 to minimum, knobs 2 and 3 to minimum. lizbass happens when people sing to their hands.
~lizbass.play;
~lizbass2lpf.play;
//also trigger this
Task({
	~one.stop(20);
	~pperc.stop(20);
	~breath.stop(20);
	20.wait;
	~one.clear;
	~pperc.clear;
	~ppercw.clear;
}).start;
)

(
//chaos
c.knob2.onChanged = {|msg| "bassgain ".post; ~lizbass.set(\igain,msg.linlin(0,127,0.5,90).postln)};
c.knob3.onChanged = {|msg| "bassres ".post; ~lizbass.set(\res,msg.linlin(0,127,0.5,90).postln)};
c.fader2.onChanged = {|val| "acc. bass vol: ".post; ~lizbass.vol=val.linlin(0,127,0,1.5).postln};
)


(
//set fader 1 and 2 to minimum, start with no modulation, then when Lizzie stops with the Accordion play with modulation and fade out chords
~lizbass.play;
~lizbass2lpf.play;
)


/*


FADE OUT LIZ BASS WHEN PEOPLE HAVE A TINY HUG

GET READY FOR BEATS TRIGGERED WHEN ROSIE HAS A GO

|||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||
VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

*/


(
//accordion section cleanup
~lizbass.clear;
~lizbass2.clear;
~lizbass2lpf.clear;
~dust.clear;
~lizbass3.clear;
~h0.clear;
)




p.clock.tempo=132/60

//Rosie's beats, post-invocation - needs cleaning up.
//these fade down towards the end of the section as they're eating rosie
(
//TRIGGER THIS WHEN ROSIE WALKS BACK TO LIZZIE - SHE IS NO LONGER SAYING ANYTHING
~k = Pbind(\instrument,\bplay,\buf,d["k2"][1],\dur,1,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pseq([0.75,Pseq([2,2,2,2,1.25,0.75],inf)],inf),\amp,1,\rate,Pseq([0.5,0.5,0.5,0.5,0.5,0.5,0.45,0.4].stutter(2),inf)*2);
~sn = Pbind(\instrument,\bplay,\buf,d["cp"][8],\dur,Pseq([0.5,Pseq([2,2,4,2],inf)],inf),\amp,2,\rate,1);
~rbass = Pbind(\instrument,\sinfb,\dur,Pwhite(1,4)/4,\rel,0.2,\amp,1,\scale,Scale.minorPentatonic,\degree,Place([0,0,[1,2,3],[4,4,5]],inf),\octave,Pwrand([3,2],[0.8,0.2],inf).stutter(2),\fb,Pwhite(0,0.2));
~gab = Pbind(\instrument,\bplay,\buf,d["k2"][3],\dur,Pwhite(4,8),\amp,1,\rate,0.8);
~hats = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,Pseq([1/3,1/3,(3+1/3)],inf),\amp,1,\rate,Pwrand([1.2,1],[0.1,0.9],inf));
// ~bloop = Pbind(\instrument,\bpl.ay,\buf,d["p2"][5],\dur,Pseq([7,2,2],inf)/6,\rate,Pwrand([2,1],[0.8,0.2],inf).stutter(3));
~vibrations = {arg width = 0.6; LeakDC.ar(Pan2.ar(LPF.ar(Pulse.ar(~tempo.kr*16,width,2),9000)))};
c.fader1.onChanged = {|val| "vibvol = ".post; ~vibrations.vol=val.linlin(0,127,0,1.5).postln;};
~vibrations.vol = 0;
c.knob1.onChanged = {|val| "vibwidth = ".post; ~vibrations.set(\width,val.linlin(0,127,0.001,0.5).postln;)};
(
Task({
	~k.play;
	~h.play;
	~sn.play;
	40.wait;
	~hats.play;
	~k.play;
	40.wait;
	~gab.play;
	40.wait;
	~cb.play;
	~cb.fadeTime=8;
	50.do({
		~cb = Pbind(\instrument,\bplaym,\buf,d["cb"][rrand(0,1)],\dur,Prand([1/3,1/6],inf),\amp,1);
		rrand(1,4.0).wait;
	});
}).start;
);
c.playBt.onPress = {~k.play; ~h.play; ~sn.play; "START dance music".postln;};
c.stopBt.onPress = {~k.stop; ~h.stop; ~sn.stop; "STOP dance music".postln;};
c.rewindBt.onPress = {p.clock.tempo=120/60};
c.loopBt.onPress = {p.clock.tempo=126/60};
c.ffwBt.onPress = {p.clock.tempo=132/60};
)

Quarks.gui


/*

REMOVED

//SET FADER ONE AND KNOB ONE TO ZERO!
//Then fade it up and modulate when there are vibrations
//ROSIE OSCILLATES BACK AND FORTH
//TURN OFF WHEN THE MASKS ARE DROPPED
~vibrations.play;
//ZERO ZERO ZERO

*/


//when lizzie et al go in for the second time
(
Task({
	~gab.stop(60);
	~k.stop(20);
	~cb.stop(10);
	~sn.stop(30);
	~hats.stop(40);
	~h.stop(40);
	120.wait;
	~gab.clear;
	~k.clear;
	~vibrations.clear;
	~cb.clear;
	~sn.clear;
	~hats.clear;
	~h.clear;
}).start;
)