OVERLAY := hdmi
ARCH := arm

all: clean
	@cp -rf ../$(OVERLAY)/$(OVERLAY).dsa .
	xsct -sdx build_pfm.tcl $(OVERLAY) $(ARCH)
	@cp -rf .build/$(OVERLAY)/export/$(OVERLAY) $(OVERLAY)
	@echo "Finished building SDx platform..."; \

clean:
	@rm -rf .build
	@rm -rf $(OVERLAY)
	@rm -rf $(OVERLAY).dsa
