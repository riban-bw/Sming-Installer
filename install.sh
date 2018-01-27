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

# Debug output
# param Debug level (1=Normal 2=Debug)
# param Text to print
Debug()
{
	if [ $SILENT -eq 1 ]
	then
		return
	elif [ $VERBOSE -eq 0 -a  "$1" = "2" ]
	then
		return
	fi
	echo "$2"
}

# Check if a module is already installed
# Offer user choice to backup, delete, exit or skip instalation step
# param Module name
# param Module relative installation path
CheckModule()
{
	module=$1
	path=$2
	RESPONSE=$FORCE
	if [ ${!1} -eq 1 ]
	then
		if [ -e $path ]
		then
			if [ "$FORCE" = "A" ]
			then
				echo "$1 appears to be installed at ./$path. Backup, Delete, Exit or Skip? [b/d/e/S]"
				read RESPONSE
			fi
			if [ "$RESPONSE" = "b" ]
			then
			  Debug 1 "Backing up $path to $path.bu"
			  mv -f $path $path.bu
			elif [ "$RESPONSE" = "d" ]
			then
			  rm -r $path
			elif [ "$RESPONSE" = "e" ]
			then
			  exit 0
			else
			  eval "$1=0"
			fi
		fi
	fi
}

# Initalise variables
FORCE=A
SMING=0
SDK=0
ESPTOOL=0
XTENSA=0
SPIFFY=0
ALL=1
VERBOSE=0
SILENT=0

# Parse command line
while getopts ":hVSdbsi:" opt; do
  case ${opt} in
    [h,\?]) # Help, Invalid option
	  echo "Usage: $0 [options]"
	  echo 
	  echo "  Options:"
	  echo "    -h             Show this help"
	  echo "    -V             Verbose output"
	  echo "    -S             Silent - no output"
	  echo "    -d             Delete any modules already installed - no questions"
	  echo "    -b             Backup any modules already installed - no questions"
	  echo "    -s             Skip any modules already installed - no questions"
	  echo "    -i <module>    Install <module>"
	  echo "      Modules:"
	  echo "        sming      SMING framework"
	  echo "        sdk        ESP8266 SDK"
	  echo "        esptool    esptool.py"
	  echo "        xtensa     XTENSA c/c++ compiler"
	  echo "        spiffy     SPIFFS file system tool"
	  echo "        all        Install all modules (default)"
	  echo "      Multiple -i options may be provided. Default is to install all modules."
	  echo "      If -i is provided then only the specified modules will be installed."
      exit 0
      ;;
    V ) # Verbose
	  VERBOSE=1
      ;;
    S ) # Silent
	  SILENT=1
      ;;
    d ) # Delete existing installed modules
	  FORCE=d
      ;;
	b ) # Backup existing installed modules
	  FORCE=b
	  ;;
	s ) # Skip existing installed modules
	  FORCE=s
	  ;;
	i ) # Install module
		case ${OPTARG} in
		  sming )
		    SMING=1
			ALL=0
		    ;;
		  skd )
		    SDK=1
			ALL=0
            ;;
          esptool )
		    ESPTOOL=1
			ALL=0
            ;;
          xtensa )
		    XTENSA=1
			ALL=0
		    ;;
          spiffy )
		    SPIFFY=1
			ALL=0
		    ;;
          all )
		    ALL=1
		    ;;
		  * ) # Wrong argument provided
		    echo "Incorrect argument for -i. $0 -h for help"
			exit 1
			;;
		esac
	  ;;
	: )
	  echo "Invalid option: $OPTARG requires an argument. $0 -h for help"
	  exit 1
	  ;;
  esac
done

##START OF MAIN CODE##
if [ $ALL -eq 1 ]
then
  SMING=1
  SDK=1
  ESPTOOL=1
  XTENSA=1
  SPIFFY=1
fi

if [ $SMING -eq 1 ]; then CheckModule SMING Sming/Sming;fi
if [ $SDK -eq 1 ]; then CheckModule SDK Sming/esp-toolkit/sdk;fi
if [ $ESPTOOL -eq 1 ]; then CheckModule ESPTOOL Sming/esp-toolkit/esptool;fi
if [ $XTENSA -eq 1 ]; then CheckModule XTENSA Sming/esp-toolkit/xtensa-lx106-elf;fi
if [ $SPIFFY -eq 1 ]; then CheckModule SPIFFY Sming/Sming/spiffy/spiffy;fi

Debug 2 "SMING:   $SMING"
Debug 2 "SDK:     $SDK"
Debug 2 "ESPTOOL: $ESPTOOL"
Debug 2 "XTENSA:  $XTENSA"
Debug 2 "SPIFFY:  $SPIFFY"

INSTALL=$(($SMING + $SDK + $ESPTOOL + $XTENSA + $SPIFFY))
if [ $INSTALL -eq 0 ]
then
  Debug 1 "Nothing selected to install"
  exit 0
fi

# Check required tools are installed
Debug 1 "Checking required tools are installed..."
MISSING=""
for app in mkdir wget rm uname make g++ python
do
  $app --version &>/dev/null || MISSING+="$app "
done
unzip -v &>/dev/null || MISSING+="unzip "
if [ "$MISSING" != "" ]
then
  Debug 1 "Please install $MISSING then re-run installer."
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

UNZIP="unzip -oq"

# Download the platform specific cross compiler
PLATFORM=`uname -sm`
if [ $XTENSA -eq 1 ]
then
	Debug 1 "Downloading Sming packages for $PLATFORM..."
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
	  Debug 1 "Unsupported platform $PLATFORM"
	  exit 1
	fi
fi

# Download the platform agnostic packages
if [ $SMING -eq 1 ]
then
	$WGET -O $TEMP/Sming.zip https://www.dropbox.com/s/k8zwqo114bj213d/Sming-3.5.0_20171231.zip
fi
if [ $SDK -eq 1 ]
then
  $WGET -O $TEMP/SDK.zip https://www.dropbox.com/s/b8yjilq9a6xagdm/ESP8266_NONOS_SDK_V2.0.0_16_08_10.zip
  #$WGET -O $TEMP/SDK.zip https://www.dropbox.com/s/3h9f3x236qb8ds5/ESP8266_NONOS_SDK-2.1.0.zip
fi
if [ $ESPTOOL -eq 1 ]
then
  $WGET -O $TEMP/esptool.zip https://www.dropbox.com/s/21ceaa8u9254k1f/esptool.zip
fi

# Install the packages
Debug 1 "Installing Sming to `pwd`/Sming..."
if [ $SMING -eq 1 ]
then
  $UNZIP $TEMP/Sming.zip && Debug 1 "Sming installed"
fi
if [ $SDK -eq 1 ]
then
  $UNZIP -d Sming/esp-toolkit $TEMP/SDK.zip && Debug 1 "SDK installed"
fi
if [ $ESPTOOL -eq 1 ]
then
  $UNZIP -d Sming/esp-toolkit $TEMP/esptool.zip && Debug 1 "esptool installed"
fi
if [ $ESPTOOL -eq 1 ]
then
  $UNZIP -d Sming/esp-toolkit $TEMP/xtensa-lx106-elf.zip && Debug 1 "xtensa-lx106-elf compiler installed"
fi

# TODO: Remove downloaded packages

# Set environmental variables
echo "export ESP_HOME=`pwd`/Sming/esp-toolkit" > Sming/setenv
echo "export SMING_HOME=`pwd`/Sming/Sming" >> Sming/setenv
chmod 755 Sming/setenv

. Sming/setenv

if [ $SPIFFY -eq 1 ]
then
  # Build spiffy
  Debug 1 "Building the SPIFF command line tool, spiffy..."
  make -C $SMING_HOME/spiffy clean spiffy &>/dev/null
fi

# Test installation
Debug 1 "Testing the installation..."
make -C $SMING_HOME test &>$TEMP/test_results.txt
if [ $? -ne 0 ]
then
  Debug 1 "[ERROR] Tests have failed. Please report an issue to https://github.com/riban-bw/Sming-Release/issues with the following information:"
  Debug 1 "==========================================="
  Debug 1 "UNAME: `uname -a`"
  cat $TEMP/test_results.txt
  Debug 1 "==========================================="
  exit 1
fi

#Clean up
rm -r $TEMP

# Final confirmation
Debug 1 " "
Debug 1 "Sming and support tools now installed."
Debug 1 "There are sample projects in $SMING_HOME../samples."
Debug 1 "To get started:"
Debug 1 "  " `pwd` "/set_env"
Debug 1 "   mkdir -p ~/SmingProjects/HelloWorld"
Debug 1 "   cd ~/SmingProjects/HelloWorld"
Debug 1 "   cp -r $SMING_HOME../samples/Basic_Blink/* ."
Debug 1 "   edit HelloWorld/Makefile-user.mk to set serial port, etc."
Debug 1 "   edit HelloWorld/app/application.cpp with your source code"
Debug 1 "   make"
Debug 1 " "
Debug 1 "To upload project to the ESP8266"
Debug 1 "   Connect ESP8266 module to serial port"
Debug 1 "   Ensure COM_PORT is set to a valid serial device in Makefile-user"
Debug 1 "   make flash"
