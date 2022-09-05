#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install and setup i3 window manager
# Usage:
# $ bash i3.sh

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"

# Use i3wm/i3-gaps with GNOME Session infrastructure.
i3_gnome() {
    local dir=/tmp/i3-gnome

    git clone https://github.com/i3-gnome/i3-gnome.git ${dir}
    cd ${dir} &&
        sudo make install
}

i3_wakelock() {
    sudo cp \
        "${DOTFILES}/etc/systemd/wakelock@.service" \
        "/etc/systemd/system"

    sudo systemctl enable "wakelock@${USER}" &&
        sudo systemctl daemon-reload
}

i3_deps() {
    sudo apt install -y \
        i3 \
        i3blocks \
        fonts-font-awesome \
        lm-sensors \
        j4-dmenu-desktop \
        redshift \
        maim \
        playerctl \
        rofi \
        udiskie \
        xclip
}

i3_main() {
    i3_deps
    i3_gnome
    i3_wakelock
}

i3_main
