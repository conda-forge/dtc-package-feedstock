#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" = "Darwin" ]]; then
    # Tests don't build on osx due to GCC-specific assembly directives in
    # tests/trees.S So, we only do minimal existance and import testing on the
    # osx package
    tests=false
else
    tests=true
fi

meson setup ${MESON_ARGS} -D python=disabled -D tests=$tests build
meson compile -C build

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    meson test -C build
fi
