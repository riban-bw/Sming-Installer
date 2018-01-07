#! /bin/bash
#
# This script installs Sming V3.5.1 on Posix systems including GNU/Linux, OS X, Cygwin
#
# Author: Brian Walton (brian@riban.co.uk)
#
# Run this script from the parent directory for the Sming installation, e.g. to installs in a directory called Sming in your home directory:
# cd ~
# install.sh
#

# Check required tools are installed
echo "Checking required tools are installed..."
MISSING=""
for app in mkdir wget rm uname make g++ python
do
  $app --version &>/dev/null || MISSING+="$app "
done
unzip -v &>/dev/null || MISSING+="unzip "
if [ "$MISSING" != "" ]
then
  echo "Please install $MISSING then re-run installer."
  exit 1
fi

# Get a valid temp directory
TEMP=.sming_tmp
mkdir -p $TEMP

# Check wget supports --show-progress
wget -q --show-progress asdf &>/dev/null
if [ $? -eq 2 ]
then
  WGET="wget "
else
  WGET="wget -q --show-progress"
fi

UNZIP="unzip -q"

# Check if Sming folder exists
# TODO: Avoid deleting whole Sming folder in case user keeps other data there
if [ -d Sming ]
then
  echo "Sming folder already exists. Delete and continue or Exit? [d/E]:"
  read RESPONSE
  if [ "$RESPONSE" = "d" ]
  then
    echo "Deleting `pwd`/Sming..."
    rm -r Sming 2> /dev/null
  else
    exit 1
  fi
fi
if [ -d Sming ]
then
  echo "Failed to delete Sming folder. Please manually remove before installing."
  exit 1
fi

# Download the platform specific cross compiler
PLATFORM=`uname -sm`
echo "Downloading Sming packages for $PLATFORM..."
if [ "$PLATFORM" = "Linux armv6l" ]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/c3f718jiqzh1cvo/xtensa-lx106-elf-linux-armv6l.zip
elif [[ "$PLATFORM" == "Linux i686" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/c9elu7pjdp87jr5/xtensa-lx106-elf-linux-i686.zip
elif [[ "$PLATFORM" == "Linux x86_64" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/d2u56kqfbm4twgi/xtensa-lx106-elf-linux-x86_64.zip
elif [[ "$PLATFORM" == "CYGWIN_NT"*"WOW i686" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/1cn969exsnp88ls/xtensa-lx106-elf-cygwin32-i686.zip
elif [[ "$PLATFORM" == "Darwin x86"* ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/8q9g22di7al1tea/xtensa-lx106-elf-osx-x86_64.zip
else
  echo "Unsupported platform $PLATFORM"
  exit 1
fi

# Download the platform agnostic packages
$WGET -O $TEMP/Sming.zip https://www.dropbox.com/s/k8zwqo114bj213d/Sming-3.5.0_20171231.zip
$WGET -O $TEMP/SDK.zip https://www.dropbox.com/s/b8yjilq9a6xagdm/ESP8266_NONOS_SDK_V2.0.0_16_08_10.zip
#$WGET -O $TEMP/SDK.zip https://www.dropbox.com/s/3h9f3x236qb8ds5/ESP8266_NONOS_SDK-2.1.0.zip
$WGET -O $TEMP/esptool.zip https://www.dropbox.com/s/21ceaa8u9254k1f/esptool.zip

# Install the packages
echo "Installing Sming to `pwd`/Sming..."
$UNZIP $TEMP/Sming.zip && echo "Sming installed"
$UNZIP -d Sming/esp-toolkit $TEMP/SDK.zip && echo "SDK installed"
$UNZIP -d Sming/esp-toolkit $TEMP/esptool.zip && echo "esptool installed"
$UNZIP -d Sming/esp-toolkit $TEMP/xtensa-lx106-elf.zip && echo "xtensa-lx106-elf compiler installed"

# TODO: Remove downloaded packages

# Set environmental variables
echo "export ESP_HOME=`pwd`/Sming/esp-toolkit" > Sming/setenv
echo "export SMING_HOME=`pwd`/Sming/Sming" >> Sming/setenv
chmod 755 Sming/setenv

. Sming/setenv

# Build spiffy
echo "Building the SPIFF command line tool, spiffy..."
make -C $SMING_HOME/spiffy clean spiffy &>/dev/null

# Test installation
echo "Testing the installation..."
make -C $SMING_HOME test &>$TEMP/test_results.txt
if [ $? -ne 0 ]
then
  echo "[ERROR] Tests have failed. Please report an issue to https://github.com/riban-bw/Sming-Release/issues with the following information:"
  echo "==========================================="
  echo "UNAME: `uname -a`"
  cat $TEMP/test_results.txt
  echo "==========================================="
  exit 1
fi

#Clean up
rm -r $TEMP

# Final confirmation
echo " "
echo "Sming and support tools now installed."
echo "There are sample projects in $SMING_HOME../samples."
echo "To get started:"
echo "  " `pwd` "/set_env"
echo "   mkdir -p ~/SmingProjects/HelloWorld"
echo "   cd ~/SmingProjects/HelloWorld"
echo "   cp -r $SMING_HOME../samples/Basic_Blink/* ."
echo "   edit HelloWorld/Makefile-user.mk to set serial port, etc."
echo "   edit HelloWorld/app/application.cpp with your source code"
echo "   make"
echo " "
echo "To upload project to the ESP8266"
echo "   Connect ESP8266 module to serial port"
echo "   Ensure COM_PORT is set to a valid serial device in Makefile-user"
echo "   make flash"
