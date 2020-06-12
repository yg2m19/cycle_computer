///////////////////////////////////////////////////////////////////////
//
// options.sv - 2019/2020
//
//    This is a blank options file in which various compile time
//    options may be set
//
///////////////////////////////////////////////////////////////////////

// The following line specifies the clock period
//
`define clock_period 78125ns

// The following line indicates that a file "monitor.sv" exists and contains
// custom monitoring information
//
`define special_monitor

// The following line indicates that a file "stimulus.sv" exists and contains
// custom stimulus information
//
`define special_stimulus

// The following line indicates that the model does not support scan path
//  signals
//   (Test, SDI, SDO)
//
//`define no_scan_signals

// The following line indicates that the model supports separate scan control
//  signals
//   (Test, ScanEnable)
//
//`define scan_enable

// The following line indicates that the model does not properly simulate
//  the pullup behaviour of the pads and an external pullup should be
//  simulated.
//  (this overcomes a problem with the simulation of the ICUP pad cell) 
//
//`define external_pullup

// The following line indicates that synchronisation of inputs is a function
//  of the wrapper file: "computer.sv". This is a good place to do the
//  synchronisation if you wish to control the choice of gates used in the
//  synchroniser. 
//
//`define synchronise_inputs_within_wrapper

// The following line indicates that synchronisation of reset is a function
//  of the wrapper file: "computer.sv". This is a good place to do the
//  synchronisation if you wish to control the choice of gates used in the
//  synchroniser. 
//
`define synchronise_reset_within_wrapper

// The following line indicates that the stimulus should ensure that the
//  button signals are well behaved to avoid setup and hold violations
//  during simulation.
//
`define sanitise_input

// Uncomment the following line to indicate that your bicycle computer
//  supports an LCD display
//
//`define include_lcd

// The following line specifies the number of operating modes
//
`define num_modes 4

// The following lines specify the sequence of operating modes after reset
//
`define Mode0 Distance
`define Mode1 Duration
`define Mode2 Cadence
`define Mode3 Speed
