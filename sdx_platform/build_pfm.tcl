if { $argc != 2 } {
        puts "The build_pfm.tcl script requires two input arguments."
        puts "Please try again."
    } else {
        set overlay_name [lindex $argv 0]
        set arch [lindex $argv 1]
        platform -name ${overlay_name} \
            -desc "${overlay_name} platform for PYNQ supported board" \
            -hw ${overlay_name}.dsa -out .build -prebuilt
        system -name linux -display-name "Linux" \
            -boot ${arch}/boot \
            -readme ${arch}/generic.readme
        domain -name linux -proc ps7_cortexa9_0 -os linux \
            -image ${arch}/image 
        boot -bif ${arch}/linux.bif

        platform -generate
    }
