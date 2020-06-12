module odo_behav (input logic clock, nFork,nRst,nTrip,
		  input logic [31:0] perimeter,
		  output logic [9:0] odo_int,
		  output logic [3:0] odo_point);
timeunit 1ns;
timeprecision 100ps;

logic [31:0] res;
logic count_odo;

enum logic [2:0] {start, next, Wait/*, round*/} state;

always_ff @(posedge clock, negedge nRst)
begin: SEQ
if(!nRst)
begin
	state <= start;
	count_odo <= '0;
	res <= '0;
end
else
begin
 unique case(state)
	start:begin
	      if (!nFork)
	      begin
	      count_odo <= '0;
	      state <= Wait;
	      end
	      if(!nTrip)
	      begin
	      state <= start;
	      count_odo <= '0;
	      res <= '0;
	      end
	      end
	Wait: begin
	      if(nFork)
	      begin
	      state <= next;
	      end
	      if(!nTrip)
	      begin
	      state <= start;
	      count_odo <= '0;
	      res <= '0;
	      end
	      end
	next: begin
	      if (!nFork)
	      begin
	      state <= start;
	      count_odo <= '1;
	      res <= res + perimeter;
	      end
	      if(!nTrip)
	      begin
	      state <= start;
	      count_odo <= '0;
	      res <= '0;
	      end
	      end
	default: state <= start;
endcase
/*if(count_odo==1)
begin
res <= res + perimeter;
end*/
end
end

always_comb
begin:COMB
odo_int = {3'b000,res[28:22]};
odo_point = res[21:18];
end
endmodule

