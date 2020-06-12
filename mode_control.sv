module mode_control(input logic [9:0] odo_int,speedo_int,cad_final,mins,
		    input logic [3:0] odo_point,speedo_point,hour,
		    input logic [3:0] ws_digit1,ws_digit2,ws_digit3,
		    input logic clock,nRst,nMode,nTrip,ready,
		    output logic [3:0] bcd_out,nDigit,
		    output logic ws_en,DP);
timeunit 1ns;
timeprecision 100ps;

enum logic [4:0] {OD0,OD1,OD2,OD3,TD0,TD1,TD2,TD3,SD0,SD1,SD2,SD3,CD0,CD1,CD2,CD3,WD0,WD1,WD2,WD3} state;

logic [3:0] unit,ten,hun,point,point_in;
logic [9:0] int_in;
bcd b0 (int_in,{hun,ten,unit});
bcd_point bp(point_in,point);


always_ff @(posedge clock,negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= OD0;
bcd_out <= 8;
DP <= '1;
ws_en <= '0;
nDigit <= 4'b0; //all segments highlight when power on
end
else
begin
unique case (state)
	OD0: begin
	     if(!nMode)
	     begin
	     state <= TD0;
	     end
	     else
	     begin
	     int_in <= odo_int;
	     point_in <= odo_point;
	     nDigit <= 4'b0111;
	     bcd_out <= 10;
	     state <= OD1;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	OD1: begin
	     if(!nMode)
	     begin
	     state <= TD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1011;
	     bcd_out <= ten;
	     state <= OD2;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	OD2: begin
	     if(!nMode)
	     begin
	     state <= TD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1101;
	     bcd_out <= unit;
	     state <= OD3;
	     DP <= '1;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	OD3: begin
	     if(!nMode)
	     begin
	     state <= TD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1110;
	     bcd_out <= point;
	     state <= OD0;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	TD0: begin
	     if(!nMode)
	     begin
	     state <= CD0;
	     end
	     else
	     begin
	     int_in <= mins;
	     nDigit <= 4'b0111;
	     bcd_out <= 11;
	     state <= TD1;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	TD1: begin
	     if(!nMode)
	     begin
	     state <= CD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1011;
	     bcd_out <= hour;
	     state <= TD2;
	     DP <= '1;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	TD2: begin
	     if(!nMode)
	     begin
	     state <= CD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1101;
	     bcd_out <= ten;
	     state <= TD3;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	TD3: begin
	     if(!nMode)
	     begin
	     state <= CD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1110;
	     bcd_out <= unit;
	     state <= TD0;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	SD0: begin
	     if(!nMode)
	     begin
	     state <= OD0;
	     end
	     else
	     begin
	     int_in <= speedo_int;
	     point_in <= speedo_point;
	     nDigit <= 4'b0111;
	     bcd_out <= 12;
	     state <= SD1;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	SD1: begin
	     if(!nMode)
	     begin
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1011;
	     bcd_out <= ten;
	     state <= SD2;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	SD2: begin
	     if(!nMode)
	     begin
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1101;
	     bcd_out <= unit;
	     state <= SD3;
	     DP <= '1;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	SD3: begin
	     if(!nMode)
	     begin
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1110;
	     bcd_out <= point;
	     state <= SD0;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	CD0: begin
	     if(!nMode)
	     begin
	     state <= SD0;
	     end
	     else
	     begin
	     int_in <= cad_final;
	     nDigit <= 4'b0111;
	     bcd_out <= 13;
	     state <= CD1;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	CD1: begin
	     if(!nMode)
	     begin
	     state <= SD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1011;
	     bcd_out <= hun;
	     state <= CD2;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	CD2: begin
	     if(!nMode)
	     begin
	     state <= SD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1101;
	     bcd_out <= ten;
	     state <= CD3;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	CD3: begin
	     if(!nMode)
	     begin
	     state <= SD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1110;
	     bcd_out <= unit;
	     state <= CD0;
	     DP <= '1;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	WD0: begin
	     if(ready)
	     begin
	     ws_en <= '0;
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b0111;
	     bcd_out <= 14;
	     state <= WD1;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	WD1: begin
	     if(ready)
	     begin
	     ws_en <= '0;
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1011;
	     bcd_out <= ws_digit1;
	     state <= WD2;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	WD2: begin
	     if(ready)
	     begin
	     ws_en <= '0;
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1101;
	     bcd_out <= ws_digit2;
	     state <= WD3;
	     DP <= '0;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end
	WD3: begin
	     if(ready)
	     begin
	     ws_en <= '0;
	     state <= OD0;
	     end
	     else
	     begin
	     nDigit <= 4'b1110;
	     bcd_out <= ws_digit3;
	     state <= WD0;
	     DP <= '1;
	     end
	     if(!nMode&!nTrip)
	     begin
	     state <= WD0;
	     ws_en <= '1;
	     end
	     end

endcase
end
end
endmodule

