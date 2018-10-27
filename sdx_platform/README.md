# SDx Platforms

The SDx platform make flow is compatible with the SD image building flow of
PYNQ. In this repository, only empty `linux.bif` and `image.ub` files are 
provided; no `*.elf` files are provided.
So users will NOT be able to use SDx to build a bootable image. 
The SD image building flow of PYNQ is recommended for that purpose.

If users for some reasons want to build the SDx platforms with the 
real binary files, they can run the following command inside `sdbuild` 
folder of the PYNQ repository:

```shell
make sdx_sw
```

Users will then be able to get the real `sw` component of the SDx 
platform. Again, this is not mandatory for building an SDx platform.

## Test

By default, the make flow will run test against a newly built SDx platform.
The test consists of an addition over 2 arrays.

## SDx on PYNQ

To use SDx built projects on PYNQ, a simple set of instructions are provided.
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
