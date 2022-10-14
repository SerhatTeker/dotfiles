#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

set -o errexit
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

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
        htop \
        imagemagick \
        jq \
        libfuse2 \
        ripgrep \
        shellcheck \
        shfmt \
        universal-ctags \
        unzip

    # Link the binary: since # The binary is called `fdfind` as the binary name `fd`
    # is already used by another package. https://github.com/sharkdp/fd#on-debian
    force_remove "$(which fdfind)" "${XDG_BIN_HOME}/fd"

    # https://github.com/sharkdp/bat#on-ubuntu-using-apt
    force_remove "/usr/bin/batcat" "${XDG_BIN_HOME}/bat"
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

base_install() {
    info "Started base ${OSTYPE}"

    if [[ ! "$(uname -m)" == "aarch64" ]]; then
        error "Arch is not aarch64"
        exit 1
    fi

    sudo apt update

    install_apts
    disable_core_dumps
    fix_k2_f_keys
    disable_bell_sound

    success "Finished base ${OSTYPE}"
}

main() {
    base_install

    declare -a installs=(
        "zsh.sh"
        "link.sh"
        "languages/node.sh"
        "languages/rust.sh"
        "languages/python.sh"
        "nvim.sh"
        "lvim.sh"
        "fonts.sh"
    )

    for install in "${installs[@]}"; do
        bash "${ROOT}/install/${install}"
    done
}

main
