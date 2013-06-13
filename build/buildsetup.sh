# make the stuff needed to get it to build
# note the directory is where your cross compilation tools are installed

mkdir -p ~/kobo/tmp
cat > /kobo/KoboLabs/build/build-config-user.sh <<__END__
DEVICEROOT=/usr/arm-none-linux-gnueabi
CROSSTARGET=arm-none-linux-gnueabi
__END__

# then to build
cd ~/kobo/tmp
/kobo/KoboLabs/build/build-all.sh
