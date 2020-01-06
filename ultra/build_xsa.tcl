set overlay_name "ultra"
set design_name "ultra"

# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd

# set sdx platform properties
set_property PFM_NAME "xilinx.com:xd:${overlay_name}:1.0" \
        [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd]
set_property PFM.CLOCK { \
	clk_out1 {id "0" is_default "true" \
		proc_sys_reset "psr_clk0_150" status "fixed"} \
	clk_out2 {id "1" is_default "false" \
		proc_sys_reset "psr_clk1_300" status "fixed"} \
	clk_out3 {id "2" is_default "false" \
		proc_sys_reset "psr_clk2_75" status "fixed"} \
	clk_out4 {id "3" is_default "false" \
		proc_sys_reset "psr_clk3_100" status "fixed"} \
	clk_out5 {id "4" is_default "false" \
		proc_sys_reset "psr_clk4_200" status "fixed"} \
	clk_out6 {id "5" is_default "false" \
		proc_sys_reset "psr_clk5_400" status "fixed"} \
	clk_out7 {id "6" is_default "false" \
		proc_sys_reset "psr_clk6_600" status "fixed"} \
	}  [get_bd_cells /clk_wiz_0]
set_property PFM.AXI_PORT { \
    M_AXI_HPM0_FPD {memport "M_AXI_GP"} \
    M_AXI_HPM1_FPD {memport "M_AXI_GP"} \
    S_AXI_HPC0_FPD {memport "S_AXI_HPC" sptag "HPC0" memory "ps_e_0 HPC0_DDR_LOW"} \
    S_AXI_HPC1_FPD {memport "S_AXI_HPC" sptag "HPC1" memory "ps_e_0 HPC1_DDR_LOW"} \
    S_AXI_HP0_FPD {memport "S_AXI_HP" sptag "HP0" memory "ps_e_0 HP0_DDR_LOW"} \
    S_AXI_HP1_FPD {memport "S_AXI_HP" sptag "HP1" memory "ps_e_0 HP1_DDR_LOW"} \
    S_AXI_HP2_FPD {memport "S_AXI_HP" sptag "HP2" memory "ps_e_0 HP2_DDR_LOW"} \
    S_AXI_HP3_FPD {memport "S_AXI_HP" sptag "HP3" memory "ps_e_0 HP3_DDR_LOW"} \
    } [get_bd_cells /ps_e_0]

# skip irq0 (reserved by pynq for uio)
set intVar []
for {set i 1} {$i < 8} {incr i} {
    lappend intVar In$i {}
}
set_property PFM.IRQ $intVar [get_bd_cells /xlconcat_0]

set intVar2 []
for {set i 0} {$i < 8} {incr i} {
    lappend intVar2 In$i {}
}
set_property PFM.IRQ $intVar2 [get_bd_cells /xlconcat_1]
set_property platform.default_output_type "sd_card" [current_project]
set_property platform.design_intent.embedded "true" [current_project]
set_property platform.design_intent.server_managed "false" [current_project]
set_property platform.design_intent.external_host "false" [current_project]
set_property platform.design_intent.datacenter "false" [current_project]

# generate xsa
write_hw_platform -force ./${overlay_name}.xsa
validate_hw_platform ./${overlay_name}.xsa
