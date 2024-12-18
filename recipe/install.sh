#!/bin/bash

set -xe

case "$PKG_NAME" in
dtc)
	meson install --no-rebuild -C build
	;;
libfdt)
	meson install --no-rebuild -C build
	;;
*)
	echo "::ERROR:: unknown PKG_NAME: '$PKG_NAME'" >&2
	exit 1
	;;
esac
