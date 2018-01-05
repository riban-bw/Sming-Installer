# Sming-Release
This is a simple installer for [Sming](https://github.com/SmingHub/Sming), a C++ framework for the ESP8266 microcontroller.

This installer provides all the tools required to program the ESP8266 using the Sming framework. The aim is to reduce the friction in starting to use Sming. For Sming support visit [Sming at github](https://github.com/SmingHub/Sming) where there are various guides and supporting documentation.

To install Sming to your home directory (change '~' to your preferred install location), open a POSIX shell, e.g. bash, cygwin32, etc. then enter the following commands:

```
cd ~
wget https://tinyurl.com/SmingInstall
. SmingInstall
rm SmingInstall
```

Note: This is a simple bash script to install Sming which downloads precompiled packages. The actual heavy lifting is done by the Sming developers. This installer is here to ease your transition into the fun world of IoT development. Good luck and have fun.

# Current version of Sming: [3.5.0](https://github.com/SmingHub/Sming/releases/tag/3.5.0)

| Platform         | Notes        |  Status                             |
|------------------|--------------|-------------------------------------|
| Linux i686       | 32-bit Linux | [![Build1][1-badge]][travis-link]   |
| Linux x86_64     | 64-bit Linux | [![Build2][2-badge]][travis-link]   |
| Linux armv6l     | Raspbery Pi  | ![pass-badge]                       |
| Windows Cygwin32 | Windows      | [![Build4][4-badge]][appveyor-link] |
| OS X x86_64      | Mac OS       | [![Build5][5-badge]][travis-link]   |

[pass-badge]: https://img.shields.io/badge/build-passing-brightgreen.svg
[fail-badge]: https://img.shields.io/badge/build-failure-red.svg
[1-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/2
[2-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/1
[4-badge]: https://ci.appveyor.com/api/projects/status/3tcob4ifowxd5jfg?svg=true
[5-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/3

[travis-link]: https://travis-ci.org/riban-bw/Sming-Release
[appveyor-link]: https://ci.appveyor.com/project/riban-bw/sming-release
