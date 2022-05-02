#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                       __             _             _
#                      / _| ___  _ __ | |_ ___   ___| |__
#                     | |_ / _ \| '_ \| __/ __| / __| '_ \
#                     |  _| (_) | | | | |_\__ \_\__ \ | | |
#                     |_|  \___/|_| |_|\__|___(_)___/_| |_|
#
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install default missing fonts
# Usage:
# $ bash fonts.sh
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"


sf_mono_powerline() {
    local dir=/tmp/SF-Mono-Powerline

    git clone \
        https://github.com/Twixes/SF-Mono-Powerline.git \
        --depth=1 \
        ${dir}

    # Set source and target directories
    powerline_fonts_dir=${dir}

    if is_macos; then
      local font_dir="${HOME}/Library/Fonts"
    else
      local font_dir="${XDG_DATA_HOME}/fonts"
    fi

    # Create if not exist
    mkdir -p ${font_dir}

    # Copy all fonts to user fonts directory
    echo "Copying fonts..."
    find \
        "${powerline_fonts_dir}" \
        \( -name "*.[ot]tf" -or -name "*.pcf.gz" \) \
        -type f -print0 | \
        xargs -0 -n1 -I % cp "%" "${font_dir}/"

    # Reset font cache on Linux
    if which fc-cache >/dev/null 2>&1 ; then
        echo "Resetting font cache, this may take a moment..."
        fc-cache -f "${font_dir}"
    fi

    echo "SF-Mono-Powerline fonts installed to ${font_dir}"
}

powerline_patched() {
    local dir=/tmp/fonts

    git clone \
        https://github.com/powerline/fonts.git \
        --depth=1 \
        ${dir}

    ${dir}/install.sh
}


main() {
    sf_mono_powerline
    powerline_patched

    msg_cli blue "Fonts installed" normal
}

main
