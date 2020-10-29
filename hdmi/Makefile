overlay_name := hdmi
base_path := ../base

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

all: base tcl xdc block_design bitstream check_timing
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

base:
	@if [ ! -d "./base" ]; then \
		pushd $(base_path); \
		if [ ! -d "./base" ]; then \
			echo "Rebuilding base..."; make hls_ip block_design; \
		else \
			echo "Skipping base..."; \
		fi; \
		popd; \
		cp -rf $(base_path)/base base; \
	fi

tcl:
	vivado -mode batch -source modify_parent.tcl -notrace

xdc:
	@mkdir vivado
	@cd vivado ; mkdir constraints;
	@if [ -e "./vivado/constraints/$(overlay_name).xdc" ]; then \
	echo "Skipping constraints..."; \
	else echo "Rebuiding constraints..."; \
	grep "hdmi" $(base_path)/vivado/constraints/base.xdc > \
	./vivado/constraints/$(overlay_name).xdc; fi

block_design:
	@sed -i "s/\(create_project \)\(.*\)\( -part \)\(.*\)"\
	"/\1$(overlay_name) $(overlay_name)\3$(device)/" \
	$(overlay_name).tcl; \
	sed -i '/# CHANGE DESIGN NAME HERE/i \
	set_property  ip_repo_paths ../../ip [current_project]\
	update_ip_catalog\
	' $(overlay_name).tcl; \
	sed -i 's/^set design_name \(.*\)/set design_name $(overlay_name)/g' \
	$(overlay_name).tcl; \
	vivado -mode batch -source $(overlay_name).tcl -notrace

bitstream:
	vivado -mode batch -source build_bitstream.tcl -notrace

check_timing:
	vivado -mode batch -source check_timing.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA
	rm -rf base
	rm -rf vivado
