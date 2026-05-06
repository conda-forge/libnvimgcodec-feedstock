#!/bin/sh
# Counterpart to activate-libnvimgcodec.sh: only unset the env var if we
# set it ourselves, so a user's pre-existing NVIMGCODEC_EXTENSIONS_PATH
# survives an activate/deactivate cycle.
if [ -n "${_NVIMGCODEC_EXTENSIONS_PATH_SET_BY_CONDA:-}" ]; then
    unset NVIMGCODEC_EXTENSIONS_PATH
    unset _NVIMGCODEC_EXTENSIONS_PATH_SET_BY_CONDA
fi
