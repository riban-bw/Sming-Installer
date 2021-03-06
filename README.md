# Sming-Installer
This is a simple installer for [Sming](https://github.com/SmingHub/Sming), a C++ framework for the ESP8266 microcontroller.

This installer provides all the tools required to program the ESP8266 using the Sming framework. The aim is to reduce the friction in starting to use Sming. For Sming support visit [Sming at github](https://github.com/SmingHub/Sming) where there are various guides and supporting documentation.

To install Sming to your home directory (change '~' to your preferred install location), open a POSIX shell, e.g. bash, cygwin32, etc. then enter the following commands:

```
cd ~
wget https://github.com/riban-bw/Sming-Installer/raw/master/install.sh
chmod u+x install.sh
./install.sh
rm install.sh
```

A file called _setenv_ is created which may be sourced to set SMING_HOME, ESP_HOME and SDK_BASE:

```
. ~/Sming/setenv
```

Note: This is a simple bash script to install Sming which downloads precompiled packages. The actual heavy lifting is done by the Sming developers. This installer is here to ease your transition into the fun world of IoT development. Good luck and have fun.

The script accepts command line switches. For help:

```
./install.sh -h
```

Individual modules may be (re)installed using the -i switch, e.g.

```
./install.sh -i esptool
```

By default all modules are installed and user is prompted for action if an existing module is detected as being installed. This behaviour can be overriden, e.g. to install the SDK and the compiler and backup any exisiting installions:

```
./install.sh -b -i xtensa -i spiffy
```

# Current version of Sming: [3.8.0](https://github.com/SmingHub/Sming/releases/tag/3.8.0)

| Platform         | Notes        |  Status                                           |
|------------------|--------------|---------------------------------------------------|
| Linux i686       | 32-bit Linux | [![Build1][Linux_i686-badge]][travis-link]        |
| Linux x86_64     | 64-bit Linux | [![Build2][Linux_x86_64-badge]][travis-link]      |
| Linux armv6l     | Raspbery Pi  | ![notest-badge]                                   |
| Cygwin32 i686    | Windows      | [![Build4][Cygwin32_i686-badge]][appveyor-link]   |
| Cygwin32 x86_64  | Windows      | [![Build4][Cygwin32_x86_64-badge]][appveyor-link] |
| macOS x86_64     | OS X Dawin   | [![Build5][OSX-badge]][travis-link]               |

[pass-badge]: https://img.shields.io/badge/build-passing-brightgreen.svg
[fail-badge]: https://img.shields.io/badge/build-failure-red.svg
[notest-badge]: https://img.shields.io/badge/build-no%20CI-blue.svg
[Linux_i686-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Installer/branches/master/2
[Linux_x86_64-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Installer/branches/master/1
[Linux_armv6l-badge]: https://ci.appveyor.com/api/projects/status/3tcob4ifowxd5jfg?svg=true
[Cygwin32_i686-badge]: https://appveyor-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Installer/branch/master/1
[Cygwin32_x86_64-badge]: https://appveyor-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Installer/branch/master/2
[OSX-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Installer/branches/master/3

[travis-link]: https://travis-ci.org/riban-bw/Sming-Installer
[appveyor-link]: https://ci.appveyor.com/project/riban-bw/Sming-Installer

# Credits

ESP toolkit is built from [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk) by pfalcon

[Sming](https://github.com/SmingHub/Sming) developed by [SmingHub community](https://github.com/SmingHub/Sming/graphs/contributors)

[esptool2](https://github.com/raburton/esptool2) is provided by raburton (GPL V3)

[ESP SDK](http://bbs.espressif.com/viewforum.php?f=46) released by Espressif Systems

Travis-CI status badges for each build are provided by [bjfish](https://github.com/bjfish/travis-matrix-badges)

Appveyor-CI status badges for each build are provided by [tzachshabtay](https://github.com/tzachshabtay/appveyor-matrix-badges)

Static-ci status badges for each build are provided by [Shields IO](https://shields.io)

[Sming-Installer](https://github.com/riban-bw/Sming-Installer) developed by riban-bw
