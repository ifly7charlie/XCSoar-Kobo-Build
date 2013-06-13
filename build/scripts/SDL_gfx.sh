#!/bin/bash
set -e -u
ARCHIVE=SDL_gfx-2.0.23.tar.gz
ARCHIVEDIR=SDL_gfx-2.0.23
. $KOBO_SCRIPT_DIR/build-common.sh

patch -p0 < $PATCHESDIR/SDL-gfx-kobo.patch

pushd $ARCHIVEDIR
        SDL_CFLAGS=`/${DEVICEROOT}/bin/sdl-config --cflags` SDL_LIBS=`/${DEVICEROOT}/bin/sdl-config --libs` PREFIX=/${DEVICEROOT} CHOST=${CROSSTARGET} CROSS_PREFIX=${CROSSTARGET} SDL_CONFIG=/${DEVICEROOT}/bin/sdl-config ./configure  --prefix=/${DEVICEROOT}  --host=${CROSSTARGET} --disable-sdltest --disable-mmx --with-sdl-prefix=/${DEVICEROOT}
	aclocal
	automake
	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
