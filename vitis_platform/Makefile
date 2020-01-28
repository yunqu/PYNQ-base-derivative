XSA_PATH := ../ultra/ultra.xsa
OVERLAY := ultra
BOARD := ZCU104
PROC := psu_cortexa53
PORT := $(eval P := $$(shell platforminfo -p $(BOARD)/platforms/$(OVERLAY)/$(OVERLAY).xpfm | grep -m1 "Bus SP Tag: HP" | rev | cut -d " " -f 1 | rev ))$(P)
TEST_DIR := $(CURDIR)/test

all: clean help platform test

help:
	@echo "usage: make [target]"
	@echo
	@echo "options:"
	@echo "--------"
	@echo "help:       show help message."
	@echo "all:        make the Vitis platform, and test it."
	@echo "platform:   make the Vitis platform based on the input arguments."
	@echo "test:       do a simple test after a given platform is made."
	@echo "cleantest:  clean the test folder."
	@echo "clean:      clean test and Vitis platform for a given overlay."
	@echo
	@echo "arguments:"
	@echo "----------"
	@echo "XSA_PATH:   path to the xsa file"
	@echo "            e.g., /home/usr/boards/ZCU104/ultra/ultra.xsa"
	@echo "OVERLAY:    name of the overlay (must be same as the platform)"
	@echo "            e.g., ultra, bare, hdmi"
	@echo "BOARD:      name of the board"
	@echo "            e.g., ZCU104, Ultra96, ZCU111"
	@echo "PROC:       name of the processor that can be targeted"
	@echo "            e.g., psu_cortexa53, ps7_cortexa9"
	@echo
	@echo "current configuration:"
	@echo "----------------------"
	@echo "make XSA_PATH=$(XSA_PATH)"
	@echo "     OVERLAY=$(OVERLAY)"
	@echo "     BOARD=$(BOARD)"
	@echo "     PROC=$(PROC)"
	@echo

platform:
	mkdir -p ./$(BOARD)/platforms
	xsct -sdx build_pfm.tcl $(XSA_PATH) $(OVERLAY) $(BOARD) $(PROC)
	rm -rf ./$(BOARD)/platforms/$(OVERLAY)
	cp -rf ./$(BOARD)/output/$(OVERLAY)/export/$(OVERLAY) \
	$(BOARD)/platforms/$(OVERLAY)
	@echo "Successfully finished building vitis platform."
	@echo "Vitis platform stored in $(BOARD)/platforms/$(OVERLAY)."

test: cleantest
	@echo 'Building Test Project'
	cd $(TEST_DIR) && \
	make xclbin \
	VITIS_PLATFORM=../$(BOARD)/platforms/$(OVERLAY)/$(OVERLAY).xpfm \
	PORT=$(PORT) && \
	cd ..
	@echo 'Completed Building Test Project'
	@echo
	@tput setaf 2; echo "PASS: Platform successfully tested."; tput sgr0;
	@echo

cleantest:
	cd test && make clean

clean: cleantest
	rm -rf ./*/output
