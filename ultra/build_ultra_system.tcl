set overlay_name "ultra"
set design_name "system"

# open block design
open_project {./sensors96b/sensors96b.xpr}
open_bd_design {./sensors96b/sensors96b.srcs/sources_1/bd/system/system.bd}

# delete uart0, uart1, and gpio
delete_bd_objs [get_bd_nets axi_uart16550_0_ip2intc_irpt] [get_bd_nets uart0_ctsn] [get_bd_nets axi_uart16550_0_rtsn] [get_bd_nets sin_1] [get_bd_nets axi_uart16550_0_sout] [get_bd_intf_nets ps8_0_axi_periph_M00_AXI] [get_bd_cells axi_uart16550_0]
delete_bd_objs [get_bd_ports uart0_rtsn]
delete_bd_objs [get_bd_ports uart0_txd]
delete_bd_objs [get_bd_ports uart0_rxd]
delete_bd_objs [get_bd_ports uart0_ctsn]
delete_bd_objs [get_bd_intf_nets zynq_ultra_ps_e_0_GPIO_0] [get_bd_intf_ports gpio_sensors]
delete_bd_objs [get_bd_nets zynq_ultra_ps_e_0_emio_uart0_rtsn] [get_bd_ports bt_rtsn]
delete_bd_objs [get_bd_intf_nets zynq_ultra_ps_e_0_UART_1] [get_bd_intf_ports uart1]
delete_bd_objs [get_bd_nets emio_uart0_ctsn_1] [get_bd_ports bt_ctsn]
delete_bd_objs [get_bd_nets proc_sys_reset_0_interconnect_aresetn] [get_bd_nets proc_sys_reset_0_peripheral_aresetn] [get_bd_intf_nets zynq_ultra_ps_e_0_M_AXI_HPM0_LPD] [get_bd_cells ps8_0_axi_periph]

# disable M_AXI_GP2
startgroup
set_property -dict [list CONFIG.PSU__USE__M_AXI_GP2 {0}] [get_bd_cells ps_e_0]
endgroup

# fix interrupt
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
endgroup
set_property name constant0 [get_bd_cells xlconstant_0]
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells constant0]
connect_bd_net [get_bd_pins constant0/dout] [get_bd_pins xlconcat_0/In0]

# add clock resets
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_2
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_3
endgroup
connect_bd_net [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins ps_e_0/pl_resetn0]
connect_bd_net [get_bd_pins proc_sys_reset_2/ext_reset_in] [get_bd_pins ps_e_0/pl_resetn0]
connect_bd_net [get_bd_pins proc_sys_reset_3/ext_reset_in] [get_bd_pins ps_e_0/pl_resetn0]
connect_bd_net [get_bd_pins ps_e_0/pl_clk1] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
connect_bd_net [get_bd_pins ps_e_0/pl_clk2] [get_bd_pins proc_sys_reset_2/slowest_sync_clk]
connect_bd_net [get_bd_pins ps_e_0/pl_clk3] [get_bd_pins proc_sys_reset_3/slowest_sync_clk]

# write new tcl file
validate_bd_design
write_bd_tcl -force ${overlay_name}.tcl
