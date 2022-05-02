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
    bash "${ROOT}/install/linux/i3.sh"
    bash "${ROOT}/install/linux/brew.sh"

    msg_cli green "Finished Installation ${OSTYPE}"
}

main
