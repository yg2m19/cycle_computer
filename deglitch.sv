module deglitch (input logic nCrank,nFork,nTrip,nMode,clock,nRst,
		 output logic nCrank_deglitch,nFork_deglitch,nTrip_deglitch,nMode_deglitch,
	         output logic readyM, readyT);
timeunit 1ns;
timeprecision 100ps;

logic [8:0] deglitchC,deglitchF,deglitchT,deglitchM;
enum logic [2:0] {s0,s1} stateC,stateF,stateT,stateM;

always_ff@(posedge clock,negedge nRst)
begin:SEQ
if(!nRst)
begin
nCrank_deglitch <= nCrank;
nFork_deglitch <= nFork;
nTrip_deglitch <= nTrip;
nMode_deglitch <= nMode;
deglitchC <= '0;
deglitchF <= '0;
deglitchT <= '0;
deglitchM <= '0;
readyM <= '0;
readyT <= '0;
stateC <= s0;
stateF <= s0;
stateT <= s0;
stateM <= s0;
end
else
begin
unique case(stateC)
	s0: begin
	    nCrank_deglitch <= nCrank;
	    if(!nCrank)
	    stateC <= s1;
	    end
	s1: begin
	    if(nCrank)
	    begin
	    deglitchC <= deglitchC + 1;
	    if(deglitchC <= 320)
	    begin
	    nCrank_deglitch <= '1;
	    end
	    else
	    begin
	    deglitchC <= 321;
	    nCrank_deglitch <= nCrank;
	    //state <= s0;
	    end
	    end
	    if(!nCrank)
	    begin
	    deglitchC <= '0;
	    nCrank_deglitch <= nCrank;
	    stateC <= s0;
	    end
	    end
endcase

unique case(stateF)
	s0: begin
	    nFork_deglitch <= nFork;
	    if(!nFork)
	    stateF <= s1;
	    end
	s1: begin
	    if(nFork)
	    begin
	    deglitchF <= deglitchF + 1;
	    if(deglitchF <= 320)
	    begin
	    nFork_deglitch <= '1;
	    end
	    else
	    begin
	    deglitchF <= 321;
	    nFork_deglitch <= nFork;
	    end
	    end
	    if(!nFork)
	    begin
	    deglitchF <= '0;
	    nFork_deglitch <= nFork;
	    stateF <= s0;
	    end
	    end
endcase

unique case(stateT)
	s0: begin
	    nTrip_deglitch <= nTrip;
	    if(!nTrip)
	    stateT <= s1;
	    end
	s1: begin
	    if(nTrip)
	    begin
	    deglitchT <= deglitchT + 1;
	    if(deglitchT <= 320)
	    begin
	    nTrip_deglitch <= '0;
	    readyT <= '0;
	    end
	    else
	    begin
	    deglitchT <= 321;
	    nTrip_deglitch <= nTrip;
	    readyT <= '1;
	    stateT <= s0;
	    end
	    end
	    if(!nTrip)
	    begin
	    deglitchT <= '0;
	    nTrip_deglitch <= nTrip;
	    readyT <= '1;
	    stateT <= s1;
	    end
	    end
endcase

unique case(stateM)
	s0: begin
	    nMode_deglitch <= nMode;
	    if(!nMode)
	    stateM <= s1;
	    end
	s1: begin
	    if(nMode)
	    begin
	    deglitchM <= deglitchM + 1;
	    if(deglitchM <= 320)
	    begin
	    nMode_deglitch <= '0;
	    readyM <= '0;
	    end
	    else
	    begin
	    deglitchM <= 321;
	    nMode_deglitch <= nMode;
	    readyM <= '1;
	    stateM <= s0;
	    end
	    end
	    if(!nMode)
	    begin
	    deglitchM <= '0;
	    nMode_deglitch <= nMode;
	    readyM <= '1;
	    stateM <= s1;
	    end
	    end
endcase

end
end
endmodule
