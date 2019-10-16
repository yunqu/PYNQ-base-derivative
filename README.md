# PYNQ Derivative Overlays

This repository makes it easier to generate derivatives from the overlays 
in the PYNQ framework. Taking the `base` overlay as a starting point,
the basic flow works like the following:

1. Copy the base overlay project from the PYNQ repository. If the project has not been built yet, build it.
2. Open the block design, strip down the original overlay by removing many components.
3. Write the updated block design into a new TCL file.
4. Regenerate the constraint file by removing unused IO.
5. Build the new project using the new TCL file, along with the new constraint file.
6. Generate DSA related files.

The make flow provided in this repository has to be run under Linux. 
The entire flow is **automated**.

This repository also facilitates the automated flow for building SDx/Vitis
platforms. Note that starting from Xilinx 2019.1 tools, 
SDx tools are gradually deprecated.

## Quick Start

To use the make flow, the following steps have to be followed:

1. Make sure correct Vivado settings files are sourced. 
2. Go inside your local PYNQ repository. If not downloaded yet, run

	```shell
	git clone https://github.com/Xilinx/PYNQ.git <LOCAL_PYNQ_REPO>
	```

	You can also switch to the branch you want to work from. 

3. Clone this repository and copy the overlay folder into the local PYNQ repository.

    ```shell
	git clone https://github.com/yunqu/PYNQ-derivative-overlays.git <LOCAL_PYNQ_DERIV_REPO>
    cp -rf <LOCAL_PYNQ_DERIV_REPO>/<OVERLAY_NAME> <LOCAL_PYNQ_REPO>/boards/<STARTING_POINT>/
    ```
    
    Different overlays may need to be built from different starting points. 
    To change the starting point, users can refer to the table listed at the end of 
    this README.

4. Then you are ready to run the make process.

	```shell
    cd <LOCAL_PYNQ_REPO>/boards/<STARTING_POINT>/<OVERLAY_NAME>
	make
	```

	It may take a few hours for the make process to finish. Once it is done,
	you will have all the corresponding overlay files. Most importantly,
    you will have the `<OVERLAY_NAME>.dsa` file ready.
    
    There are a few options that users can choose. For example, if users want 
    to make the bare overlay for a board equipped with `xc7z010clg400-1`, users can run
    
    ```shell
    make device=xc7z010clg400-1
    ```
    To check the boards and devices supported, users can refer to the table 
    listed at the end of this README.

5. ~~(Deprecated soon) If you want to generate the corresponding SDx platform for a specific board:~~
	```shell
    cp -rf PYNQ-derivative-overlays/sdx_platform <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/
    cd <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/sdx_platform
    make
    ```
    ~~Additional options to build SDx platforms can be found using `make help`. 
    Basically users are allowed to change the overlay name, 
    the root of the overlay folder, the processor name, etc.~~

6. (Optional) If you want to generate the corresponding Vitis platform for a specific board:
	```shell
    cd <LOCAL_PYNQ_DERIV_REPO>/vitis_platform
    make
    ```
    Additional options to build platforms can be found using `make help`. 
    Basically users are allowed to change the overlay name, 
    the root of the overlay folder, the processor name, etc.


## Supported Overlays and Boards

Although the starting point of the make process can be the same board, 
the derivative overlays finally can target multiple boards.

The parent overlay is the original overlay that the derivative overlays
depend on. If there is no parent overlay, you can build the corresponding 
derivative overlay anywhere (not necessarily from the starting point folder).

| Overlays        | Boards           | Devices              | Starting Point | Parent Overlay |
|:--------------- |:-----------------|:---------------------|----------------|----------------|
| hdmi            | Pynq-Z1          | xc7z020clg400-1      | Pynq-Z1        | base           |
| hdmi            | Pynq-Z2          | xc7z020clg400-1      | Pynq-Z1        | base           |
| hdmi            | Arty-Z7-10       | xc7z010clg400-1      | Pynq-Z1        | base           |
| hdmi            | Arty-Z7-20       | xc7z020clg400-1      | Pynq-Z1        | base           |
| bare            | Pynq-Z1          | xc7z020clg400-1      | -              | -              |
| bare            | Pynq-Z2          | xc7z020clg400-1      | -              | -              |
| bare            | Arty-Z7-10       | xc7z010clg400-1      | -              | -              |
| bare            | Arty-Z7-20       | xc7z020clg400-1      | -              | -              |
| ultra           | Ultra96          | xczu3eg-sbva484-1-i  | -              | -              |
| ultra           | ZCU104           | xczu7ev-ffvc1156-2-e | -              | -              |
