#! /bin/bash
#
# This script installs Sming V3.5.1 on Posix systems including GNU/Linux, OS X, Cygwin
#
# Run this script from the parent directory for the Sming installation, e.g. to installs in a directory called Sming in your home directory:
# cd ~
# install.sh
# 

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
    return 1
  fi
fi
if [ -d Sming ]
then
  echo "Failed to delete Sming folder. Please manually remove before installing."
  return 1
fi

# Download the platform specific cross compiler
PLATFORM=`uname -sm`
echo "Downloading Sming packages for $PLATFORM..."
if [ "$PLATFORM" = "Linux armv6l" ]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/9kow2xv0xeaox5e/xtensa-lx106-elf-linux-arm6l.zip
elif [[ "$PLATFORM" == "Linux i686" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/c9elu7pjdp87jr5/xtensa-lx106-elf-linux-i686.zip?dl=0
elif [[ "$PLATFORM" == "Linux x86_64" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/d2u56kqfbm4twgi/xtensa-lx106-elf-linux-x86_64.zip?dl=0
elif [[ "$PLATFORM" == "CYGWIN_NT"*"WOW i686" ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/ekz4tyj280y90sm/xtensa-lx106-elf-cygwin-i686.zip
elif [[ "$PLATFORM" == "Darwin x86"* ]]
then
  $WGET -O $TEMP/xtensa-lx106-elf.zip https://www.dropbox.com/s/8q9g22di7al1tea/xtensa-lx106-elf-osx-x86_64.zip?dl=0
else
  echo "Unsupported platform $PLATFORM"
  return 1
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
rm -r $TEMP

# Set environmental variables
export ESP_HOME=`pwd`/Sming/esp-toolkit
export SMING_HOME=`pwd`/Sming/Sming

