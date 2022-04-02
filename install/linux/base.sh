#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize zsh
# Warning : WIP
# ----------------------------------------------------------------------------#
#
# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"


install_apts() {
    sudo apt install \
        build-essential
}

# Brew {{{

brew_deps() {
    # deps
    sudo apt install -y \
        build-essential \
        procps \
        curl \
        file \
        git
}

brew_install() {
    # brew_deps

    NONINTERACTIVE=1 \
        bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    which brew          # check brew installed
    brew analytics off  # close analytics
}

brew_bundle() {
    brew bundle --file=${ROOT}/Brewfile
}

brew_main() {
    brew_install
    brew_bundle

}
# }}}

# i3 {{{

i3_gnome() {
    local dir=/tmp/i3-gnome

    git clone https://github.com/i3-gnome/i3-gnome.git ${dir}
    cd ${dir} && \
        sudo make install
}

i3_setup() {
    sudo apt install -y \
        i3 \
        i3blocks \
        fonts-font-awesome \
        lm-sensors \
        j4-dmenu-desktop \
        redshift \
        maim \
        xclip

    i3_gnome
}
# }}}

install_snaps() {
    sudo snap install \
        multipass
}


main() {
    msg_cli green "Started Installation for ${OSTYPE}"

    sudo -v # Get sudo prompt before

    install_apts
    brew_main
    i3_setup
    install_snaps
    msg_cli green "Finished Installation ${OSTYPE}"
}

main
