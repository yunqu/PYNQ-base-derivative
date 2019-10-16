RM = rm -f
RMDIR = rm -rf

VITIS_PLATFORM = /group/xrlabs/yunq/public/vitis_platform_2019.1/ZCU104/ultra/ultra.xpfm
XOCC := xocc
MPSOC_CXX := g++
SYS_CONFIG := xrt
XOCC_OPTS = -t hw --platform ${VITIS_PLATFORM} --save-temps --clkid 0

SOURCES = $(wildcard ${SOURCEDIR}/*.cpp)

KERN_NAME = vadd

all: xclbin elf

xclbin: binary_container_1/vadd.xclbin

elf: vadd.elf

.PHONY: all clean

binary_container_1/vadd.xo: vadd.cl
	@mkdir -p $(@D)
	-@$(RM) $@
	$(XOCC) $(XOCC_OPTS) -c -k ${KERN_NAME} --nk ${KERN_NAME}:1 --xp misc:solution_name=${KERN_NAME} --temp_dir binary_container_1 --log_dir binary_container_1/logs -o "$@" "$<"

binary_container_1/vadd.xclbin: binary_container_1/vadd.xo
	$(XOCC) $(XOCC_OPTS) -l --nk ${KERN_NAME}:1 --xp misc::solution_name=link --temp_dir binary_container_1 --log_dir binary_container_1/logs --remote_ip_cache binary_container_1/ip_cache -o "$@" $(+) --sys_config ${SYS_CONFIG}

%.o: %.cpp
	${MPSOC_CXX} -std=c++11 -DDSA64 -c $^ -I/opt/xilinx/xrt/include -o $@

vadd.elf: host.o xcl2.o
	${MPSOC_CXX} $^ -L/opt/xilinx/xrt/lib -lxilinxopencl -lxrt_core -o $@

clean:
	${RM} *.o *.elf *.log

cleanall: clean
	${RMDIR} binary_container_1/
