DSA_PATH := ../hdmi/hdmi.dsa
OVERLAY := hdmi
BOARD := Pynq-Z1
PROC := ps7_cortexa9_0

all: clean help platform

platform:
	@mkdir ./$(BOARD)/hw
	@cp -rf $(DSA_PATH) ./$(BOARD)/hw/$(OVERLAY).dsa
	xsct -sdx build_pfm.tcl $(OVERLAY) $(BOARD) $(PROC)
	@cp -rf .build/$(OVERLAY)/export/$(OVERLAY) $(BOARD)-$(OVERLAY)
	@echo "Successfully finished building SDx platform."
	@echo "SDx platform stored in the folder $(BOARD)-$(OVERLAY)."

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

clean:
	@rm -rf .build
	@rm -rf $(BOARD)-$(OVERLAY)
	@rm -rf ./$(BOARD)/hw
