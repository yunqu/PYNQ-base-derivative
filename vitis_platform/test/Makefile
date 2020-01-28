RM = rm -f
RMDIR = rm -rf

VITIS_PLATFORM := /home/yunq/Pynq-Python/PYNQ-derivative-overlays/vitis_platform/ZCU104/platforms/ultra/ultra.xpfm
PORT := HP0
VPP := $(XILINX_VITIS)/bin/v++
MPSOC_CXX := g++
VPP_COMMON_OPTS := -t hw --platform ${VITIS_PLATFORM} --save-temps
VPP_LINK_OPTS := --config connectivity-$(PORT).cfg

SOURCES = $(wildcard ${SOURCEDIR}/*.cpp)

KERN_NAME = vadd

all: xclbin elf

xclbin: binary_container_1/vadd.xclbin

elf: vadd.elf

.PHONY: all clean

binary_container_1/vadd.xo: vadd.cl
	@mkdir -p $(@D)
	-@$(RM) $@
	$(VPP) $(VPP_COMMON_OPTS) -c -k ${KERN_NAME} -o "$@" "$<"

binary_container_1/vadd.xclbin: binary_container_1/vadd.xo
	$(VPP) $(VPP_COMMON_OPTS) -l -o "$@" $(+) $(VPP_LINK_OPTS)

%.o: %.cpp
	${MPSOC_CXX} -std=c++11 -DDSA64 -c $^ -I/opt/xilinx/xrt/include -o $@

vadd.elf: host.o xcl2.o
	${MPSOC_CXX} $^ -L/usr/lib -lxilinxopencl -lxrt_core -o $@

clean:
	${RMDIR} *.o *.elf *.log .Xil
	${RMDIR} binary_container_1/ _x/

