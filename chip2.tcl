compile

compile -scan

set_dft_signal -view existing_dft -type ScanClock   -port Clock  -timing {5 15}
    set_dft_signal -view existing_dft -type Reset       -port nReset -active_state 0

    set_dft_signal -view spec         -type ScanEnable  -port Test   -active_state 1
    set_dft_signal -view spec         -type ScanDataIn  -port SDI 
    set_dft_signal -view spec         -type ScanDataOut -port SDO 

create_test_protocol

dft_drc

set_dft_configuration -fix_reset enable
    set_autofix_configuration -type reset -method gate -control Test

    set_dft_configuration -fix_set enable
    set_autofix_configuration -type set -method gate -control Test

set_scan_configuration -chain_count 1
    preview_dft
    insert_dft

report_qor
report_power
report_timing

report_area > synth_area.rpt
report_power > synth_power.rpt
report_timing > synth_timing.rpt

report_names -rules verilog
change_names -rules verilog -hierarchy -verbose
write -f verilog -hierarchy -output "../gate_level/computer.v"
write_sdc ../constraints/computer.sdc
write_sdf ../gate_level/computer.sdf


