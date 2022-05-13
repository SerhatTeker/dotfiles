#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                         _                          _
#                        | |__   __ _ ___  ___   ___| |__
#                        | '_ \ / _` / __|/ _ \ / __| '_ \
#                        | |_) | (_| \__ \  __/_\__ \ | | |
#                        |_.__/ \__,_|___/\___(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
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
    sudo apt update

    sudo apt install -y \
        build-essential \
        fonts-font-awesome \
        fonts-powerline \
        fd-find \
        ripgrep \
        unzip

    # https://github.com/sharkdp/fd#on-debian
    force_remove "$(which fdfind)" "${XDG_BIN_HOME}/fd" # link bin
}

install_snaps() {
    sudo snap install \
        multipass
}


# Security {{{

# TODO: Check if already disabled
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
    info "Started base ${OSTYPE}"

    install_apts
    install_snaps
    disable_core_dumps
    bash "${ROOT}/install/brew.sh"
    bash "${ROOT}/install/linux/i3.sh"

    success "Finished base ${OSTYPE}"
}

# main
install_apts
