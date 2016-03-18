//nanokontrol lines
c.knob1.onChanged = {|val| ~x.set(\y,val.linlin(0,127,0,1.0))};
c.knob2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob3.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob4.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob5.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob6.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob7.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob8.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob9.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};

c.knob1_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob2_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob3_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob4_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob5_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob6_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob7_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob8_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};
c.knob9_2.onChanged = {|val| ~x.set(\y,val.linlin(0,127,1,5))};

c.fader1.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader3.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader4.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader5.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader6.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader7.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader8.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader9.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};

c.fader1_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader2_3.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader3_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader4_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader5_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader6_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader7_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader8_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};
c.fader9_2.onChanged = {|val| ~x.vol=val.linlin(0,127,0,1.5)};