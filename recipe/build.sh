#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" = "Darwin" ]]; then
    # Tests don't build on osx due to GCC-specific assembly directives in
    # tests/trees.S So, we only do minimal existance and import testing on the
    # osx package
    meson setup ${MESON_ARGS} -D python=disabled -D tests=false build
else
    # Temporarily disable tests until build errors in newer GCC can be fixed
    # meson setup ${MESON_ARGS} -D python=enabled build
    meson setup ${MESON_ARGS} -D python=disabled -D tests=true build
fi

meson compile -C build
meson test -C build
