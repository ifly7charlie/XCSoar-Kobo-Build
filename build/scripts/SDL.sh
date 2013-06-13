#!/bin/bash
set -e -u
ARCHIVE=SDL-1.2.15.tar.gz
ARCHIVEDIR=SDL-1.2.15
. $KOBO_SCRIPT_DIR/build-common.sh

# add the hacky patch
patch -p0 < $PATCHESDIR/SDL-1.2.15-kobo-new.patch

pushd $ARCHIVEDIR
        CFLAGS="-DKOBO" ./configure  --prefix=/${DEVICEROOT} --host=${CROSSTARGET} --disable-video-x11 --disable-cdrom --disable-audio --disable-opengl --disable-json
	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
