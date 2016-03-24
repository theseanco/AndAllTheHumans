(
//when peter crucifixes
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
//people bloom more in their chairs - PETER IS IN FRONT OF ME
~bloom = {Pulse.ar([~fund*LFNoise1.kr(0.1).range(10.0001,10.1),~fund*LFNoise1.kr(0.1).range(10.0001,10.1)],SinOsc.kr(XLine.kr(0.01,~fund*10,40)).range(0.000001,Line.kr(0.06,0.2,40)),Line.kr(0,0.2,5))};
~bloom.play;
)


(
//cleanup
~multithumper.clear;
)


(
//as people walk to the chairs
~likeme.stop(5);
~likeme2.stop(5);
~bloom.stop(9);
~multithumper2.stop(5);
)

(
//trigger this WHEN PEOPLE SIT DOWN, particularly when Alys looks composed.
c.knob1.onChanged = {|val| c.topBt1.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(1,val.linlin(0,127,1.01,1.2)),1,0,0,2)}.play;}}; "hi divergence = ".post; val.postln;};

//hi
c.topBt1.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(1,1.1),1,0,0,2)}.play;}};

//low
c.topBt2.onPress = {10.do{{PlayBuf.ar(2,d["plink"][0],rrand(0.1,0.11),1,0,0,2)}.play;}};

//mid
c.topBt3.onPress = {100.do{{PlayBuf.ar(2,d["plink"][0],rrand(0.5,0.51),1,0,0,2)}.play;}};

p.clock.tempo = 105/60;

//DONE

~one = Pbind(\instrument,\bplay,\buf,d["plink"][0],\dur,Pseq([0!10,4].flat,11),\rate,Pwhite(0.1,0.11),\amp,0.7);

~two = Pbind(\instrument,\bplay,\buf,d["plink"][0],\dur,Pseq([2,Pseq([0!10,4].flat,10)],1),\rate,Pwhite(1,1.1),\amp,Pseq([0,Pseq([0.7],inf)],inf));

~two.play;
~one.play;
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
~wjrf.stop(8);
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
//more, when people start getting killed
~kik = Pbind(\instrument,\bplay,\buf,d["bang"][0],\amp,2,\dur,Pwhite(0.5,2.5).round(0.5));
)


//when rosie goes down
(
~strings.stop(2);
~kik.stop(5);
)


