module speedo_behav (input logic [31:0] perimeter,
		     input logic clock,nRst,nFork,
		     output logic [3:0]speedo_point,
		     output logic [9:0]speedo_int);
timeunit 1ns;
timeprecision 100ps;

logic [31:0] count_time;
logic [63:0] speedo,divd,speedo_final,ctime,speed,rem;
logic ready,start;

divider #(.N(64))d0(divd,ctime,clock,nRst,start,speed,rem,ready);

//perimeter/(count_time/12800)
enum logic [1:0] {noop,div} state;

assign speedo_int = speedo_final[31:22];
assign speedo_point = speedo_final[21:18];

always_ff @(posedge clock,negedge nRst)
begin:SEQ
if (!nRst)
begin
count_time <= '0;
speedo <= '0;
state <= noop;
divd <= '0;
speedo_final <= '0;
start <= '0;
end
else
begin
unique case(state)
	noop: begin
	      divd <= perimeter*46080000;
	      count_time <= count_time +1;
	      if(!nFork)
	      begin
	      count_time <= count_time + 1;
	      state <= div;  
	      end
	      end
	div: begin
	     if(!nFork)
	     count_time <= count_time + 1;
	     else
	     begin
	     ctime <= count_time+1;
	     start <= '1;
	     count_time <= '0;
	     speedo <= '0;
	     divd <= perimeter*46080000;
	     state <= noop;
	     end
	     
	     end
	default: state <= noop;
endcase
if(ready)
begin
speedo_final <= speed;
end
if(count_time >= 64000)
begin
speedo_final <= '0;
end
end
end

endmodule
