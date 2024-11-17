#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" != "Darwin" ]]; then
    # make check doesn't build on osx due to GCC-specific assembly directives
    # in tests/trees.S So, we only do minimal existance and import testing on
    # the osx package
    meson setup -D python=enabled -D tests=false build
else
    meson setup -D python=enabled build
fi

meson compile -C build
meson test -C build
meson install -C build
