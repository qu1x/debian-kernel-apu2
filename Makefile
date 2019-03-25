# Copyright (c) 2017-2019 Rouven Spreckels <n3vu0r@qu1x.org>
#
# Usage of the works is permitted provided that
# this instrument is retained with the works, so that
# any entity that uses the works is notified of this instrument.
#
# DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

ifndef KREL
KREL := $(shell uname --kernel-release)
endif
ifndef KLOC
KLOC := -apu2
endif

KPKG := linux-source-$(shell echo $(KREL) | sed -E "s/([^.]+\.[^.]+).+/\1/")
KTAR := /usr/src/$(KPKG).tar.xz
KSRC := $(KPKG)/
KCFG := $(KSRC).config
SCFG := $(KSRC)scripts/config --file $(KCFG)

.PHONY: all
all: | $(KCFG)
	$(MAKE) -C $(KSRC) clean
	$(MAKE) -C $(KSRC) deb-pkg LOCALVERSION=$(KLOC)

.PHONY: clean
clean:
	rm -rf $(KSRC)debian
	rm -f $(KSRC).config*
	rm -f linux-*.deb linux-*.dsc linux-*.tar.gz linux-*.changes
	rm -f linux-*.diff.gz linux-*.buildinfo

.PHONY: distclean
distclean: clean
	rm -rf $(KSRC)

$(KSRC): | $(KTAR)
	tar -xaf $|
	cp -R debian $@
	cd $@ && quilt --quiltrc ../quiltrc push -a

$(KCFG): | $(KSRC)
	cp /boot/config-$(KREL) $(KCFG)
	$(SCFG) -d CONFIG_SYSTEM_TRUSTED_KEYRING
	$(SCFG) -d CONFIG_SYSTEM_TRUSTED_KEYS
	$(SCFG) -d DEBUG_INFO
	$(SCFG) -e CONFIG_MAC80211_RC_MINSTREL_VHT
	$(SCFG) -E CONFIG_CFG80211 CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS
	$(SCFG) -E CONFIG_CFG80211 CONFIG_ATH_REG_DYNAMIC_USER_REG_TESTING
	$(SCFG) -e CONFIG_CFG80211_CERTIFICATION_ONUS
	$(SCFG) -E CONFIG_ATH10K_TRACING CONFIG_ATH10K_DFS_CERTIFIED
	$(SCFG) -m LEDS_TRIGGER_NETDEV
	$(SCFG) -M LEDS_TRIGGER_NETDEV LEDS_TRIGGER_MORSE
	$(SCFG) -M GPIO_MOCKUP GPIO_NCT5104D
	$(SCFG) -M I2C_GPIO I2C_GPIO_CUSTOM
	$(SCFG) -m SPI_SPIDEV
	$(SCFG) -M SPI_GPIO SPI_GPIO_CUSTOM
	$(MAKE) -C $(KSRC) olddefconfig

$(KTAR):
	sudo apt install build-essential quilt
	sudo apt build-dep linux
	sudo apt install -t stretch-backports linux-source

Makefile:;
