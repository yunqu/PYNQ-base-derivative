set overlay_name "bare"
set design_name "bare"

# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd

# set sdx platform properties
set_property PFM_NAME "xilinx.com:xd:${overlay_name}:1.0" \
        [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd]
set_property PFM.CLOCK { \
    FCLK_CLK0 {id "0" is_default "true" \
		proc_sys_reset "rst_ps7_0_fclk0" status "fixed"} \
    FCLK_CLK1 {id "1" is_default "false" \
		proc_sys_reset "rst_ps7_0_fclk1" status "fixed"} \
    FCLK_CLK2 {id "2" is_default "false" \
		proc_sys_reset "rst_ps7_0_fclk2" status "fixed"} \
    FCLK_CLK3 {id "3" is_default "false" \
		proc_sys_reset "rst_ps7_0_fclk3" status "fixed"} \
    } [get_bd_cells /ps7_0]
set_property PFM.AXI_PORT { \
    M_AXI_GP0 {memport "M_AXI_GP"} \
    M_AXI_GP1 {memport "M_AXI_GP"} \
    S_AXI_ACP {memport "S_AXI_ACP"} \
    S_AXI_HP0 {memport "S_AXI_HP"} \
    S_AXI_HP1 {memport "S_AXI_HP"} \
    S_AXI_HP2 {memport "S_AXI_HP"} \
    S_AXI_HP3 {memport "S_AXI_HP"} \
    } [get_bd_cells /ps7_0]
set intVar []
for {set i 1} {$i < 16} {incr i} {
    lappend intVar In$i {}
}
set_property PFM.IRQ $intVar [get_bd_cells /xlconcat_0]
set_property platform.default_output_type "sd_card" [current_project]
set_property platform.design_intent.embedded "true" [current_project]
set_property platform.design_intent.server_managed "false" [current_project]
set_property platform.design_intent.external_host "false" [current_project]
set_property platform.design_intent.datacenter "false" [current_project]

# generate xsa
write_hw_platform -force ./${overlay_name}.xsa
validate_hw_platform ./${overlay_name}.xsa
