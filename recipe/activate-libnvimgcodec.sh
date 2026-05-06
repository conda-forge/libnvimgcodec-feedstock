#!/bin/sh
# nvImageCodec's runtime probes <so_dir>/../extensions, but this recipe
# installs extensions to $PREFIX/lib/extensions, so the runtime never
# finds them. Set NVIMGCODEC_EXTENSIONS_PATH to the install location.
# Skip when the variable is already set — including to an empty string —
# so an explicit user override (even "disable all extensions") wins.
if [ -z "${NVIMGCODEC_EXTENSIONS_PATH+set}" ]; then
    export NVIMGCODEC_EXTENSIONS_PATH="${CONDA_PREFIX}/lib/extensions"
    export _NVIMGCODEC_EXTENSIONS_PATH_SET_BY_CONDA=1
fi
