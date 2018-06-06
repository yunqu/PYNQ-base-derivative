overlay_name := ultra
design_name := system
sensors96b_path := ../sensors96b
device := xczu3eg-sbva484-1-i

all: sensors96b tcl bit dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

sensors96b:
	@if [ ! -d "./sensors96b" ]; then \
		pushd $(sensors96b_path); \
		if [ ! -d "./sensors96b" ]; then \
			echo "Rebuilding sensors96b..."; make; \
		else \
			echo "Skipping sensors96b..."; \
		fi; \
		popd; \
		cp -rf $(sensors96b_path)/sensors96b sensors96b; \
	fi

tcl:
	vivado -mode batch -source \
	build_$(overlay_name)_$(design_name).tcl -notrace

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
	rm -rf sensors96b
	rm -rf .dsa
