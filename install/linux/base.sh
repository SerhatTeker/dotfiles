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

install_snaps() {
    sudo snap install \
        multipass
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

i3_wakelock() {
    sudo cp \
        "${DOTFILES}/etc/systemd/wakelock@.service" \
        "/etc/systemd/system"

    sudo systemctl enable wakelock@${USER} \
        && sudo systemctl daemon-reload
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
        xclip \
        rofi

    i3_gnome
    i3_wakelock
}
# }}}

# Security {{{

# https://www.cyberciti.biz/faq/disable-core-dumps-in-linux-with-systemd-sysctl
disable_core_dumps() {
    local file=/etc/security/limits.conf
    printf \
        "* hard core 0\n* soft core 0" \
        | sudo tee -a /etc/security/limits.conf

    # Make sure the Linux prevents setuid and setgid programs from dumping core to
    printf \
        "fs.suid_dumpable=0\nkernel.core_pattern=|/bin/false" \
        | sudo tee -a /etc/sysctl.conf
    # Activate changes
    sudo sysctl -p /etc/sysctl.conf
}
# }}}


main() {
    msg_cli green "Started Installation for ${OSTYPE}"

    sudo -v # Get sudo prompt before

    install_apts
    install_snaps
    disable_core_dumps
    i3_setup
    brew_main
    msg_cli green "Finished Installation ${OSTYPE}"
}

main
