\///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////ALYS DANCE OF DEATH///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

(
//shakes
~sugar3.stop(2);
~sugar4.stop(2);
)

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
~cline = {Line.kr(1,1.2,20)};
)

//need a gradually increasing distortion

//fundamental of 531hz.

//lizzie sits down and it fades.