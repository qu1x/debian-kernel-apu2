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

KPKG := linux-source-$(shell echo $(KREL) | sed -E "s/([^.]+\.[^.]).+/\1/")
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

.PHONY: distclean
distclean: clean
	rm -f db.txt
	rm -rf $(KSRC)

$(KSRC): db.txt | $(KTAR)
	tar -xaf $|
	cp db.txt $@/net/wireless
	cp -R debian $@
	cd $@ && quilt --quiltrc ../quiltrc push -a

db.txt:
	wget https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/\
wireless-regdb.git/plain/db.txt

$(KCFG): | $(KSRC)
	cp /boot/config-$(KREL) $(KCFG)
	$(SCFG) -e CONFIG_CFG80211_CERTIFICATION_ONUS
	$(SCFG) -e CONFIG_CFG80211_INTERNAL_REGDB
	$(SCFG) -E CONFIG_ATH10K_TRACING CONFIG_ATH10K_DFS_CERTIFIED
	$(SCFG) -d DEBUG_INFO
	$(SCFG) -m KEYBOARD_GPIO_POLLED
	$(SCFG) -M LEDS_MENF21BMC LEDS_APU2
	$(SCFG) -M LEDS_TRIGGER_HEARTBEAT LEDS_TRIGGER_NETDEV
	$(SCFG) -M LEDS_TRIGGER_NETDEV LEDS_TRIGGER_MORSE
	$(SCFG) -M GPIO_MOCKUP GPIO_NCT5104D
	$(SCFG) -M I2C_GPIO I2C_GPIO_CUSTOM
	$(SCFG) -m SPI_SPIDEV
	$(SCFG) -M SPI_GPIO SPI_GPIO_CUSTOM
	$(SCFG) -M W1_MASTER_GPIO W1_MASTER_GPIO_CUSTOM
	$(MAKE) -C $(KSRC) olddefconfig

$(KTAR):
	sudo apt-get install build-essential linux-source quilt
	sudo apt-get build-dep linux

Makefile:;
