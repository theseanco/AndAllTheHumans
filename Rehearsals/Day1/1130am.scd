// 11am, everyone working for themselves.

(
SynthDef(\multiwave, { //res and ftype for selective filtering, fnoise for filter noise
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0, which=1.0, pwidth=0.5, focus=1, ffreq = 440, res = 0.1, ftype = 0, fnoise = 0.0003, filter = 1, igain=1;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SelectXFocus.ar(which,[SinOscFB.ar(freq,fb,1),SawDPW.ar(freq,0,1),PulseDPW.ar(freq,pwidth,1)],focus,true);
	sig = XFade2.ar(sig,DFM1.ar(sig,ffreq,res,igain,ftype,fnoise,1),filter,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);


Synth(\multiwave)

Tuning.directory

t = Scale.minor(Tuning.et12);

Scale.directory

t = Tuning.sruti

~thebirds = {PlayBuf.ar(2,d["birds"][0],1,1,0,1,0)}

~thebirds.play

~multiwave = Pbind(\instrument,\multiwave ,\dur,1,\atk,3,\rel,3,\which,Pwhite(1,4.0),\scale,t,\degree,Place([0,0,0,[1,3,2,4],[0,0,0,0],[5,4,4,4]],inf)+Pwrand([0,8,16],[0.9,0.15,0.05],inf),\focus,2,\fb,1.3,\pwidth,0.3)

~bass = Pbind(\instrument,\multiwave,\dur,Pseq([0.5,2],inf),\scale,t,\octave,3,\rel,3,\which,Pwhite(1,5.0),\degree,Pwrand([0,4],[0.8,0.2],inf),\atk,3,\amp,0.3,\focus,3,\ffreq,Pkey(\freq),\res,Pexprand(0.8,1.5))

~bass2 = Pbind(\instrument,\sinfb,\dur,3,\atk,3,\rel,3,\amp,0.2,\degree,Prand([[0,2,4],[4,6,8],[5,7,9]],inf),\scale,t,\octave,6,\fb,2)

~bass2lpf = {LPF.ar(~bass2,800)}
~bass2.stop

~bass2lpf.play

~bass2.play

~bass.play

MIDIFunc.trace(false)

~multiwave.play

~dust = {arg amp=1, density = 90, dmul=1; PitchShift.ar(Dust2.ar(density!2,amp),0.2,dmul,0.0,0)}
~dust.play
~dust.stop


~bass2lpf.stop


p.fadeTime=4

~multiverb = {arg dfreq = 2, filt = 900; GVerb.ar(LeakDC.ar(HPF.ar(Mix.ar([~multiwave.ar,Dust.ar(dfreq,2)]),filt)),90,30,0.1,0.5,30,0)}

c.knob1.onChanged = {|msg| ~multiverb.set(\dfreq,msg.linlin(0,127,0.0,20))};
c.knob2.onChanged = {|msg| ~multiverb.set(\filt,msg.linlin(0,127,10,6000))};



~oner = {DFM1.ar(Pulse.ar(100, mul:0.4) + Pulse.ar(100.1, mul:0.4), SinOsc.kr(SinOsc.kr(0.3).range(0.2, 5)).range(80, 2000), 1.1, inputgain: 2.0, mul:0.01)!2}

~oner.stop

//fiddling with the two buttons and first knob sounds like leccy

c.topBt1.onPress = {~dust.set(\amp,2)}
c.topBt1.onRelease = {~dust.set(\amp,0)}
c.bottomBt1.onPress = {~dust.set(\density,9000)}
c.bottomBt1.onRelease = {~dust.set(\density,200)}
c.knob1.onChanged = {|msg| ~dust.set(\dmul,msg.linlin(0,127,0.01,2))};
c.knob2.onChanged = {|msg| "bassgain ".post; ~bass.set(\igain,msg.linlin(0,127,0.5,40).postln)};

c.fader2.onChanged = {|val| ~bass.vol=val.linlin(0,127,0,1.5)};
c.fader3.onChanged = {|val| ~thebirds.vol=val.linlin(0,127,0,1.5)};


~multiverb.play






//Rosie's beats
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,0.6);
~h = Pbind(\instrument,\bplay,\buf,d["h"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,0.6,\rate,Pseq([0.5,0.5,0.5,0.5,0.5,0.5,0.45,0.4].stutter(2),inf));
~sn = Pbind(\instrument,\bplay,\buf,d["sn"][7],\dur,2,\amp,2,\rate,1);
~bass = Pbind(\instrument,\sinfb,\dur,Pwhite(1,4)/4,\rel,0.1,\amp,1,\scale,Scale.minorPentatonic,\degree,Place([0,0,[1,2,3],[4,4,5]],inf),\octave,Pwrand([3,4],[0.9,0.1],inf).stutter(2),\fb,Pexprand(0.1,30.4))
)
////






Synth(\sinfb)

~bass.clear

~bass.play

Scale.directory


p.clock.tempo=132/60

~k.play

~sn.play

~h.play

/*
lizzie accordion part

*/

~bass = Pbind(\instrument,\multiwave,\dur,Pseq([0.5,2],inf),\scale,t,\octave,3,\rel,3,\which,Pwhite(1,5.0),\degree,Pwrand([0,4],[0.8,0.2],inf),\atk,3,\amp,0.3,\focus,3,\ffreq,Pkey(\freq),\res,Pexprand(0.8,1.5))

~bass2 = Pbind(\instrument,\sinfb,\dur,3,\atk,3,\rel,3,\amp,0.2,\degree,Prand([[0,2,4],[4,6,8],[5,7,9]],inf),\scale,t,\octave,6,\fb,2)

~bass2lpf = {LPF.ar(~bass2,800)}
~bass2.stop

~bass2lpf.play

~bass2.play

~bass.play


c.knob2.onChanged = {|msg| "bassgain ".post; ~bass.set(\igain,msg.linlin(0,127,0.5,40).postln)};

c.fader2.onChanged = {|val| ~bass.vol=val.linlin(0,127,0,1.5)};
c.fader3.onChanged = {|val| ~thebirds.vol=val.linlin(0,127,0,1.5)};
c.fader1.onChanged = {|val| ~bass2lpf.vol=val.linlin(0,127,0,1.5)};


/*

lizzie accordion part end

*/










