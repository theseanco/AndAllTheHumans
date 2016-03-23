///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



(
// lots of people wandering about, kinda interacting with people but not really.
// Peter blossoming.
// Five wobbly oscs and one standard osc?
/*
Alys bullies Pete, start this when peter knocks rosie off

*/


//don't like the near-constant sine tone here.
//Does eventually make a wierd sense though...
(
p.clock.tempo=1;
~fund = 55;
~postdance =
{arg turmoil = 1, turmvol= 0, tres = 0; Splay.ar(
	[
		//peter, set the Line.kr according to how long it takes for him to blossom maybe?
		DFM1.ar(SawDPW.ar(~fund*16+LFNoise1.kr(500,10),0,0.3),~fund*8,Line.kr(0.1,1.1,40)*LFNoise1.kr(0.1,0.1,1),1,0,0,0.7),
		//Charlie, wobbly going up and down
		DFM1.ar(SawDPW.ar(~fund*4+Vibrato.kr,0,0.3),~fund*2+SinOsc.kr(LFNoise1.kr(0.1,10),0,0.2),LFNoise1.kr(0.1,1.2),1.4,0,0,0.6),
		//alysia, slow draw-out movements
		DFM1.ar(SinOsc.ar(~fund,0,0.4),~fund/2,SinOsc.kr(0.01,0,1.3).abs,1,0,0,1),
		//rosie, stressing out
		WaveLoss.ar(DFM1.ar(SawDPW.ar(~fund*8,0,0.4),~fund*4,LFNoise1.kr(4,1),1,0,0),LFNoise1.kr(9).range(1,10),11,2),
		//lizzie & alys unaccounted for as yet
		Warp1.ar(1,d["crackle"][0],SinOsc.kr(LFNoise1.kr(0.1,0.03).abs),1,0.4,-1,16,0.01,2,XLine.kr(0.001,1,45))
	],
	1,1,0,true)}
);

c.knob1.onChanged = {|msg| "diversion =  ".post; ~postdance.set(\turmoil,msg.linlin(0,127,3,250).postln)};
c.knob2.onChanged = {|msg| "turmres =  ".post; ~postdance.set(\tres,msg.linlin(0,127,0,3.0).postln)};
c.fader1.onChanged = {|msg| "turmoilvol = ".post; ~postdance.set(\turmvol,msg.linlin(0,127,0,3.0).postln;)};
~kicker = Pbind(\instrument,\bplay,\buf,d["trap"][0],\amp,1,\dur,8);
~snarer = Pbind(\instrument,\bplay,\buf,Prand(d["p1"],inf),\amp,1,\dur,Pwhite(1,5.0),\rate,0.6);
~kicker.play;
~snarer.play;
~postdance.play;
)

//Why don't you like me? post-bullying trigger this - when people are hugging
(
~likeme = {Pan2.ar(FreeVerb.ar(Pulse.ar(~fund/2,SinOsc.kr(0.07).range(0.0001,0.1),XLine.kr(0.001,1,10)),0.8,0.8,0.5))};
~likeme2 = {FreeVerb.ar(Pulse.ar([~fund*2,(~fund*2)*1.01],SinOsc.kr(0.078).range(0.0000001,0.1),XLine.kr(0.0001,0.7,40)),0.8,0.8,0.5)};
Task({
	~likeme.play;
	20.wait;
	~likeme2.play;
}).start;
)


//as people start reaching out, begin to modulate the fundamental
(
~fund.fadeTime=20;
~wtask = Task({
	4.do({ |i|
		~fund = 80;
		30.wait;
		~fund = 60;
		30.wait;
		i.postln;
	})
}).start;
)

//before bouncing
(
~hatter = Pbind(\instrument,\bplay,\buf,d["h"][2],\dur,Pexprand(0.1,1).round(0.1),\amp,1,\rate,2);
~hatter2 = Pbind(\instrument,\bplay,\buf,d["h"][0],\dur,Pexprand(0.1,1).round(0.1),\amp,1,\rate,1.3);
)

//play on first bounce
~hatter.play;
//play on second bounce
~hatter2.play;

//trigger this when ROSIE moves out of the second set of bounces
(
~kicker2 = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/10,\amp,1,\rate,Pwrand([0.9,1],[0.9,0.1],inf));
~snarer2 = Pbind(\instrument,\bplay,\buf,d["sn"][4],\dur,Pbjorklund2(5,8)/2.5,\amp,1);
~kicker2.play;
~snarer2.play;
)

//LOOK!

(
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// WHEN    LIZZIE'S    HANDS    TOUCH    THE    FLOOR !!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
~kicker2.stop(1);
~snarer2.stop(1);
~hatter2.stop(1);
~hatter.stop(1);
~snarer.stop(1);
~kicker2.stop(1);
~kicker.stop(1);
~postdance.stop(1);
)

//immediately when lizzie starts again, possibly turn this into a task.
(
~jumparound = { Pan2.ar(HPF.ar(LatoocarfianN.ar(
    SampleRate.ir/2,
    LFNoise2.kr(2,1.5,1.5),
    LFNoise2.kr(2,1.5,1.5),
    LFNoise2.kr(2,0.5,1.5),
    LFNoise2.kr(2,0.5,1.5)
),880)) * 0.2 };
~jumparound.play;
~putdown = {SinOsc.ar([~fund,~fund*1.01],0,XLine.kr(0.00001,0.8,40))};
~putdown.play;
)

~jumparound.stop
(
//clear all of the hits & kicks
~kicker2.clear;
~snarer2.clear;
~hatter2.clear;
~hatter.clear;
~snarer.clear;
~kicker2.clear;
~kicker.clear;
~postdance.clear;
)

(
//need something when Alys's hands touch the floor, maybe something to stop.
//THIS.
~jumparound.stop(5);
)

(
//giving away a bit of yourself, when chairs are in a line
//add a volume limiter on fundmover, it resonates a bit too much.
// on hip sway, turn knob 1, then 2, then 3
~likeme.stop(10);
~likeme2.stop(20);
~putdown.stop(30);
~fundmover = {GVerb.ar(Mix.ar([SinOscFB.ar((LFSaw.kr([LFNoise1.kr(0.1,1).abs,LFNoise1.kr(0.1,1).neg]).range(~fund,~fund*10).round(~fund))/2,SinOsc.kr(0.1).abs,Line.kr(0,0.2,20))]),20,30,0.7,0.5,30,SinOsc.kr(0.1).range(0.3,0.7)).flat};
~fundmover.play;
~fund.fadeTime=1;
c.knob1.onChanged = {|msg| "fundamental =  ".post; ~fund = msg.linlin(0,127,80,200).asInt.postln};
c.knob2.onChanged = {|msg| "fundamental 2nd =  ".post; ~fund = msg.linlin(0,127,200,800).asInt.postln};
c.knob3.onChanged = {|msg| "fundamental 3rd =  ".post; ~fund = msg.linlin(0,127,800,1600).asInt.postln};
c.knob4.onChanged = {|msg| "fundamental 4rd =  ".post; ~fund = msg.linlin(0,127,1600,9000).asInt.postln};
)

(
//cleanup
~jumparound.clear;
~likeme.clear;
~likeme2.clear;
~putdown.clear;
)

[1,2,3,4,5,6].scramble

(
//!!
//SCREAM
//!!
~fundmover.stop(1);
{GVerb.ar(EnvGen.ar(Env.perc(0,0.01),1,8,0,1,0),90,3,0.5,0.5,15)}.play;
)