#!/bin/bash

#
# Build U-Boot image when `mkimage' tool is available.
#

MKIMAGE=$(type -path "${CROSS_COMPILE}mkimage")

if [ -z "${MKIMAGE}" ]; then
	MKIMAGE=$(type -path mkimage)
	if [ -z "${MKIMAGE}" ]; then
		# Doesn't exist
		echo '"mkimage" command not found - U-Boot images will not be built' >&2
		exit 0;
	fi
fi


KREV="XCSoar"

UTS_VER="$(cat include/generated/compile.h |grep "UTS_VERSION"|awk -F\" '{print $2}'|awk '{print $1,$4,$5,$6}')"
if [ -z "${UTS_VER}" ];then
	UTS_VER="?"
fi

# Call "mkimage" to create U-Boot image
${MKIMAGE} -n "${KREV}_${UTS_VER}" "$@"

