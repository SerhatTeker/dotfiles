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

# Install universal-ctags
# https://gist.github.com/nazgob/1570678
# https://docs.ctags.io/en/latest/osx.html#building-with-homebrew
ictags() {
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
}


main() {
    msg_cli green "Started Installation for ${OSTYPE}"
    install_brew
    brew-bundle
    # ictags
    msg_cli green "Finished Installation ${OSTYPE}"
}

main

exit 0
