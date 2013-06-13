
#!/bin/bash
set -e -u

#wget ftp://ftp.gnu.org/gnu/termcap/termcap-1.3.1.tar.gz

ARCHIVE=termcap-1.3.1.tar.gz
ARCHIVEDIR=termcap-1.3.1
. $KOBO_SCRIPT_DIR/build-common.sh

pushd $ARCHIVEDIR
        CC=${CROSSTARGET}-gcc ./configure  --prefix=/${DEVICEROOT}  --host=${CROSSTARGET} 
	$MAKE -j$MAKE_JOBS
	$MAKE DESTDIR=/${DEVICEROOT} install
popd
markbuilt

