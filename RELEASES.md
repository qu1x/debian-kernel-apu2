# Version 1.0.0 (2019-02-02)

  * Fixed igb/e1000e hung at stats update.
  * Fixed high debug output when GPIO bit banging.
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
  * Enabled internal regulatory database making CRDA optional. The latest
    database will automatically be downloaded.
  * Enabled Dynamic Frequency Selection (DFS) for ath10k.
