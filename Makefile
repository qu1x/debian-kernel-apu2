# Copyright (c) 2017 Rouven Spreckels <n3vu0r@qu1x.org>
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
	rm -rf $(KSRC)

$(KSRC): | $(KTAR)
	tar -xaf $|
	cp -R debian $@
	cd $@ && quilt --quiltrc ../quiltrc push -a

$(KCFG): | $(KSRC)
	cp /boot/config-$(KREL) $@
	$|scripts/config --file $@ -d DEBUG_INFO
	$|scripts/config --file $@ -m KEYBOARD_GPIO_POLLED
	$|scripts/config --file $@ -M LEDS_MENF21BMC LEDS_APU2
	$|scripts/config --file $@ -M LEDS_TRIGGER_HEARTBEAT LEDS_TRIGGER_NETDEV
	$|scripts/config --file $@ -M LEDS_TRIGGER_NETDEV LEDS_TRIGGER_MORSE
	$|scripts/config --file $@ -M GPIO_MOCKUP GPIO_NCT5104D
	$|scripts/config --file $@ -M I2C_GPIO I2C_GPIO_CUSTOM
	$|scripts/config --file $@ -m SPI_SPIDEV
	$|scripts/config --file $@ -M SPI_GPIO SPI_GPIO_CUSTOM
	$|scripts/config --file $@ -M W1_MASTER_GPIO W1_MASTER_GPIO_CUSTOM

$(KTAR):
	sudo apt-get install build-essential linux-source
	sudo apt-get build-dep linux

Makefile:;
