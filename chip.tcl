analyze -format sv "../behavioural/bcd.sv ../behavioural/bcd2sev_seg.sv ../behavioural/bcd_point.sv ../behavioural/cad_behav.sv ../behavioural/comp_core.sv  ../behavioural/computer.sv ../behavioural/deglitch.sv ../behavioural/divider.sv ../behavioural/mode_control.sv ../behavioural/odo_behav.sv ../behavioural/pulse_gen.sv ../behavioural/speedo_behav.sv ../behavioural/trip_behav.sv ../behavioural/wheel_size.sv"


elaborate computer
change_selection computer

set_dont_touch [get_cells SYNC_*]
set_dont_touch [get_cells SYNC_DFC1_1]
set_dont_touch [get_cells SYNC_DFC1_2]

create_clock -period 78125 -name master_clock [get_ports Clock]
set_clock_latency     2.5 [get_clocks master_clock]
set_clock_transition  0.5 [get_clocks master_clock]
set_clock_uncertainty 1.0 [get_clocks master_clock]

set_input_delay  12.0 -max -network_latency_included -clock master_clock \
    [remove_from_collection [all_inputs] [get_ports Clock]]
set_input_delay  0.5 -min -network_latency_included -clock master_clock \
    [remove_from_collection [all_inputs] [get_ports Clock]]

set_output_delay 8.0 -max -network_latency_included -clock master_clock \
    [all_outputs]
set_output_delay 0.5 -min -network_latency_included -clock master_clock \
    [all_outputs]

set_load 1.0  -max [all_outputs]
set_load 0.01 -min [all_outputs]

set_driving_cell -max -library c35_IOLIB_WC -lib_cell BU24P -pin PAD [all_inputs]
set_driving_cell -min -library c35_IOLIB_WC -lib_cell BU1P  -pin PAD [all_inputs]

set_false_path -from [get_ports nReset]


set_max_area 0


