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

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"

# INFO: Not using since not working inside tmux
# Enable Touch ID for sudo
# Separate pam module needed for tmux
# https://github.com/fabianishere/pam_reattach
touch_id_sudo() {
    sudo tee /etc/pam.d/sudo &>/dev/null <<EOF
# sudo: auth account password session
auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
EOF
}

dark_mode_notify() {
    ln -sf "${DOTFILES}/os/macos/bin/adapt_term_bg_macos" "${XDG_BIN_HOME}"

    swiftc "${DOTFILES}/os/macos/dark-mode-notify.swift" \
        -o /tmp/dark-mode-notify
    sudo cp /tmp/dark-mode-notify /usr/local/bin

    ln -sf "${DOTFILES}/os/macos/com.serhatteker.dark-mode-notify.plist" \
        "${HOME}/Library/LaunchAgents"

    launchctl load -w "${HOME}/Library/LaunchAgents/com.serhatteker.dark-mode-notify.plist"
}

remap_capslock_to_esc() {
    ln -sf "${DOTFILES}/os/macos/com.serhatteker.capslock-esc.plist" \
        "${HOME}/Library/LaunchAgents"

    launchctl load "${HOME}/Library/LaunchAgents/com.serhatteker.capslock-esc.plist"
}

main() {
    info "Started base ${OSTYPE}"

    bash "${ROOT}/macos/defaults.sh"
    bash "${ROOT}/macos/brew.sh"
    dark_mode_notify
    remap_capslock_to_esc

    success "Finished base ${OSTYPE}"
}

main
