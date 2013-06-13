#!/bin/sh
# make the stuff needed to get it to build
# note the directory is where your cross compilation tools are installed


directory=`pwd`
directory=${directory%%/build}
mkdir -p ~/kobo/tmp
cat > $directory/build/build-config-user.sh <<__END__
DEVICEROOT=/usr/arm-linux-gnueabihf
CROSSTARGET=arm-linux-gnueabihf
__END__

# then to build
cd ~/kobo/tmp
$directory/build-all.sh
