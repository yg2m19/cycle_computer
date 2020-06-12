module bcd_point (input logic [3:0] point,
		  output logic [3:0] pout);
timeunit 1ns;
timeprecision 100ps;

always_comb
unique case(point)
	4'b0000: pout = 4'b0000;
	4'b0001: pout = 4'b0001;
	4'b0010: pout = 4'b0001;
	4'b0011: pout = 4'b0010;
	4'b0100: pout = 4'b0011;
	4'b0101: pout = 4'b0011;
	4'b0110: pout = 4'b0100;
	4'b0111: pout = 4'b0100;
	4'b1000: pout = 4'b0101;
	4'b1001: pout = 4'b0110;
	4'b1010: pout = 4'b0110;
	4'b1011: pout = 4'b0111;
	4'b1100: pout = 4'b1000;
	4'b1101: pout = 4'b1000;
	4'b1110: pout = 4'b1001;
	4'b1111: pout = 4'b1001;
	default: pout = 4'b0000;
endcase
endmodule
	
	

