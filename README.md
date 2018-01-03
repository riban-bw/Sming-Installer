# Sming-Release
This is a simple installer for [Sming](https://github.com/SmingHub/Sming), a C++ framework for the ESP8266 microcontroller.

This installer provides all the tools required to program the ESP8266 using the Sming framework. The aim is to reduce the friction in starting to use Sming. For Sming support visit Sming at github where there are various guides and supporting documentation.

To install Sming to your home directory (change '~' to your preferred install location), open a POSIX shell, e.g. bash, cygwin32, etc.

```
cd ~
wget https://tinyurl.com/SmingInstall
. SmingInstall
rm SmingInstall
```

# Current version of Sming: [3.5.0](https://github.com/SmingHub/Sming/releases/tag/3.5.0)

##Status

| Platform                | Status                       |
|-------------------------|------------------------------|
| Linux i686              | PASS |
| Linux x86_64            | [![Build2][2-badge]][2-link] |
| Linux armv6l            | PASS |
| Windows Cygwin32        | [![Build4][4-badge]][4-link] |
| OS X x86_64             | [![Build5][5-badge]][5-link] |

[2-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/1
[4-badge]: https://ci.appveyor.com/api/projects/status/3tcob4ifowxd5jfg?svg=true
[5-badge]: https://travis-matrix-badges.herokuapp.com/repos/riban-bw/Sming-Release/branches/master/2

[2-link]: https://travis-ci.org/riban-bw/Sming-Release
[4-link]: https://ci.appveyor.com/project/riban-bw/sming-release
[5-link]: https://travis-ci.org/riban-bw/Sming-Release
