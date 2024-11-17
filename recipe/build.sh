#!/bin/bash

set -e
set -x

export DESTDIR=$PREFIX

if [[ "$(uname -s)" = "Darwin" ]]; then
    # Tests don't build on osx due to GCC-specific assembly directives in
    # tests/trees.S So, we only do minimal existance and import testing on the
    # osx package
    meson setup ${MESON_ARGS} -D python=enabled -D tests=false build
else
    meson setup ${MESON_ARGS} -D python=enabled build
fi

meson compile -C build
meson test -C build
meson install -C build
