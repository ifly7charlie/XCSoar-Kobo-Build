#!/bin/bash
set -e -u
ARCHIVE=freetype-2.4.4.tar.gz
ARCHIVEDIR=freetype-2.4.4
. $KOBO_SCRIPT_DIR/build-common.sh


pushd $ARCHIVEDIR

        ./configure  --prefix=/${DEVICEROOT} --host=${CROSSTARGET} --without-zlib

	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
