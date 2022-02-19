#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Make soft links for bin to ~/.local/bin
# Make soft links for dotfiles configs to ~/.config

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


force_remove() {
    local _source=$1
    local _target=$2

    echo ${_target}

    if [ -f "${_target}" ] && [ ! -L "${_target}" ];then
        echo "Soft link NOT exist"
        if ${force}; then
            rm -rf ${_target}
        else
            msg_cli red "${_target} is not a symlink. Delete it manually, or force it with -f|--force"
            echo "Force not set to <true>"
            return
        fi
    else
        echo "Soft link DOES exist"
    fi

    ln -sf "${_source}" "${_target}"
}


# Link all bins
bins() {
    local source=${HOME}/dotfiles/bin
    local target=${HOME}/.local/bin

    ln -sf ${source}/* ${target}
    msg_cli green "Bin files linked to ${target}"
}

# Link all configs
dot_configs() {
        declare -a arr=(
                "alacritty"
                "bat"
                "git"
                "httpie"
                "lsd"
                "rg"
                "nvim"
                "tmux"
                "zsh"
        )

        for dir in "${arr[@]}"
        do
        force_remove "${DOTFILES}/${dir}" "${XDG_CONFIG_HOME}${dir}"
        done

    msg_cli green "Dotfiles configs linked to ${XDG_CONFIG_HOME}"
}

dot_gnu() {
    source="${SYSBAK}/.gnupg"
    target="${HOME}/.gnupg"

    force_remove "${source}" "${target}"
    # make directory unreadable by others
    chmod -R o-rx "${target}"
    # make symlink available only to current user
    chmod 700 "${target}"
}

# TODO: Check if true
# other stuff
home_other() {
    for files in \
        ctags/.ctags \
        etc/.sqliterc; do

        force_remove "${DOTFILES}/${files}" "${HOME}/${files}"
    done
}

languages() {
    # node
    force_remove "${DOTFILES}/node/.npmrc" "${HOME}/.npmrc"
}

containers() {
    mkdir -p "${XDG_CONFIG_HOME}/kube"
    force_remove "${DOTFILES}/kube/kind.yaml" "${XDG_CONFIG_HOME}/kube/kind.yaml"
}


main() {
    # bins
    dot_configs
    # dot_gnu
    # languages
    # containers
    # home_other

    msg_cli green "All Dotfiles linked"
}


force=${1:-false}
if [ "$force" == "--force" -o "$force" == "-f" ]; then
    force=true
fi


if ${force}; then
    main
else
    # Prompt for user choice on changing the default login shell
    printf '%sThis may overwrite existing files in your home directory. Are you sure? (y/n)%s ' \
        "$FMT_YELLOW" "$FMT_RESET"
    read -r opt
    case $opt in
        y*|Y*|"") main ;;
        n*|N*) msg_cli white "Soft link creation skipped" ;;
        *) msg_cli yellow "Invalid choice. Shell change skipped" ;;
    esac
fi

unset ${force}

exit 0
