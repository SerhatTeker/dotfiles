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

ibrew() {
    # Install Homebrew to $HOME/.homebrew instead of /usr/local:
    git clone https://github.com/Homebrew/brew.git ${HOME}/.homebrew
    # check brew installed
    which brew
    # close analytics
    brew analytics off
}

brew-bundle() {
    # TODO: create Brewfile
    brew bundle --file=${ROOT}/Brewfile
}


main() {
    echo "Started Installation"
    ibrew
    echo "Finished Installation"
}

main

exit 0
