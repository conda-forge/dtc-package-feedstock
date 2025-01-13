#!/bin/bash

set -e
set -x

echo "!!! CROSSCOMPILING_EMULATOR: ${CROSSCOMPILING_EMULATOR:-}"
echo "!!! meson_cross_file.txt"
cat "$BUILD_PREFIX/meson_cross_file.txt"

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
