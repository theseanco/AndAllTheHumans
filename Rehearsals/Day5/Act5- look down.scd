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
//People back in chairs after moving
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
//at the end of the WJRF section, trigger this when chairs are in a circle and people standing around the outside
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
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,Pwhite(1,16.0));
)

(
//more, when people begin to pop back up after going down
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,Pwhite(0.5,2.5).round(0.5));
)


//when rosie goes down
(
~strings.stop(2);
~kik.stop(5);
)


//////////////////////////////////////////////
////////////////////ACT 5/////////////////////
//////////////////////////////////////////////


(
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

//not happy with this.
//very provisional
(

/*
p.clock.tempo=122/60;
~fund = {SinOsc.kr(0.1).range(50,60)};
~part0 = Pbind(\instrument,\sinfb,\dur,Pwhite(2,6),\freq,Pkr(~fund)*Pwhite(0.97,1.03),\amp,Pwhite(0.3,0.5),\sus,0.4,\rel,0.001,\atk,0,\fb,Pseq((50..110).mirror,inf)/100);
~part1 = Pbind(\instrument,\multiwave,\dur,4,\freq,Pkr(~fund)*Prand([4,6,8],inf),\amp,0.4,\rel,0.5,\atk,0,\rel,0.001,\sus,0.1);
~part2 = Pbind(\instrument,\multiwave,\dur,Pwhite(1,8),\freq,Pkr(~fund)*Prand([4,6,8],inf),\amp,0.4,\rel,0.5,\atk,0,\rel,0.001,\sus,0.1,\which,3);
~part3 = Pbind(\instrument,\multiwave,\dur,Pwhite(1,8),\freq,Pkr(~fund)*Prand([4,6,8],inf),\amp,0.4,\rel,0.5,\atk,0,\rel,0.001,\sus,0.1,\which,7);
~part4 = Pbind(\instrument,\multiwave,\dur,Pwhite(1,8.0)/2,\freq,Pkr(~fund)*Prand([2,3,4,5],inf),\amp,0.4,\atk,0,\rel,0.001,\sus,0.05,\which,3,\focus,9,\fb,3);
~part5 = Pbind(\instrument,\multiwave,\dur,Pwhite(1,8.0)/4,\freq,Pkr(~fund)*(Prand([2,3,4,5],inf))*8,\amp,0.4,\rel,0.001,\atk,0,\rel,0.001,\sus,0.01,\which,3,\focus,9,\fb,3);
*/

/*
~warp1 = {Warp1.ar(2,d["plink"][0],SinOsc.kr(0.04),0.5,0.2,interp:4)*0.5}
~warp2 = {Warp1.ar(2,d["plink"][0],SinOsc.kr(0.041),0.25,0.2,interp:4)*0.5}
~warp3 = {Warp1.ar(2,d["plink"][0],SinOsc.kr(0.05),1,0.2,interp:4)*0.5}

*/


(
~sugar3 = {arg speed = -0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)*2.5};
~sugar4 = {arg speed = -0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)*2.5};
)

/*
~part0.play;
~part1.play;
~part2.play;
~part3.play;
~part4.play;
~part5.play
*/


~sugar3.play;
)

(
//when peter starts playing
~sugar3.stop(5);
)

(
//just before peter stops playing;
(
~sugar3 = {arg speed = -0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)*2.5};
~sugar4 = {arg speed = -0.3; PlayBuf.ar(2,d["sugarplum"][0],speed,1,BufSamples.ir(d["sugarplum"][0])-1,1,0)*2.5};
~sugar3.play;
~sugar4.play;
)
)

(
~sugar3.stop(20);
~sugar4.stop(20);


