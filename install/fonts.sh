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
# Author: Serhat Teker <me@serhatteker.com>
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
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


FONT_DIR="${HOME}/Library/Fonts"
TMP_DIR="/tmp/dotfiles-fonts"


# Copy all fonts to user fonts directory
copy_fonts() {
    find \
        "${TMP_DIR}" \
        \( -name "*.[ot]tf" -or -name "*.pcf.gz" \) \
        -type f -print0 |
        xargs -0 -n1 -I % cp "%" "${FONT_DIR}/"

    msg "Fonts copied to ${FONT_DIR}."
}

# All together
clone_fonts() {
    local dir="/tmp/dotfiles-fonts"

    [ -d ${TMP_DIR} ] && rm -rf ${TMP_DIR}
    git clone "dotfiles-fonts" "https://github.com/SerhatTeker/dotfiles-fonts.git" --depth=1
}

main() {
    mkdir -p "${FONT_DIR}"

    clone_fonts
    copy_fonts

    success "Fonts installed."
}

main
