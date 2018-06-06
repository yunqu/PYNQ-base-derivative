if { $argc != 3 } {
        puts "The build_pfm.tcl script requires two input arguments."
        puts "Please try again."
    } else {
        set overlay_name [lindex $argv 0]
        set board [lindex $argv 1]
        set proc [lindex $argv 2]
        platform -name ${overlay_name} \
            -desc "${overlay_name} platform for PYNQ supported board" \
            -hw ${board}/hw/${overlay_name}.dsa -out .build -prebuilt
        system -name linux -display-name "Linux" \
            -boot ${board}/sw/boot \
            -readme ${board}/sw/generic.readme
        domain -name linux -proc ${proc} -os linux \
            -image ${board}/sw/linux/image 
        boot -bif ${board}/sw/linux/linux.bif

        platform -generate
    }
