set overlay_name "ultra"

# open block design
open_project ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${overlay_name}/${overlay_name}.bd

# Add top wrapper, no xdc files
make_wrapper -files [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${overlay_name}/${overlay_name}.bd] -top
add_files -norecurse ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${overlay_name}/hdl/${overlay_name}_wrapper.v
set_property top ${overlay_name}_wrapper [current_fileset]
update_compile_order -fileset sources_1

# set platform properties
set_property platform.default_output_type "sd_card" [current_project]
set_property platform.design_intent.embedded "true" [current_project]
set_property platform.design_intent.server_managed "false" [current_project]
set_property platform.design_intent.external_host "false" [current_project]
set_property platform.design_intent.datacenter "false" [current_project]

# call implement
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

# generate xsa
write_hw_platform -force ./${overlay_name}.xsa
validate_hw_platform ./${overlay_name}.xsa

# move and rename bitstream to final location
file copy -force ./${overlay_name}/${overlay_name}.runs/impl_1/${overlay_name}_wrapper.bit ${overlay_name}.bit

# copy hwh files
file copy -force ./${overlay_name}/${overlay_name}.gen/sources_1/bd/${overlay_name}/hw_handoff/${overlay_name}.hwh ${overlay_name}.hwh
