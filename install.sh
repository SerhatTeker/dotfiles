#!/usr/bin/env bash
#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Main script to install dotfiles and sys-bak


# BASE_URL="git@github.com:SerhatTeker"
BASE_URL="https://github.com/SerhatTeker"
DOTFILES_URL="${BASE_URL}/dotfiles.git"


idotfiles() {
    # install dotfiles repo
    git clone ${DOTFILES_URL} ${HOME}/dotfiles
}

main() {
    idotfiles
    bash "${ROOT}/install/link-dotfiles.sh"
}

main

exit 0
