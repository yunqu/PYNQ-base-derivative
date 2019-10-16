set dsa_path [lindex $argv 0]
set overlay_name [lindex $argv 1]
set board [lindex $argv 2]
set processor [lindex $argv 3]

platform -name ${overlay_name} -desc "A vitis platform for ${board}" \
	-hw ${dsa_path} -out ./${board}/output -prebuilt

system -name xrt \
	-display-name "OpenCL Linux" \
	-boot ./${board}/src/boot \
	-readme ./${board}/src/generic.readme
domain -name xrt -proc ${processor} -os linux \
	-image ./${board}/src/a53/xrt/image
sysconfig config -bif ./${board}/src/a53/xrt/linux.bif
domain -runtime opencl
domain -prebuilt-data ./${board}/src/prebuilt
platform -generate
