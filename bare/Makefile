overlay_name := bare

BOARD=Pynq-Z1
ifeq ($(BOARD),Pynq-Z1)
	device=xc7z020clg400-1
endif
ifeq ($(BOARD),Pynq-Z2)
	device=xc7z020clg400-1
endif
ifeq ($(BOARD),Arty-Z7-10)
	device=xc7z010clg400-1
endif
ifeq ($(BOARD),Arty-Z7-20)
	device=xc7z020clg400-1
endif
ifndef device
$(error Please set BOARD to one of the supported boards)
endif

all: block_design bitstream check_timing
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

block_design:
	@sed -i "s/\(create_project \)\(.*\)\( -part \)\(.*\)"\
	"/\1$(overlay_name) $(overlay_name)\3$(device)/" \
	$(overlay_name).tcl; \
	sed -i 's/^set design_name \(.*\)/set design_name $(overlay_name)/g' \
	$(overlay_name).tcl; \
	vivado -mode batch -source $(overlay_name).tcl -notrace

bitstream:
	vivado -mode batch -source build_bitstream.tcl -notrace

check_timing:
	vivado -mode batch -source check_timing.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA
