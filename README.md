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
	git clone https://github.com/yunqu/PYNQ-derivative-overlays.git
    cp -rf PYNQ-derivative-overlays/<OVERLAY_NAME> <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/
    ```

4. Then you are ready to run the make process.

	```shell
    cd <LOCAL_PYNQ_REPO>/boards/Pynq-Z1/<OVERLAY_NAME>
	make
	```

	It may take a few hours for the make process to finish. Once it is done,
	you will have all the corresponding overlay files.

## Make Options

There are a few options that users can choose. For example, if users want to
make the bare overlay for a board equipped with `xc7z010clg400-1`, users can run

```shell
make device=xc7z010clg400-1
```

## Supported Overlays and Boards

* The `hdmi` overlay only has the video pipeline from the base overlay.
* The `bare` overlay does not even have the video pipeline compared to the `hdmi` overlay.

| Overlays        | Boards           | Devices          |
| --------------- |:----------------:| ----------------:|
| hdmi            | Pynq-Z1          | xc7z020clg400-1  |
| hdmi            | Pynq-Z2          | xc7z020clg400-1  |
| hdmi            | Arty-Z7-10       | xc7z010clg400-1  |
| bare            | Pynq-Z1          | xc7z020clg400-1  |
| bare            | Pynq-Z2          | xc7z020clg400-1  |
| bare            | Arty-Z7-10       | xc7z010clg400-1  |
