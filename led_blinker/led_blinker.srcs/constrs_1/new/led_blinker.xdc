set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {clk}]; #125 MHz
create_clock -add -name sys_clk_pin -period 4.00 -waveform {0 2} [get_ports {clk}];

set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_port {led}];

set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_port {rst}];