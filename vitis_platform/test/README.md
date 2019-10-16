# Vector Addition Example

This is an example of the vector addition accelerator on PYNQ. 
This is based on 2019.1 or later Vitis tools.

## Compiling hardware project

The hardware project has to be compiled on an X86 host. You probably want
to source Vitis and XRT settings before you build the hardware project.

```
make xclbin
```

The make process is going to pick up the vitis platform you specified in
the `Makefile`, or you can provide that platform as an additional argument
to the make process.

After some time, you should be able to see the `*.xclbin` file generated.
You need to copy `*.xclbin` and the bitstream onto the board.

To rebuild the hardware project, you can run `make cleanall` first to remove
the Vivado project completely.

## Compiling software executable

The software executable needs to be compiled on the board (or in a QEMU
environment). 

```
make elf
```

The executable can then be run on the board. Make sure you at least load
the bitstream once on the board before you run the program.

```
./vadd.elf
```

You should be able to see some messages like `TEST PASSED` in your terminal.
To rebuild the software executable, you can run `make clean` first to just
remove the target binaries.
