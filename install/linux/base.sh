#!/usr/bin/env bash
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
source "${ROOT}/install/common.sh"


install_brew() {
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # check brew installed
    which brew
    # close analytics
    brew analytics off
}

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
        redshift

    i3_gnome
}


main() {
    msg_cli green "Started Installation for ${OSTYPE}"
    install_brew
    i3_setup
    msg_cli green "Finished Installation ${OSTYPE}"
}

main

exit 0
