module divider #(parameter N = 64)(input logic [N-1:0] A,B,
				   input logic clk,nRst,start,
				   output logic [N-1:0] res,rem,
				   output logic ready);

timeunit 1ns;
timeprecision 100ps;

enum logic[2:0] {s0,s1,s2,s3,s4} state;
logic [6:0] counter;
logic [5:0] counterA;

always_ff@(posedge clk,negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= s0;
res <= '0;
rem <= '0;
counter <= '0;
counterA <= N-1;
end
else
begin
unique case(state)
	s0: begin
	    counter <= '0;
	    if(start)
	    begin
	    state <= s1;
	    end
	    res <= '0;
	    rem <= '0;
	    counterA <= N-1;
	    end
	s1: begin
	    rem <= {rem[N-2:0],A[counterA]};
	    state <= s2;
	    end
	s2: begin
	    if(counter < N)
	    begin
	    state <= s3;
	    if(rem >= B)
	    begin
	    rem <= rem - B;
	    res <= {res[N-2:0],1'b1};
	    end
	    else
	    res <= {res[N-2:0],1'b0};
	    end
	    else
	    state <= s4;
	    end
	s3: begin
	    counter <= counter + 1;
	    counterA <= counterA - 1;
	    state <= s1;
	    end
	s4: state <= s0;
endcase
end
end

always_comb
begin:comb
ready = '0;
unique case(state)
	s4: ready = '1;
	default:;
endcase
end
endmodule
