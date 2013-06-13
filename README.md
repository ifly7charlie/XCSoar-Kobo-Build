# About

This repository is a fork of the KoboLabs e-reader that provides a build
environment and a USB Host kernel for running XCSoar on a Kobo Mini.

# Caveats

This has only been tested on a Kobo Mini, but it will probably work on
other new kobo devices

At present you can't boot your device between e-Reader and XCSoar without 
reflashing the kernel.  This will be rectified with an 'auto-reflash' option
in the boot sequence

# Rebuilding 

## Kernel

Unfortunately the Kobo Kernel must be compiled with an older version of GCC (4.4) and XCSoar requires 4.6 or later.  To resolve this you will need to build chains - one for the XCSoar packages and one for the kernel.

### Setup

* I used a new Ubuntu 12.04 Virtual Machine on my laptop

* Install codesourcery GCC toolchain to /usr/arm-none-linux-gnueabi by untaring the downloaded archive into the /usr (ditching the arm2010-blah directory) directory
> http://sources.buildroot.net/arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

> wget http://sources.buildroot.net/arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

> bunzip2 arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

> sudo tar -C /usr -xvf arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar --strip 1 

* Changed the ownership of this directory to me (chown ...)
> sudo chown ${USER}:${USER} /usr/arm-none-linux-gnueabi

* Install the uboot-mkimage tool
> sudo apt-get install uboot-mkimage ncurses-dev

* clone repository if you already haven't
> sudo apt-get install git
> git clone https://github.com/ifly7charlie/XCSoar-Kobo-Build.git

### Building

* Change into the ./hw/imx507/linux-2.6.35.3-USBHOST directory

* Run the make command
>make CROSS_COMPILE=arm-none-linux-gnueabi- ARCH=arm clean uImage

* This will leave you a uImage file in arch/arm/boot/uImage

### Installing

* To install to the boot SD card you have a few options
> dd if=arch/arm/boot/uImage of=/dev/[your memory card] bs=512 seek=2048
or
> copy to /mnt/onboard/.kobo/upgrade/uImage and touch /mnt/onboard/.kobo/KoboRoot.tgz then insert card and reboot kobo
or
> copy to SD card (XCSoar installed), or normal Kobo plugged into laptop in .kobo/upgrade/uImage touch .kobo/KoboRoot.tgz then reboot kobo

note that the memory card is the WHOLE card, not a partition.  So if your card is /dev/sdb use this not the root partition of /dev/sdb1.  The kernel is installed outside of the filesystem at an absolute offset!

## Building XCSoar

This is a two part process - one is seting up the build environment, which can be done using this git repository.  The second is actually building XCSoar, which requires code from the XCSoar repository

### Setup - CodeSourcery

* Use a new VM - it makes the buildchain easier as you can't have the same compilers on both...

* Get a version of the CodeSourcery ARM GNU toolchain which contains 4.6 or later (I built using 4.7)
> http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/request?id=478dff82-62bc-44b2-afe2-4684d83b19b9&downloadlite=scblite2012&fmpath=/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/form

* Install it into the /usr/arm-none-linux-gnueabi directory (will have ./bin etc)

* Change ownership so you don't need to compile as root (as above)

### Setup - G++ - Hardware Float

* Install g++ toolchain, this should go into /usr/arm-linux-gnueabihf directory
> sudo apt-get install  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

* Change ownership so you don't need to compile as root (as above)

### Building

* Change into the <git>/packages directory

* Run ../build/fetchxcsoarpackages.sh to download all the XCSoar specific packages

* Install build tools that are needed
> sudo apt-get install  xsltproc imagemagick g++ librsvg2-bin libboost-dev
These are all needed to run the build process, but don't need to be crosscompiled
If your platform doesn't support pushd or popd then you should install them as well

* change into build directory

* edit buildsetup.sh to put the correct paths in!

* run buildsetup.sh, which will configure this and start a build.  
* to restart you can just run the last commands from the buildsetup.sh script 

*  Output for all the libraries will go into the /usr/arm-none-linux-gnueabi/[lib|include] directories

* Clone the xcsoar repository somewhere

### Compiling XCSoar

* Change into this directory and run make
> make TARGET=KOBO KOBO=/usr/arm-none-linux-gnueabi 

* Output will be in output/KOBO/bin

