`include "options.sv"
module comp_core (input logic Clock,nReset,nMode,nTrip,nFork,nCrank,
		   output logic SegA,SegB,SegC,SegD,SegE,SegF,SegG,DP,
		   output logic [3:0] nDigit);

timeunit 1ns;
timeprecision 100ps;

logic [31:0] perimeter;
logic ready,ws_en,readyM,readyT;
logic [9:0] odo_int,speedo_int,cad_final,mins;
logic [3:0] ws_digit1,ws_digit2,ws_digit3,bcd_out,odo_point,speedo_point,hour;
logic nCrank_deglitch,nFork_deglitch,nTrip_deglitch,nMode_deglitch,nTrip_pulse,nMode_pulse;

/*logic sync_nReset_1,sync_nReset_2;

always @( posedge Clock, negedge nReset )
  if ( ! nReset )
    begin
      sync_nReset_1 <= '0;
      sync_nReset_2 <= '0;
    end
  else
    begin
      sync_nReset_1 <= '1;
      sync_nReset_2 <= sync_nReset_1;
    end
*/
logic sync_nMode_1, sync_nMode_2;
logic sync_nTrip_1, sync_nTrip_2;
logic sync_nFork_1, sync_nFork_2;
logic sync_nCrank_1, sync_nCrank_2;

always_ff @( posedge Clock, negedge nReset )
  if ( ! nReset )
    begin
      sync_nMode_1   <= '1;
      sync_nMode_2   <= '1;

      sync_nTrip_1   <= '1;
      sync_nTrip_2   <= '1;

      sync_nFork_1   <= '1;
      sync_nFork_2   <= '1;

      sync_nCrank_1   <= '1;
      sync_nCrank_2   <= '1;
    end
  else
    begin
      sync_nMode_1   <= nMode;
      sync_nMode_2   <= sync_nMode_1;

      sync_nTrip_1   <= nTrip;
      sync_nTrip_2   <= sync_nTrip_1;

      sync_nFork_1   <= nFork;
      sync_nFork_2   <= sync_nFork_1;

      sync_nCrank_1   <= nCrank;
      sync_nCrank_2   <= sync_nCrank_1;
    end


deglitch d0(.nCrank(sync_nCrank_2),.nFork(sync_nFork_2),.nTrip(sync_nTrip_2),.nMode(sync_nMode_2),.clock(Clock),.nRst(nReset),.nCrank_deglitch(nCrank_deglitch),.nFork_deglitch(nFork_deglitch),.nTrip_deglitch(nTrip_deglitch),.nMode_deglitch(nMode_deglitch),.readyM(readyM),.readyT(readyT));

pulse_gen pg0(.nTrip(nTrip_deglitch),.nMode(nMode_deglitch),.clock(Clock),.nRst(nReset),.readyM(readyM),.readyT(readyT),.nTrip_pulse(nTrip_pulse),.nMode_pulse(nMode_pulse));

speedo_behav sb0(.perimeter(perimeter),.clock(Clock),.nRst(nReset),.nFork(nFork_deglitch),.speedo_point(speedo_point),.speedo_int(speedo_int));

odo_behav ob0(.clock(Clock),.nFork(nFork_deglitch),.nRst(nReset),.nTrip(nTrip_pulse),.perimeter(perimeter),.odo_int(odo_int),.odo_point(odo_point));

bcd2sev_seg bss0(.bcd_in(bcd_out),.segA(SegA),.segB(SegB),.segC(SegC),.segD(SegD),.segE(SegE),.segF(SegF),.segG(SegG));

mode_control mc0(.odo_int(odo_int),.speedo_int(speedo_int),.cad_final(cad_final),.mins(mins),.odo_point(odo_point),.speedo_point(speedo_point),.hour(hour),
		 .ws_digit1(ws_digit1),.ws_digit2(ws_digit2),.ws_digit3(ws_digit3),.clock(Clock),.nRst(nReset),.nMode(nMode_pulse),.nTrip(nTrip_pulse),.ready(ready),.bcd_out(bcd_out),
		 .nDigit(nDigit),.ws_en(ws_en),.DP(DP));

wheel_size wsi0(.clock(Clock),.nRst(nReset),.nTrip(nTrip_pulse),.nMode(nMode_pulse),.ws_en(ws_en),.Digit1(ws_digit1),.Digit2(ws_digit2),.Digit3(ws_digit3),.perimeter(perimeter),.ready(ready));

trip_behav tb0(.clock(Clock),.nRst(nReset),.nTrip(nTrip_pulse),.nFork(nFork_deglitch),.hour(hour),.mins(mins));

cad_behav cb0(.nCrank(nCrank_deglitch),.clock(Clock),.nRst(nReset),.cad_final(cad_final));
endmodule

