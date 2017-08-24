# Version 1.0.0 (2017-08-24)

  * Fixed igb/e1000e hung at stats update.
  * Enabled following modules:
      - gpio-keys-polled
  * Added APU2 drivers:
      - leds-apu2
      - gpio-nct5104d
  * Added LED triggers:
      - ledtrig-netdev
      - ledtrig-morse
  * Added GPIO bitbang drivers:
      - spi-gpio-custom
      - i2c-gpio-custom
      - w1-gpio-custom
  * Enabled and imported internal regulatory database making CRDA optional.
  * Enabled Dynamic Frequency Selection (DFS) for ath10k.
