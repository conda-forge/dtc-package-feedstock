#!/bin/bash

set -e
set -x

if [[ "$(uname -s)" = "Darwin" ]]; then
    # Tests don't build on osx due to GCC-specific assembly directives in
    # tests/trees.S So, we only do minimal existance and import testing on the
    # osx package
    tests=false
elif [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    tests=true
else
    tests=false
fi

meson setup ${MESON_ARGS} -D python=disabled -D tests=$tests build
meson compile -C build
meson test -C build
