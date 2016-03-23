\///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////ALYS DANCE OF DEATH///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

//AFTER THE HOWLING, this is the trigger
{GVerb.ar(EnvGen.ar(Env.perc(0,0.0001),1,8,0,1,0),300,90,0.5,0.5,15,0.1,1,0.9,300,3)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//On the start of each set of vibrations
//First one is after hands down
{LPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,0.1),1,8,0,1,0),30,10,0.5,0.5,15,0.1,1,0.9,300,3)),700)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//second one after pause
{LPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,0.1),1,8,0,1,0),30,15,0.5,0.5,15,0.1,1,0.9,300,3)),700)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

//third one after pause
{HPF.ar(LeakDC.ar(GVerb.ar(EnvGen.ar(Env.perc(0,0.1),1,8,0,1,0),30,20,0.5,0.5,15,0.1,1,0.9,300,3)),3000)*EnvGen.ar(Env.asr(0,100,0),1,1,0,1,2)}.play;

(
//ceilidh music, scratched old '78.

//Everyone has just vibrated, NOW TRIGGER THIS.
//may speed this up later
~ceilidh = {arg speed = 0.9; Pan2.ar(PlayBuf.ar(1,d["newceilidh"][0],speed,1,6*44100,1,0),0,1.9)};
~ceilidh.play;
~cline = {0.9};

//maybe this needs to be degraded, but it's already been reversed once, this is something to consider...
~evilceilidh = {arg speed = 0.1; Pan2.ar(PlayBuf.ar(1,d["newceilidh"][0],speed,1,0,1,0),0,1.4)};
~evilceilidh.play
)

(
//trigger this when lizzie starts hugging her chair
~cline = {0.9};
~cline = {Line.kr(0.9,1,1.2)};
~ceilidh.set(\speed,~cline);
)


(
//then this, once things are established
~cline = {Line.kr(1,1.2,60)};
)

//need a gradually increasing distortion

//fundamental of 531hz.

//lizzie sits down and it fades.