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
~ppercw.stop

p.fadeTime=3


~one.clear

~one.play

~ppercw = {WaveLoss.ar(~pperc.ar)}
~pperc.stop

~ppercw.play

//clear first set of things, when the clap happens
(
Task({
	1.do({
~one.stop(20);
~pperc.stop(20);
		20.wait;
		~one.clear;
		~pperc.clear;
		~ppercw.clear;
	});
}).start;
)


//dust


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
~lizbass = Pbind(\instrument,\multiwave,\dur,Pseq([0.5,2],inf),\scale,Scale.minor,\octave,3,\rel,3,\which,Pwhite(1,5.0),\degree,Pwrand([0,4],[0.8,0.2],inf),\atk,3,\amp,0.7,\focus,3,\ffreq,Pkey(\freq),\res,Pexprand(0.8,1.5));
~lizbass2 = Pbind(\instrument,\sinfb,\dur,3,\atk,3,\rel,3,\amp,0.2,\degree,Prand([[0,2,4],[4,6,8],[5,7,9]],inf),\scale,Scale.minor,\octave,6,\fb,2);
~lizbass2lpf = {LPF.ar(~lizbass2,800)};
c.knob2.onChanged = {|msg| "bassgain ".post; ~lizbass.set(\igain,msg.linlin(0,127,0.5,40).postln)};
c.knob3.onChanged = {|msg| "bassres ".post; ~lizbass.set(\res,msg.linlin(0,127,0.5,10).postln)};
c.fader2.onChanged = {|val| "acc. bass vol: ".post; ~lizbass.vol=val.linlin(0,127,0,1.5).postln};
c.fader3.onChanged = {|val| ~thebirds.vol=val.linlin(0,127,0,1.5)};
	c.fader1.onChanged = {|val| "acc. chords vol: ".post; ~lizbass2lpf.vol=val.linlin(0,127,0,1.5).postln;};
)

(
//set fader 1 and 2 to minimum, lizbass happens when al claps
~lizbass.play;
~lizbass2lpf.play;
)

MIDIFunc.trace

(
//chaos
c.knob2.onChanged = {|msg| "bassgain ".post; ~lizbass.set(\igain,msg.linlin(0,127,0.5,90).postln)};
c.knob3.onChanged = {|msg| "bassres ".post; ~lizbass.set(\res,msg.linlin(0,127,0.5,90).postln)};
c.fader2.onChanged = {|val| "acc. bass vol: ".post; ~lizbass.vol=val.linlin(0,127,0,1.5).postln};
)


//lizbass part 2, in theory making lizbass part 1 more rhythmic, but i'm not really happy with this yet.
(
p.clock.tempo=90/60;
~lizbass3 = Pbind(\instrument,\multiwave,\focus,1,\which,3,\amp,3,\dur,Pwhite(1,8)/4,\rel,0.1,\scale,Scale.minor,\degree,Pwhite(0,4),\scale,Scale.minorPentatonic,\octave,3);
~h0 = Pbind(\instrument,\bplay,\buf,d["k2"][0],\rate,2,\amp,0.5,\dur,Pwhite(4,6));

~h0.stop;
~lizbass3.clear
)

(
//set fader 1 and 2 to minimum, start with no modulation, then when Lizzie stops with the Accordion play with modulation and fade out chords
~lizbass.play;
~lizbass2lpf.play;
)


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
//TRIGGER THIS WHEN ROSIE SAYS FUCK
~k = Pbind(\instrument,\bplay,\buf,d["k2"][1],\dur,1,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pseq([0.75,Pseq([2,2,2,2,1.25,0.75],inf)],inf),\amp,1,\rate,Pseq([0.5,0.5,0.5,0.5,0.5,0.5,0.45,0.4].stutter(2),inf)*2);
~sn = Pbind(\instrument,\bplay,\buf,d["cp"][8],\dur,Pseq([0.5,Pseq([2,2,4,2],inf)],inf),\amp,2,\rate,1);
~rbass = Pbind(\instrument,\sinfb,\dur,Pwhite(1,4)/4,\rel,0.2,\amp,1,\scale,Scale.minorPentatonic,\degree,Place([0,0,[1,2,3],[4,4,5]],inf),\octave,Pwrand([3,2],[0.8,0.2],inf).stutter(2),\fb,Pwhite(0,0.2));
~gab = Pbind(\instrument,\bplay,\buf,d["k2"][3],\dur,Pwhite(4,8),\amp,1,\rate,0.8);
~hats = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,Pseq([1/3,1/3,(3+1/3)],inf),\amp,1,\rate,Pwrand([1.2,1],[0.1,0.9],inf));
~bloop = Pbind(\instrument,\bplay,\buf,d["p2"][5],\dur,Pseq([7,2,2],inf)/6,\rate,Pwrand([2,1],[0.8,0.2],inf).stutter(3));
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
	30.do({
		~cb = Pbind(\instrument,\bplaym,\buf,d["cb"][rrand(0,1)],\dur,1/3,\amp,1);
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

//when rosie is eaten
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
	~cb.clear;
	~sn.clear;
	~hats.clear;
	~h.clear;
}).start;
)