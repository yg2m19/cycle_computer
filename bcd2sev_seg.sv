module bcd2sev_seg (input logic [3:0] bcd_in,
		    output logic segA,segB,segC,segD,segE,segF,segG);
timeunit 1ns;
timeprecision 100ps;

always_comb
unique case(bcd_in)
	0:begin
		segA = '1;

	  segF = '1;	segB = '1;

		segG = '0;

	  segE = '1;	segC = '1;

		segD = '1;
	  end


	1: begin
		segA = '0;

	  segF = '0;	segB = '1;

		segG = '0;

	  segE = '0;	segC = '1;

		segD = '0;
	   end

	2: begin
		segA = '1;

	  segF = '0;	segB = '1;

		segG = '1;

	  segE = '1;	segC = '0;

		segD = '1;
	   end

	3: begin
		segA = '1;

	  segF = '0;	segB = '1;

		segG = '1;

	  segE = '0;	segC = '1;

		segD = '1;
	   end

	4: begin
		segA = '0;

	  segF = '1;	segB = '1;

		segG = '1;

	  segE = '0;	segC = '1;

		segD = '0;
	   end

	5: begin
		segA = '1;

	  segF = '1;	segB = '0;

		segG = '1;

	  segE = '0;	segC = '1;

		segD = '1;
	   end

	6: begin
		segA = '1;

	  segF = '1;	segB = '0;

		segG = '1;

	  segE = '1;	segC = '1;

		segD = '1;
	   end

	7: begin
		segA = '1;

	  segF = '0;	segB = '1;

		segG = '0;

	  segE = '0;	segC = '1;

		segD = '0;
	   end

	8: begin
		segA = '1;

	  segF = '1;	segB = '1;

		segG = '1;

	  segE = '1;	segC = '1;

		segD = '1;
	   end

	9: begin
		segA = '1;

	  segF = '1;	segB = '1;

		segG = '1;

	  segE = '0;	segC = '1;

		segD = '1;
	   end

	10: begin		//d
		segA = '0;

	  segF = '0;	segB = '1;

		segG = '1;

	  segE = '1;	segC = '1;

		segD = '1;
	    end

	11: begin		//t
		segA = '0;

	  segF = '1;	segB = '0;

		segG = '1;

	  segE = '1;	segC = '0;

		segD = '1;
	    end

	12: begin		//v
		segA = '0;

	  segF = '0;	segB = '0;

		segG = '0;

	  segE = '0;	segC = '1;

		segD = '1;
	    end
	
	13: begin		//c
		segA = '0;

	  segF = '0;	segB = '0;

		segG = '1;

	  segE = '1;	segC = '0;

		segD = '1;
	    end

	14: begin		//digit 0 display nothing in wheelsize
		segA = '0;

	  segF = '0;	segB = '0;

		segG = '0;

	  segE = '0;	segC = '0;

		segD = '0;
	    end

	default: begin
			segA = '1;

	  	segF = '1;	segB = '0;

			segG = '1;

	  	segE = '1;	segC = '0;

			segD = '1;
		  end
endcase
endmodule
