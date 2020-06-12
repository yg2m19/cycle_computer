// This special stimulus simulates a cycle journey with a gear change 

  // Hall-effect sensor stimulus
  //
  //  This default stimulus represents initial inactivity
  //  followed by pedalling at a constant rate for about 10 seconds 
  //  After this we go downhill - pedalling slower but travelling faster 
timeunit 1ns;
timeprecision 10ps;

  initial
    begin
      Crank = 0;
      #1.05s
      repeat(20)
        #500ms -> trigger_crank_sensor;
      forever
        #1000ms -> trigger_crank_sensor;
    end
  
  initial
    begin
      Fork = 0;
      #0.6s
      repeat(10)
        #1000ms -> trigger_fork_sensor;
      #0.2s
      forever
        #250ms -> trigger_fork_sensor;
    end
  
  // Button stimulus
  //
  //  

  initial
    begin
      Mode = 0;
      Trip = 0;
      mode_index = 0;
      #2s  -> press_trip_button;
    repeat(1000)
	#5s  -> press_mode_button;
	#0.5s
	forever


	#2s  -> press_mode_button;


   
    
    end
  


  // Stimulus not changed for
  // Clock nReset and scan path signals 

  initial
    begin
      Test = 0;
      SDI = 0;
      ScanEnable = 0;
      nReset = 0;
      #(`clock_period / 4) nReset = 1;
    end

  initial
    begin
      Clock = 0;
      #`clock_period
      forever
        begin
          Clock = 1;
          #(`clock_period / 2) Clock = 0;
          #(`clock_period / 2) Clock = 0;
        end
    end



