module cad_behav (input logic nCrank,clock,nRst,
		  output logic [9:0]cad_final);
timeunit 1ns;
timeprecision 100ps;

logic [31:0]count_time,divd,cadence,rem,ctime;
logic [9:0]cad; //number of resolusion
logic ready,start;


enum logic [1:0] {s0,s1,s2,s3} state;

//(count_time/12800) = 60*12800/count_time
divider #(.N(32))d0(divd,ctime,clock,nRst,start,cadence,rem,ready);

always_ff @(posedge clock,negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= s0;
count_time <= '0;
cad <= '0;
divd <= '0;
cad_final <= '0;
start <= '0;
ctime <= '0;
end
else
begin
unique case(state)
	s0: begin
	    if(!nCrank)
	    begin
	    count_time <= '0;
	    divd <= 768000;
	    end
	    else
	    state <= s1;
	    end
	s1: begin
	    if(nCrank)
	    begin
	    count_time <= count_time + 1;
	    end
	    else
	    begin
	    if(!nCrank)
	    begin
	    count_time <= count_time + 1;
	    state <= s2;
	    end
	    end
	    end
	s2: begin
	    if(nCrank)
	    begin
	    start <= '1;
	    ctime <= count_time + 1;
	    count_time <= '0;
	    divd <= 768000;
	    state <= s0;
	    end
	    else
	    count_time <= count_time + 1;
	    end
	default: state <= s0;
endcase
if(ready)
cad_final <= cadence[9:0];
if(count_time >= 64000)
cad_final <= '0;
end
end
endmodule
