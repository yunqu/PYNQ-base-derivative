overlay_name := hdmi
design_name := system
base_path := ../base
device := xc7z020clg400-1

all: base tcl xdc bit dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

base:
	@if [ ! -d "./base" ]; then \
		pushd $(base_path); \
		if [ ! -d "./base" ]; then \
			echo "Rebuilding base..."; make; \
		else \
			echo "Skipping base..."; \
		fi; \
		popd; \
		cp -rf $(base_path)/base base; \
	fi

tcl:
	vivado -mode batch -source \
	build_$(overlay_name)_$(design_name).tcl -notrace

xdc:
	@mkdir vivado
	@cd vivado ; mkdir constraints;
	@if [ -e "./vivado/constraints/$(overlay_name).xdc" ]; then \
	echo "Skipping constraints..."; \
	else echo "Rebuiding constraints..."; \
	grep "hdmi" $(base_path)/vivado/constraints/base.xdc > \
	./vivado/constraints/$(overlay_name).xdc; fi

bit:
	@sed -i "s/\(create_project \)\(.*\)\( -part \)\(.*\)"\
	"/\1$(overlay_name) $(overlay_name)\3$(device)/" \
	$(overlay_name).tcl; \
	sed -i '/# CHANGE DESIGN NAME HERE/i \
	set_property  ip_repo_paths ../../ip [current_project]\
	update_ip_catalog\
	' $(overlay_name).tcl; \
	vivado -mode batch -source \
	$(overlay_name).tcl build_bitstream.tcl -notrace

dsa:
	vivado -mode batch -source build_$(overlay_name)_dsa.tcl -notrace
	unzip -qo $(overlay_name).dsa -d .dsa
	cp -rf .dsa/$(design_name).hwh ./$(overlay_name).hwh

clean:
	rm -rf $(overlay_name) *.jou *.log
	rm -rf base
	rm -rf vivado
	rm -rf .dsa
