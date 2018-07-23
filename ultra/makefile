overlay_name := ultra
design_name := ultra
device := xczu3eg-sbva484-1-i

all: bit dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

bit:
	@sed -i "s/\(create_project \)\(.*\)\( -part \)\(.*\)"\
	"/\1$(overlay_name) $(overlay_name)\3$(device)/" \
	$(overlay_name).tcl; \
	sed -i 's/^set design_name \(.*\)/set design_name $(design_name)/g' \
	$(overlay_name).tcl; \
	vivado -mode batch -source \
	$(overlay_name).tcl build_bitstream.tcl -notrace

dsa:
	vivado -mode batch -source build_$(overlay_name)_dsa.tcl -notrace
	unzip -qo $(overlay_name).dsa -d .dsa
	cp -rf .dsa/$(design_name).hwh ./$(overlay_name).hwh

clean:
	rm -rf $(overlay_name) *.jou *.log
	rm -rf .dsa
