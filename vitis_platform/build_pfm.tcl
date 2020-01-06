set xsa_path [lindex $argv 0]
set overlay_name [lindex $argv 1]
set board [lindex $argv 2]
set processor [lindex $argv 3]

platform -name ${overlay_name} -desc "A vitis platform for ${board}" \
	-hw ${xsa_path} -out ./${board}/output -prebuilt

domain -name xrt -proc ${processor} -os linux \
	-image ./${board}/src/a53/xrt/image
domain config -boot ./${board}/src/boot
domain config -bif ./${board}/src/a53/xrt/linux.bif
domain -runtime opencl
domain -prebuilt-data ./${board}/src/prebuilt
platform -generate
