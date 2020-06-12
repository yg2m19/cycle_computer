module pulse_gen(input logic nTrip,nMode,clock,nRst,readyM,readyT,
		 output logic nTrip_pulse,nMode_pulse);
timeunit 1ns;
timeprecision 100ps;

enum logic [2:0] {s0,s1,s2,s3,s4,s5,s6}state;

always_ff@(posedge clock,negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= s0;
end
else
begin
unique case(state)
	s0: begin
	    if(!nMode & readyM)
	    state <= s1;
	    else
	    begin
	    if(!nTrip & readyT)
	    state <= s4;
	    else
	    state <= s5;
	    end
	    end
	s1: begin
	    if(!nMode & readyM)
	    begin
	    if(!nTrip & readyT)
	    state <= s2;
	    else
	    state <= s1;
	    end
	    if(nMode & readyM)
	    state <= s3;
	    end
	s2: begin
	    //if(nMode & nTrip)
	    state <= s6;
	    end
	s3: begin
	    //if(nMode & nTrip)
	    state <= s6;
	    end
	s4: begin
	    //if(nMode & nTrip)
	    state <= s6;
	    end
	s5: begin
	    //if(nTrip & nMode)
	    state <= s0;
	    end
	s6: begin
	    if(nMode & nTrip)
	    state <= s0;
	    end
endcase    
end
end

always_comb
begin:COMB
nMode_pulse = '1;
nTrip_pulse = '1;
unique case(state)
	s0:;
	s1:;
	s2:begin
	   nTrip_pulse = '0;
	   nMode_pulse = '0;
	   end
	s3:begin
	   nTrip_pulse = '1;
	   nMode_pulse = '0;
	   end
	s4:begin
	   nTrip_pulse = '0;
	   nMode_pulse = '1;
	   end
	s5:begin
	   nTrip_pulse = '1;
	   nMode_pulse = '1;
	   end
	s6:;
default:;
endcase
end
endmodule
