# Version 2.0.0 (2019-03-27)

  * Migrate to stretch-backports.
    * Fixes the watchdog timer.
    * Fixes `igb/e1000e hung at stats update`.
    * Supports `leds-apu`.
    * Supports `ledtrig-netdev`.
  * Do not enforce EEPROM regulatory restrictions by `ath`.
  * Enable Dynamic Frequency Selection (DFS) for `ath10k`.
    * Uses external regulatory database via `crda`.
  * Support `gpio-nct5104d` with new GPIO interface.
    * The chip `label`s of its two banks have to be unique now.
  * Support `ledtrig-morse` with a version proposed at upstream.
  * Update `i2c-gpio-custom` for new GPIO interface.
  * Update `spi-gpio-custom` for new GPIO interface.

# Version 1.0.0 (2019-02-02)

  * Fixed `igb/e1000e hung at stats update`.
  * Fixed high debug output when GPIO bit banging.
  * Enabled following modules:
    - `gpio-keys-polled`
  * Added APU2 drivers:
    - `leds-apu2`
    - `gpio-nct5104d`
  * Added LED triggers:
    - `ledtrig-netdev`
    - `ledtrig-morse`
  * Added GPIO bitbang drivers:
    - `spi-gpio-custom`
    - `i2c-gpio-custom`
    - `w1-gpio-custom`
  * Enabled internal regulatory database making `crda` optional. The latest
    database will automatically be downloaded.
  * Enabled Dynamic Frequency Selection (DFS) for `ath10k`.
