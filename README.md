# Sming-Release
This is a simple installer for [Sming](https://github.com/SmingHub/Sming), a C++ framework for the ESP8266 microcontroller.

This installer provides all the tools required to program the ESP8266 using the Sming framework. The aim is to reduce the friction in starting to use Sming. For Sming support visit [Sming at github](https://github.com/SmingHub/Sming) where there are various guides and supporting documentation.

To install Sming to your home directory (change '~' to your preferred install location), open a POSIX shell, e.g. bash, cygwin32, etc. then enter the following commands:

```
cd ~
wget https://github.com/riban-bw/Sming-Release/raw/master/install.sh
chmod u+x install.sh
./install.sh
rm install.sh
```

Note: This is a simple bash script to install Sming which downloads precompiled packages. The actual heavy lifting is done by the Sming developers. This installer is here to ease your transition into the fun world of IoT development. Good luck and have fun.

# Current version of Sming: [3.5.0](https://github.com/SmingHub/Sming/releases/tag/3.5.0)

| Platform         | Notes        |  Status                                           |
|------------------|--------------|---------------------------------------------------|
| Linux i686       | 32-bit Linux | [![Build1][Linux_i686-badge]][travis-link]      |
| Linux x86_64     | 64-bit Linux | [![Build2][Linux_x86_64-badge]][travis-link]      |
| Linux armv6l     | Raspbery Pi  | ![pass-badge]                                     |
| Cygwin32 i686    | Windows      | [![Build4][Cygwin32_i686-badge]][appveyor-link]   |
| Cygwin32 x86_64  | Windows      | [![Build4][Cygwin32_x86_64-badge]][appveyor-link] |
| OS X x86_64      | Mac OS       | [![Build5][OSX-badge]][travis-link]               |

[pass-badge]: https://img.shields.io/badge/build-passing-brightgreen.svg
[fail-badge]: https://img.shields.io/badge/build-failure-red.svg
[Linux_i686-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/2
[Linux_x86_64-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/1
[Linux_armv6l-badge]: https://ci.appveyor.com/api/projects/status/3tcob4ifowxd5jfg?svg=true
[Cygwin32_i686-badge]: https://appveyor-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branch/master/1
[Cygwin32_x86_64-badge]: https://appveyor-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branch/master/2
[OSX-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/3

[travis-link]: https://travis-ci.org/riban-bw/Sming-Release
[appveyor-link]: https://ci.appveyor.com/project/riban-bw/sming-release

# Credits

ESP toolkit is built from [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk) by pfalcon

[Sming](https://github.com/SmingHub/Sming) developed by [SmingHub community](https://github.com/SmingHub/Sming/graphs/contributors)

[esptool2](https://github.com/raburton/esptool2) is provided by raburton (GPL V3)

[ESP SDK](http://bbs.espressif.com/viewforum.php?f=46) released by Espressif Systems

Travis-CI status badges for each build are provided by [bjfish](https://github.com/bjfish/travis-matrix-badges)

Appveyor-CI status badges for each build are provided by [tzachshabtay](https://github.com/tzachshabtay/appveyor-matrix-badges)

[Sming-Release](https://github.com/riban-bw/Sming-Release) developed by riban-bw
