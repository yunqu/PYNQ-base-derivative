OL_PATH := ..
OVERLAY := hdmi
BOARD := Pynq-Z1
PROC := ps7_cortexa9_0

all: clean help platform

platform:
	@mkdir ./$(BOARD)/hw
	@cp -rf $(OL_PATH)/$(OVERLAY)/$(OVERLAY).dsa ./$(BOARD)/hw
	xsct -sdx build_pfm.tcl $(OVERLAY) $(BOARD) $(PROC)
	@cp -rf .build/$(OVERLAY)/export/$(OVERLAY) $(BOARD)-$(OVERLAY)
	@echo "Successfully finished building SDx platform."
	@echo "SDx platform stored in the folder $(BOARD)-$(OVERLAY)."

help:
	@echo "usage: make [target]"
	@echo
	@echo "arguments:"
	@echo "----------"
	@echo "OL_PATH:    path to the root of the overlay folder"
	@echo "            e.g., /home/usr/boards/Pynq-Z1"
	@echo "OVERLAY:    name of the overlay or dsa"
	@echo "            e.g., hdmi, bare"
	@echo "BOARD:      name of the board"
	@echo "            e.g., Pynq-Z1, Pynq-Z2"
	@echo "PROC:       name of the processor that can be targeted"
	@echo "            e.g., ps7_cortexa9_0, psu_cortexa53"
	@echo
	@echo "current configuration:"
	@echo "----------------------"
	@echo "make OL_PATH=$(OL_PATH) OVERLAY=$(OVERLAY) BOARD=$(BOARD) PROC=$(PROC)"
	@echo

clean:
	@rm -rf .build
	@rm -rf $(BOARD)-$(OVERLAY)
	@rm -rf ./$(BOARD)/hw
