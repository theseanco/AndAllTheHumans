




p.fadeTime=4

~one = {DFM1.ar(SelectXFocus.ar(LFNoise1.kr(0.1,6),[PinkNoise.ar(1),WhiteNoise.ar(1),BrownNoise.ar(1),ClipNoise.ar(1)],LFNoise1.kr(0.1,2).abs,true)*LFNoise1.kr(0.1,0.5).abs,LFNoise1.kr([3,3.1]).range(200,2000).round(400),LFNoise1.kr(0.1,1.2).abs,1,0,LFNoise1.kr(0.2,0.2).abs,0.9)}

s.scope

NanoKontrol.new

~one.clear

~one.play


MIDIFunc.trace

~five = {LeakDC.ar(Warp1.ar(2,d["birds"][0],LFNoise1.kr(1,1),LFNoise1.kr(0.1).range(0.001,6),LFNoise1.kr(0.5).range(0.01,0.5),-1,16,0.01,4,4))}

~two = {LeakDC.ar(Warp1.ar(2,d["birds"][0],LFNoise1.kr(1,1),LFNoise1.kr(0.1).range(0.001,10.1),LFNoise1.kr(0.5).range(0.01,0.5),-1,16,0.01,4,4))}

~three = {LeakDC.ar(Warp1.ar(2,d["birds"][0],LFNoise1.kr(1,1),LFNoise1.kr(0.1).range(0.001,90.1),LFNoise1.kr(0.5).range(0.01,0.5),-1,16,0.01,4,4))}

~four = {LeakDC.ar(Warp1.ar(2,d["birds"][0],LFNoise1.kr(1,1),LFNoise1.kr(0.1).range(0.001,960.1),LFNoise1.kr(0.5).range(0.01,0.5),-1,16,0.01,4,4))}

~one = {arg phs = 0,amp=0.01, f = 100;  SinOsc.ar([f,f*1.25]/2,phs,amp)}

c.knob1.onChanged = {~one.set(\phs,rrand(0,3pi))};
c.knob2.onChanged = {~one.set(\amp,rrand(0,0.2))};
c.knob3.onChanged = {~one.set(\f,exprand(80,1300).round(30))};
c.fader1.onChanged = {|val| ~one.vol=val.linlin(0,127,0,1.5)};


~one.play


s.scope

MIDIIn.connectAll
MIDIFunc.trace

~one.stop(2)

~two.play
~four.play

~five.play
~three.play













