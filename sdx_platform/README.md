# SDx Platforms

Our SDx platform building flow does not depend on the overlay; i.e., we can
just use any DSA file to construct the corresponding SDx platform.
All we need to specify is:
```shell
make DSA_PATH=<your_dsa> OVERLAY=<your_overlay> BOARD=<your_board_name> PROC=<processor_type>
```

For example, the PYNQ overlays usually come with DSA files (or make flows
to generate the DSA files). Suppose you have the DSA file ready, you can 
directly update the `make` parameters above to generate its corresponding 
SDx platform:
```shell
make DSA_PATH=../base/base.dsa OVERLAY=base BOARD=Pynq-Z1 PROC=ps7_cortexa9_0
```

Note that the above script is just an example; the base overlay may not be the 
perfect example, since it has already used the majority of the PL resources.

More details can be seen by running:
```shell
make help
```

## Getting `sw` components
The SDx platform make flow is compatible with the SD image building flow of
PYNQ. In this repository, only empty `linux.bif` and `image.ub` files are 
provided; no `*.elf` files are provided.
So users will NOT be able to use SDx to build a bootable image. 
The SD image building flow of PYNQ is recommended for that purpose.

If users for some reasons want to build the SDx platforms with the 
real binary files, they can run `make sdx_sw` inside `sdbuild` 
folder of the PYNQ repository.

Users will then be able to get the real `sw` component of the SDx 
platform. Again, this is not mandatory for building an SDx platform.


## Verification Test

By default, the make flow will run test against a newly built SDx platform.
The test consists of an addition over 2 arrays.

## Porting onto PYNQ

To use SDx projects on PYNQ, a simple set of instructions are provided.
Usually users have to make these steps a single script, or put them inside 
`setup.py` for pip-installable python package.

1. Copy the `*.so` inside `<sdx_project>` onto the board; 
   rename it to `<overlay_name>.so`.
2. Copy the `*.so.bit` file inside `<sdx_project>` onto the board; 
   rename it to `<overlay_name>.bit`.
3. Copy the `*.tcl` or `*.hwh` files onto the board (or copy both). 
   A typical path for these files can be:
   `<sdx_project>/_sds/p0/vivado/prj/prj.srcs/sources_1/bd/<bd_name>/hw_handoff/`.
   These files should stay in the same folder as the `<overlay_name>.bit`. 
   Rename them to `<overlay_name>.tcl` and `<overlay_name>.hwh`.
4. In jupyter notebook, download the overlay, and set `xlnk` library:
   ```python
   from pynq import Overlay, Xlnk
   ol = Overlay('<absolute_path>/<overlay_name>.bit')
   Xlnk.set_allocator_library('<absolute_path>/<overlay_name>.so')
   ```
5. Identify the CFFI interface from the SDx project. This can be found inside
   `<sdx_project>/_sds/swstubs/<your_function>.cpp`. SDx will rewrite your
   C function for hardware acceleration. For example, you can find something 
   like:
   ```c
   #include "cf_stub.h"
   #ifdef __cplusplus
   extern "C" {
   #endif
   void _p0_adder_1_noasync(data_t* ain, data_t* bin, data_t* cout, int N);
   #ifdef __cplusplus
   }
   #endif
   ```
   Then in your notebook, define it like:
   ```python
   import cffi
   ffi = cffi.FFI()
   ffi.cdef("void _p0_adder_1_noasync(data_t* ain, data_t* bin, data_t* cout, int N);")
   dlib = ffi.dlopen('<absolute_path>/<overlay_name>.so')
   ```
6. In case you need to allocate contiguous memory:
   ```python
   xlnk = Xlnk()
   ain = xlnk.cma_array(shape=(100,), dtype=np.uint32)
   bin = xlnk.cma_array(shape=(100,), dtype=np.uint32)
   cout = xlnk.cma_array(shape=(100,), dtype=np.uint32)
   ```
7. Call the function. For example,
   ```python
   dlib._p0_adder_1_noasync(ain.pointer, bin.pointer, cout.pointer, 100)
   ```
8. Verify the result.
9. Remember to free all the contiguous memory if any. The easiest way is:
   ```python
   xlnk.xlnk_reset()
   ```
