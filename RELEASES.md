# Version 2.0.0 (2019-03-25)

  * Migrate to stretch-backports.
      * This fixes the watchdog timer.
      * A different `igb/e1000e hung at stats update` fix seems to be upstream.
      * `leds-apu2` is upstream now.
      * Update `gpio-nct5104d` for new GPIO interface.
        The chip `label`s of its two banks have to be unique now.
      * `ledtrig-netdev` is upstream now.
      * Exchange `ledtrig-morse` with a version proposed at upstream.
      * Update `i2c-gpio-custom` for new GPIO interface.
      * Update `spi-gpio-custom` for new GPIO interface.
      * Remove `w1-gpio-custom` for now due to new GPIO interface.
      * Use external regulatory database via CRDA again.

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
