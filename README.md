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

This repository also facilitates the automated flow for building Vitis
platforms.

## Quick Start

To use the make flow, the following steps have to be followed:

1. Make sure correct Vivado settings files are sourced. 
2. Clone this repository:

	```shell
	git clone https://github.com/yunqu/PYNQ-derivative-overlays.git <LOCAL_PYNQ_DERIV_REPO>
	```

3. (Optional) If your desired overlay has a *starting point* as listed in the
   end of this README (i.e., your desired overlay is derived from a parent
   overlay), clone the PYNQ repository and copy the desired overlay folder
   into the local PYNQ folder.

    ```shell
	git clone https://github.com/Xilinx/PYNQ.git <LOCAL_PYNQ_REPO>
   cp -rf <LOCAL_PYNQ_DERIV_REPO>/<OVERLAY_NAME> <LOCAL_PYNQ_REPO>/boards/<STARTING_POINT>/
    ```

4.  Then you are ready to create the derivate overlay. For overlays derived
	from a parent overlay, run:
	
	```shell
    cd <LOCAL_PYNQ_REPO>/boards/<STARTING_POINT>/<OVERLAY_NAME>
	make
	```

	For overlays that do no require a parent overlay, run:

	```shell
    cd <LOCAL_PYNQ_DERIV_REPO>/<OVERLAY_NAME>
	make
	```
	
	Once it is done, you will have all the corresponding overlay files. 
	Most importantly, you will have the `<OVERLAY_NAME>.xsa` file ready.

    There are a few options that users can choose. For example, if users want 
    to make the overlay for another board, users can run
    
    ```shell
    make BOARD=Pynq-Z2
    ```

    To check the boards supported for each overlay, users can refer to the table 
    listed at the end of this README.

5. (Optional) If you want to generate a Vitis platform for a specific board:
	```shell
    cd <LOCAL_PYNQ_DERIV_REPO>/vitis_platform
    make XSA_PATH=<XSA_PATH> BOARD=<BOARD_NAME>
   ```
	For example, to make the `dpu` Vitis platform for ZCU104:
	```shell
	cd <LOCAL_PYNQ_DERIV_REPO>/vitis_platform
	make XSA_PATH=../dpu/dpu.xsa BOARD=ZCU104
	```
	If users want to test whether the generated platform is valid:
	```shell
	make test XSA_PATH=../dpu/dpu.xsa BOARD=ZCU104
	```
	Additional information can be found using `make help`. 


## Supported Overlays and Boards

Although the starting point of the make process can be the same board, 
the derivative overlays finally can target multiple boards.

The parent overlay is the original overlay that the derivative overlays
depend on. If there is no parent overlay, you can build the corresponding 
derivative overlay anywhere (not necessarily from the starting point folder).

| Overlays        | Boards           | Starting Point | Parent Overlay |
|:--------------- |:-----------------|----------------|----------------|
| hdmi            | Pynq-Z1          | Pynq-Z1        | base           |
| hdmi            | Pynq-Z2          | Pynq-Z1        | base           |
| hdmi            | Arty-Z7-10       | Pynq-Z1        | base           |
| hdmi            | Arty-Z7-20       | Pynq-Z1        | base           |
| bare            | Pynq-Z1          | -              | -              |
| bare            | Pynq-Z2          | -              | -              |
| bare            | Arty-Z7-10       | -              | -              |
| bare            | Arty-Z7-20       | -              | -              |
| ultra           | Ultra96          | -              | -              |
| ultra           | ZCU104           | -              | -              |
| ultra           | ZCU111           | -              | -              |
| dpu             | Ultra96          | -              | -              |
| dpu             | ZCU104           | -              | -              |
| dpu             | ZCU111           | -              | -              |
