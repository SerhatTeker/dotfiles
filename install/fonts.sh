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
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

# Reset font cache on Linux
reset_fc_cache() {
    if which fc-cache >/dev/null 2>&1; then
        info "Resetting font cache, this may take a moment..."
        fc-cache -f "${font_dir}"
    fi
}

# Copy all fonts to user fonts directory
copy_fonts() {
    find \
        "${dir}" \
        \( -name "*.[ot]tf" -or -name "*.pcf.gz" \) \
        -type f -print0 |
        xargs -0 -n1 -I % cp "%" "${font_dir}/"
    info "${name} fonts installed to ${font_dir}"
}

install_font() {
    local name="${1}"
    local repo="${2}"
    local dir="/tmp/${1}"

    [ -d ${dir} ] && rm -rf ${dir}
    git clone ${repo} ${dir} --depth=1
    copy_fonts
}

# Separate {{{

powerline_patched() {
    # for Debian or Ubuntu there should be a package available to install
    # $ sudo apt-get install fonts-powerline
    local dir=/tmp/power-line-fonts

    [ -d ${dir} ] && rm -rf ${dir}
    git clone https://github.com/powerline/fonts.git ${dir} --depth=1
    ${dir}/install.sh
}

# Separately
# INFO: Deprecated: Install fonts separetaley
main_separate() {
    install_font "SF-Mono-Nerd-Font" "https://github.com/epk/SF-Mono-Nerd-Font.git"
    install_font "SF-Mono-Powerline" "https://github.com/Twixes/SF-Mono-Powerline.git"
    powerline_patched
}
# }}}

# All together
dotfiles_fonts() {
    install_font "dotfiles-fonts" "https://github.com/SerhatTeker/dotfiles-fonts.git"
}

main() {
    # Use user directory
    if is_macos; then
        local font_dir="${HOME}/Library/Fonts"
    else
        local font_dir="${XDG_DATA_HOME}/fonts"
    fi
    mkdir -p "${font_dir}"

    dotfiles_fonts

    reset_fc_cache
    success "Fonts installed"
}

main
