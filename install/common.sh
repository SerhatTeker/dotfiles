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


# Create default HOME directories if not exists
__create_home_dirs() {
    for dir in ".config" "dotfiles" "system-bak" "Private"
    do
        mkdir -p ${HOME}/${dir}
    done
}

__create_home_dirs

export DOTFILES=${HOME}/dotfiles
export SYSBAK=${HOME}/system-bak
export XDG_CONFIG_HOME=${HOME}/.config
export CONFIG=${HOME}/.config   # Alias for XDG_CONFIG_HOME
export PRIVATE=${HOME}/Private
