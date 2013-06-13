#!/bin/bash
set -e -u
ARCHIVE=libpng-1.2.43.tar.gz
ARCHIVEDIR=libpng-1.2.43
. $KOBO_SCRIPT_DIR/build-common.sh

pushd $ARCHIVEDIR
	CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" ./configure --prefix=${DEVICEROOT} --host=${CROSSTARGET}
	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
