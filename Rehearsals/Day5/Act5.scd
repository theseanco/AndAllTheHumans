// People start blooming in the chairs
(
~fund = 10;
~likeme = {Pan2.ar(FreeVerb.ar(Pulse.ar(~fund/2,SinOsc.kr(0.07).range(0.0001,0.1),XLine.kr(0.001,1,10)),0.8,0.8,0.5,0.2))};
~likeme2 = {FreeVerb.ar(Pulse.ar([~fund*2,(~fund*2)*1.01],SinOsc.kr(0.078).range(0.0000001,0.1),XLine.kr(0.0001,0.14,40)),0.8,0.8,0.5)};
Task({
	~likeme.play;
	20.wait;
	~likeme2.play;
}).start;
)

(
//cleanup
~multithumper.clear;
)



(
//People back in chairs
// !!!!!! PAY ATTENTION !!!!!!!
//trigger every time there's an action
//top button 1 for high, 2 for low
//low when moving away from the chair, hi when moing back, mid when in between
//modulate divergence on the high plink with knob 1 (start at lowest value)
~likeme.stop(5);
~likeme2.stop(5);
~multithumper2.stop(5);

c.knob1.onChanged = {|val| c.topBt1.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(1,val.linlin(0,127,1.01,1.2)),1,0,0,2)}.play;}}; "hi divergence = ".post; val.postln;};

//hi
c.topBt1.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(1,1.1),1,0,0,2)}.play;}};

//low
c.topBt2.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(0.1,0.11),1,0,0,2)}.play;}};

//mid
c.topBt3.onPress = {100.do{{PlayBuf.ar(2,d["plink"][0],rrand(0.5,0.51),1,0,0,2)}.play;}};
)

(
//everyone back in their chairs, they wait for this cue
~likeme.play;
~likeme2.play;
~multithumper2.play;
//walk jump roll fall
~wjrf.fadeTime=0;
~wjrf.play;
Task({
	20.do({ arg i;
~wjrf = {Splay.ar(Mix.ar(PlayBuf.ar(2,d["pp"][1],Array.fill(12,{rrand(-0.8,2.2)}),1,0,1,0)))*0.3};
		"iteration ".post;
		i.postln;
		rrand(4,15).wait;
		~wjrf.fadeTime=3;
	});
}).start;
)


(
//at the end of the WJRF section
~likeme.stop(2);
~likeme2.stop(4);
~multithumper2.stop(8);
~wjrf.stop(12);
)

//Alysia's dance of death
(
//when people shuffle in
p.clock.tempo=122/60;
~strings = {PlayBuf.ar(2,d["strquartet"][0],1,1,0,1)};
~strings.play;
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,16);
Task({
	40.wait;
	~kik.play;
}).start;
)

(
//as things get more manic - Alysia reaches the middle again
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,Pwhite(1,16));
)

(
//more
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,Pwhite(0.5,2.5).round(0.5));
)


//when rosie goes down
~strings.stop(2);
~strings.play

~kik.stop(5);




