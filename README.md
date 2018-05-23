This repository makes it easier to generate derivatives from the base overlay 
in the PYNQ framework. The basic flow works like the following:

1. Copy the base project from the PYNQ repository. If the base project has not been built yet, build it.
2. Open the block design, strip down the base overlay by removing many components.
3. Write the updated block design into a new TCL file.
4. Regenerate the constraint file by removing unused IO.
5. Build the new project using the new TCL file, along with the new constraint file.
6. Generate DSA related files.

The make flow provided in this repository has to be run under Linux. 
The entire flow is automated.

## Quick Start

To use the make flow, the following steps have to be followed:

1. Make sure correct `settings.csh/sh` files are sourced. 
2. Go inside your local PYNQ repository. If not downloaded yet, run

	```shell
	git clone https://github.com/Xilinx/PYNQ.git <LOCAL_PYNQ_REPO>
	```

	You can also switch to the branch you want to work from. 

3. Clone this repository and copy the overlay folder into the local PYNQ repository.

    ```shell
	git clone https://github.com/yunqu/PYNQ-base-derivative.git PYNQ-base-derivative
	cp -rf PYNQ-base-derivative/<OVERLAY_NAME> <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/
    ```

4. Then you are ready to run the make process.

	```shell
	cd <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/<OVERLAY_NAME>
	make
	```

	It may take a few hours for the make process to finish. Once it is done,
	you will have all the corresponding overlay files.