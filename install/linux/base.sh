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
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

livepatch() {
    # Check whether UBUNTU_TOKEN on the environment
    local token="${UBUNTU_TOKEN}"
    # If token no on the environment, try to get from user input
    if [[ -z "${token}" ]]; then
        read -rsp "Enter your Ubuntu Advantage Token: " token
        echo
        # if no token provided exit enabling livepatch
        [[ -z "${token}" ]] && return
    fi

    sudo ua attach "${token}"
    sudo ua enable livepatch
    # Ensure that the Livepatch service is working properly
    canonical-livepatch status --verbose
}

# Applications {{{

install_apts() {
    sudo apt install -y \
        age \
        build-essential \
        bat \
        curl \
        fontconfig \
        fonts-font-awesome \
        fonts-powerline \
        fd-find \
        git \
        gnome-tweaks \
        htop \
        imagemagick \
        jq \
        libfuse2 \
        redshift \
        redshift-gtk \
        ripgrep \
        shellcheck \
        shfmt \
        tmux \
        universal-ctags \
        unzip \
        xrandr

    # Link the binary: since # The binary is called `fdfind` as the binary name `fd`
    # is already used by another package. https://github.com/sharkdp/fd#on-debian
    force_remove "$(which fdfind)" "${XDG_BIN_HOME}/fd"

    # https://github.com/sharkdp/bat#on-ubuntu-using-apt
    force_remove "/usr/bin/batcat" "${XDG_BIN_HOME}/bat"
}

install_snaps() {
    # sudo snap install multipass # TODO: full.sh
    sudo snap remove firefox # Snap Firefox suks
}
# }}}

# Security {{{

# TODO: Check if already disabled
# https://www.cyberciti.biz/faq/disable-core-dumps-in-linux-with-systemd-sysctl
disable_core_dumps() {
    printf \
        "* hard core 0\n* soft core 0" |
        sudo tee -a /etc/security/limits.conf

    # Make sure the Linux prevents setuid and setgid programs from dumping core to
    printf \
        "fs.suid_dumpable=0\nkernel.core_pattern=|/bin/false" |
        sudo tee -a /etc/sysctl.conf
    # Activate changes
    sudo sysctl -p /etc/sysctl.conf
}
# }}}

# System programs modification {{{

fix_k2_f_keys() {
    echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
    sudo update-initramfs -u -k all
    warn "Reboot needed: reboot the system when convenient"
}

disable_bell_sound() {
    sudo sed -i '/set bell-style none/s/^#*\s*//g' /etc/inputrc
}
# }}}

main() {
    info "Started base ${OSTYPE}"
    sudo apt update

    livepatch
    install_apts
    install_snaps
    disable_core_dumps
    bash "${ROOT}/install/linux/i3.sh"
    fix_k2_f_keys
    disable_bell_sound

    success "Finished base ${OSTYPE}"
}

main
