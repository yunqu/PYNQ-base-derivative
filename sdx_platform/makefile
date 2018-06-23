DSA_PATH := ../hdmi/hdmi.dsa
OVERLAY := hdmi
BOARD := Pynq-Z1
PROC := ps7_cortexa9_0

# Test SDSoC Platform
BUILD_DIR := test/build
TEST_DIR := $(BUILD_DIR)/$(BOARD)-$(OVERLAY)
HW_FLAGS = -sds-hw adder adder.cpp -clkid 0 -sds-end
CFLAGS = -Wall -O3 -c -fPIC
CFLAGS += -MT"$@" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)"
LFLAGS = "$@" "$<" 
SDSFLAGS := -sds-pf $(CURDIR)/$(BOARD)/platforms/$(OVERLAY) -target-os linux
CPP := sds++ $(SDSFLAGS)
OBJECTS = $(CURDIR)/$(TEST_DIR)/main.o $(CURDIR)/$(TEST_DIR)/adder.o
LOGFILE = $(CURDIR)/$(TEST_DIR)/_sds/reports/sds.log

all: clean help platform

platform:
	@mkdir ./$(BOARD)/hw
	@mkdir -p ./$(BOARD)/platforms
	@cp -rf $(DSA_PATH) ./$(BOARD)/hw/$(OVERLAY).dsa
	xsct -sdx build_pfm.tcl $(OVERLAY) $(BOARD) $(PROC)
	@cp -rf .build/$(OVERLAY)/export/$(OVERLAY) $(BOARD)/platforms/$(OVERLAY)
	@echo "Successfully finished building SDx platform."
	@echo "SDx platform stored in the folder $(BOARD)/platforms/$(OVERLAY)."

help:
	@echo "usage: make [target]"
	@echo
	@echo "arguments:"
	@echo "----------"
	@echo "DSA_PATH:   path to the dsa file"
	@echo "            e.g., /home/usr/boards/Pynq-Z1/hdmi/hdmi.dsa"
	@echo "OVERLAY:    name of the overlay (must be same as the platform)"
	@echo "            e.g., hdmi, bare"
	@echo "BOARD:      name of the board"
	@echo "            e.g., Pynq-Z1, Pynq-Z2"
	@echo "PROC:       name of the processor that can be targeted"
	@echo "            e.g., ps7_cortexa9_0, psu_cortexa53"
	@echo
	@echo "current configuration:"
	@echo "----------------------"
	@echo "make DSA_PATH=$(DSA_PATH) OVERLAY=$(OVERLAY) BOARD=$(BOARD) PROC=$(PROC)"
	@echo

test: cleantest $(OBJECTS)
	mkdir -p $(TEST_DIR)
	@echo 'Building Target: $@'
	@echo 'Trigerring: SDS++ Linker'
	cd $(TEST_DIR) ; $(CPP) -o adder.elf $(OBJECTS)
	@echo 'SDx Completed Building Target: $@'
	@echo ' '
	@tput setaf 2; grep "ERROR" $(LOGFILE) || echo "PASS: Platform successfully tested"; tput sgr0;
	@echo ' '

$(CURDIR)/$(TEST_DIR)/%.o: $(CURDIR)/test/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: SDS++ Compiler'
	mkdir -p $(TEST_DIR)
	cd $(TEST_DIR) ; $(CPP) $(CFLAGS) -o $(LFLAGS) $(HW_FLAGS)
	@echo 'Finished building: $<'
	@echo ' '
	
cleanall: clean cleantest
	@rm -rf $(BOARD)/platforms

cleantest:
	@rm -rf $(TEST_DIR)
	
clean:
	@rm -rf .build
	@rm -rf $(BOARD)/platforms/$(OVERLAY)
	@rm -rf ./$(BOARD)/hw
