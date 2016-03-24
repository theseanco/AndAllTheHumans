//////////////////////////////////////////////
////////////////////ACT 5/////////////////////
//////////////////////////////////////////////


(
//When alysia hits after falling backwards trigger this
//Palindromic transition, takes 36 seconds
~sugar = {arg speed = 3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,0,0,0)*1.2};
~sugar2 = {arg speed = -3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,0,0)*1.2};
~sugareffects = {GVerb.ar(~sugar.ar,10,3,0.5,0.5,15,1,0.7,0.5,200,1)};
~sugar.play;
~sugar2.play;
)

//cleanup
(
~kik.clear;
~strings.clear;
~multithumper2.clear;
~wjrf.clear;
~likeme.clear;
~likeme2.clear;
~sugar.clear;
~sugar2.clear;
)

///////////////////////////////////////////////////////////////

(
//After the ties go over the backs of the chairs trigger this.
~sugar3 = {arg speed = 0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)};
~sugar4 = {arg speed = -0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)};
~sugar5 = {arg speed = 0.3; PitchShift.ar(PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0),0.2,4,0.01,0.01)*1.9};
~sugar6 = {arg speed = -0.3; PitchShift.ar(PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0),0.2,4,0.01,0.01)*1.9};
~sugar3.play;
~sugar4.play;
c.fader1.onChanged = {|val| "plum1vol = ".post; ~sugar5.vol=val.linlin(0,127,0,1).postln;};
c.fader2.onChanged = {|val| "plum2vol = ".post; ~sugar6.vol=val.linlin(0,127,0,1).postln;};
)

(
//SET FADERS 1 and 2 TO ZERO
//when peter starts laughing, fade up 1 and 2
~sugar5.play;
~sugar6.play;
)

(
//WHEN CHARLIE PRESSES THE TRIGGER!!!!!
~sugar3.fadeTime=1;
~sugar4.fadeTime=1;
~sugar5.stop(1);
~sugar6.stop(1);
{GVerb.ar(EnvGen.ar(Env.perc(0,0.01),1,8,0,1,0),190,3,0.5,0.5,15,1,0.7,0.5,300,3)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;
~sugar3 = {arg speed = -0.03; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-666666,1,0)*2.5};
~sugar4 = {arg speed = 0.03; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-666666,1,0)*2.5};
)

(
//when peter changes tunes
~sugar3.stop(2);
~sugar4.stop(2);
)

//After the howling has gone on for a bit, trigger this.
{GVerb.ar(EnvGen.ar(Env.perc(0,0.0001),1,8,0,1,0),300,90,0.5,0.5,15,0.1,1,0.9,300,3)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//On the start of each set of vibrations
//First one is after hands down
{LPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,0.1),1,8,0,1,0),30,10,0.5,0.5,15,0.1,1,0.9,300,3)),700)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//second one after pause
{LPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,0.1),1,8,0,1,0),30,15,0.5,0.5,15,0.1,1,0.9,300,3)),700)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//third one after pause
{HPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,1),1,8,0,1,0),30,20,0.5,0.5,15,0.1,1,0.9,300,3)),3000)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

(
//ceilidh music, scratched old '78.

//Everyone has just vibrated, then they unbutton their shirts
//THEN TRIGGER THIS
~ceilidh = {arg speed = 0.9; Pan2.ar(PlayBuf.ar(1,d["newceilidh"][0],speed,1,6*44100,1,0),0,1.9)};
~ceilidh.play;
~cline = {0.9};

//maybe this needs to be degraded, but it's already been reversed once, this is something to consider...
~evilceilidh = {arg speed = 0.1; Pan2.ar(PlayBuf.ar(1,d["newceilidh"][0],speed,1,0,1,0),0,1.4)};
~evilceilidh.play
)

~evilceilidh.clear

(
//about to go
//trigger this when lizzie starts hugging her chair
~cline = {0.9};
~cline = {Line.kr(0.9,1,1.2)};
~ceilidh.set(\speed,~cline);
)


(
//drop this when lizzie jumps in the middle
~cline = {Line.kr(0.9,1.2,60)};
)

(
~ceilidh.fadeTime=10;
~ceilidh = {arg speed = 0.9; Pan2.ar(PlayBuf.ar(1,d["newceilidh"][0],0.2,1,120*44100,1,0),0,1.9)};
~ceilidh2 = {arg speed = 0.9; Pan2.ar(PitchShift.ar(PitchShift.ar(PlayBuf.ar(1,d["newceilidh"][0],0.2,1,120*44100,1,0),0.2,4,0,0.04),0.2,4,0,0.04),0,1.9)};
~ceilidh2.play;
~ceilidh.play;
)



~cline = {Line.kr(1000,1,120)}

//need a gradually increasing distortion

//fundamental of 531hz.

//lizzie sits down and it fades.