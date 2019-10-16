set overlay_name "ultra"
set design_name "ultra"

# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd

# set sdx platform properties
set_property PFM_NAME "xilinx.com:xd:${overlay_name}:1.0" \
        [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd]
set_property PFM.CLOCK { \
	clk_out1 {id "0" is_default "true" proc_sys_reset "psr_clk0_250"} \
	clk_out2 {id "1" is_default "false" proc_sys_reset "psr_clk1_500"} \
	clk_out3 {id "2" is_default "false" proc_sys_reset "psr_clk2_100"} \
	clk_out4 {id "3" is_default "false" proc_sys_reset "psr_clk3_300"} \
	}  [get_bd_cells /clk_wiz_0]
set_property PFM.AXI_PORT { \
    M_AXI_HPM0_FPD {memport "M_AXI_GP"} \
    M_AXI_HPM1_FPD {memport "M_AXI_GP"} \
    S_AXI_HP0_FPD {memport "S_AXI_HP" sptag "HP0" memory "ps_e_0 HP0_DDR_LOW"} \
    S_AXI_HP1_FPD {memport "S_AXI_HP" sptag "HP1" memory "ps_e_0 HP1_DDR_LOW"} \
    S_AXI_HP2_FPD {memport "S_AXI_HP" sptag "HP2" memory "ps_e_0 HP2_DDR_LOW"} \
    S_AXI_HP3_FPD {memport "S_AXI_HP" sptag "HP3" memory "ps_e_0 HP3_DDR_LOW"} \
    } [get_bd_cells /ps_e_0]

# skip irq0 (reserved by pynq for uio)
set intVar []
for {set i 0} {$i < 8} {incr i} {
    lappend intVar In$i {}
}
set_property PFM.IRQ $intVar [get_bd_cells /xlconcat_0]

set intVar2 []
for {set i 0} {$i < 8} {incr i} {
    lappend intVar2 In$i {}
}
set_property PFM.IRQ $intVar2 [get_bd_cells /xlconcat_1]

# generate dsa
write_dsa -force ./${overlay_name}.dsa
validate_dsa ./${overlay_name}.dsa
