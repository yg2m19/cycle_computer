module trip_behav (input logic clock,nRst,nTrip,nFork,
		   output logic[3:0]hour,
		   output logic[9:0]mins);
logic [19:0] count_time,count_time_temp;
logic [5:0] min;
//logic [3:0] hour_temp;

enum logic [1:0] {init,count1,count2,calcu} state;

timeunit 1ns;
timeprecision 100ps;

assign mins = {4'b0000,min};

always_ff @(posedge clock, negedge nRst)
begin:SEQ
if(!nRst)
begin
state <= init;
count_time <= '0;
min <= '0;
hour <= '0;
count_time_temp <= '0;
end
else
begin
unique case(state)
	init: begin
	      if (count_time >= 768000)	//60sec
	      begin
              min <= min + 1;
	      count_time <= count_time - 768000;
	      if (min == 59)
	      begin
	      min <= '0;
	      hour <= hour + 1;
	      if(hour == 9)
	      begin
	      hour <= '0;
	      end
	      end
	      end
	      count_time_temp <= count_time_temp + 1;
	      state <= count1;
	      if(!nTrip)
	      begin
	      state <= init;
	      count_time <= '0;
	      count_time_temp <= '0;
	      min <= '0;
	      hour <= '0;
	      end
	      end
	count1: begin
	       if(nFork)
	       count_time_temp <= count_time_temp + 1;
	       else
	       begin
	       state <= count2;
	       end
	       if(!nTrip)
	       begin
	       state <= init;
	       count_time <= '0;
	       count_time_temp <= '0;
	       min <= '0;
	       hour <= '0;
	       end
	       end

	count2: begin
		if(!nFork)
		count_time_temp <= count_time_temp + 1;
		else
	        begin
		state <= calcu;
	        end
	        if(!nTrip)
	        begin
	        state <= init;
	        count_time <= '0;
	        count_time_temp <= '0;
	        min <= '0;
	        hour <= '0;
	        end
		//count_time_temp <= count_time_temp + 1;
		end
		
	calcu: begin
	       if(count_time_temp <= 64000) //max time per ratote
	       begin
	       count_time <= count_time + count_time_temp;
	       state <= init;
	       count_time_temp <= '0;
	       end
	       else
	       begin
	       state <= init;
	       count_time_temp <= '0;
	       end
	       if(!nTrip)
	       begin
	       state <= init;
	       count_time <= '0;
	       count_time_temp <= '0;
	       min <= '0;
	       hour <= '0;
	       end
	       end
endcase
end
end
endmodule

