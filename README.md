# debian-kernel-apu2

**Debian Kernel Patched for PC Engines' APU2**

## Parallel Building

```sh
time make -j $(grep -c '^processor' /proc/cpuinfo)
```

## Installation

```sh
sudo dpkg -i linux-image-*_amd64.deb
sudo dpkg -i linux-headers-*_amd64.deb
```

## License

Copyright (c) 2017 Rouven Spreckels <n3vu0r@qu1x.org>

Usage of the works is permitted provided that
this instrument is retained with the works, so that
any entity that uses the works is notified of this instrument.

DISCLAIMER: THE WORKS ARE WITHOUT WARRANTY.

## Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the works by you shall be licensed as above, without any
additional terms or conditions.
