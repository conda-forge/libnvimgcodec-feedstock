#!/bin/sh
# nvImageCodec's runtime probes <so_dir>/../extensions, but this recipe
# installs extensions to $PREFIX/lib/extensions, so the runtime never
# finds them. Set NVIMGCODEC_EXTENSIONS_PATH to the install location.
# Skip when the user has already exported a value so we don't clobber
# their custom search path.
if [ -z "${NVIMGCODEC_EXTENSIONS_PATH:-}" ]; then
    export NVIMGCODEC_EXTENSIONS_PATH="${CONDA_PREFIX}/lib/extensions"
    export _NVIMGCODEC_EXTENSIONS_PATH_SET_BY_CONDA=1
fi
