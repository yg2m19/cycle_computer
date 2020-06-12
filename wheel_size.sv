
module wheel_size(input logic clock,nRst,nTrip,nMode,ws_en,
		  output logic [3:0]Digit1,Digit2,Digit3,
		  output logic [31:0] perimeter,
		  output logic ready);

timeunit 1ns;
timeprecision 100ps;


logic [63:0] peri;
logic [31:0] pi,dia;

assign pi = {8'b00000000,24'b110010001111010111000010}; //value of pi


enum logic[2:0]{start,setD1,setD2,setD3,finish} state;

always_ff @(posedge clock,negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= start;
Digit1 <= 4'b0000;
Digit2 <= 4'b0000;
Digit3 <= 4'b0000;
ready <= '0;
end
else
begin
//if(ws_en)
//begin
unique case(state)
	start: begin
	       if(ws_en)
	       begin
	       state <= setD1;
	       end
			if(!nTrip&!nMode)
			 begin
			 state <= start;
			 Digit1 <= 4'b0000;
			 Digit2 <= 4'b0000;
			 Digit3 <= 4'b0000;
			 ready <= '0;
			 end
	       end
	setD1: begin
	       if(!nTrip)
	       begin
	       Digit1 <= Digit1 + 1;
	       end
	       if(Digit1 == 9)
	       begin
	       if(!nTrip)
	       Digit1 <= '0;
	       end
	       if(!nMode)
	       begin
	       state <= setD2;
	       end
			 if(!nTrip&!nMode)
			 begin
			 state <= start;
			 Digit1 <= 4'b0000;
			 Digit2 <= 4'b0000;
			 Digit3 <= 4'b0000;
			 ready <= '0;
			 end
	       end
	setD2: begin
	       if(!nTrip)
	       begin
	       Digit2 <= Digit2 + 1;
	       end
	       if(Digit2 == 9)
	       begin
	       if(!nTrip)
	       Digit2 <= '0;
	       end
	       if(!nMode)
	       begin
	       state <= setD3;
	       end
			 if(!nTrip&!nMode)
			 begin
			 state <= start;
			 Digit1 <= 4'b0000;
			 Digit2 <= 4'b0000;
			 Digit3 <= 4'b0000;
			 ready <= '0;
			 end
	       end
	setD3: begin	      
	       if(!nTrip)
	       begin
	       Digit3 <= Digit3 + 1;
	       end
	       if(Digit3 == 9)
	       begin
	       if(!nTrip)
	       Digit3 <= '0;
	       end
	       if(!nMode)
	       begin
	       state <= finish;
	       end
			 if(!nTrip&!nMode)
			 begin
			 state <= start;
			 Digit1 <= 4'b0000;
			 Digit2 <= 4'b0000;
			 Digit3 <= 4'b0000;
			 ready <= '0;
			 end
	       end
	finish: begin
			 ready <= '1;
			 if(!nTrip&!nMode)
			 begin
			 state <= start;
			 Digit1 <= 4'b0000;
			 Digit2 <= 4'b0000;
			 Digit3 <= 4'b0000;
			 ready <= '0;
			 end
			  end
	default: begin
		 ready <= '0;
		 state <= start;
		 Digit1 <= 4'b0000;
		 Digit2 <= 4'b0000;
		 Digit3 <= 4'b0000;
		 end
endcase
end
end

//0000000000000110100100 100mm
//0000000000000000101010 10mm
//0000000000000000000100 1mm

logic [13:0] digit1,digit1_1,digit1_2,digit1_3,digit1_tot;
assign digit1 = {2'b0,Digit1,8'b0};
assign digit1_1 = {3'b0,Digit1,7'b0};
assign digit1_2 = {5'b0,Digit1,5'b0};
assign digit1_3 = {8'b0,Digit1,2'b0};
assign digit1_tot = digit1 + digit1_1 + digit1_2 + digit1_3;

logic [13:0] digit2,digit2_1,digit2_2,digit2_tot;
assign digit2 = {5'b0,Digit2,5'b0};
assign digit2_1 = {7'b0,Digit2,3'b0};
assign digit2_2 = {9'b0,Digit2,1'b0};
assign digit2_tot = digit2 + digit2_1 + digit2_2;

logic [13:0] digit3;
assign digit3 = {8'b0,Digit3,2'b0};


always_comb
begin:COMB
perimeter = {10'b0,22'b0000000010001011111111};//default 2136mm
dia = 32'b0;
peri = 64'b0;
if(ready)
begin
dia = {18'b0,digit1_tot} + {18'b0,digit2_tot} + {18'b0,digit3};
peri = dia * pi;//optimization
perimeter = peri [53:22];
end
end
endmodule

