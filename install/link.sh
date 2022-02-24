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


# Link all configs
dot_configs() {
    declare -a arr=(
            "alacritty"
            "bat"
            "git"
            "gh"
            "httpie"
            "lsd"
            "rg"
            "nvim"
            "tmux"
            "zsh"
    )

    for dir in "${arr[@]}"
    do
        force_remove "${DOTFILES}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
    done

    # msg_cli green "Dotfiles configs linked to ${XDG_CONFIG_HOME}"
}

# Link all bins
bins() {
    local source=${HOME}/dotfiles/bin
    local target=${HOME}/.local/bin

    ln -sf ${source}/* ${target}
    # msg_cli green "Bin files linked to ${target}"
}

dot_gnu() {
    [ -f "${SYSBAK}/.gnupg" ] || return 0

    local source="${SYSBAK}/.gnupg"
    local target="${HOME}/.gnupg"

    force_remove "${source}" "${target}"
    # make directory unreadable by others
    chmod -R o-rx "${target}"
    # make symlink available only to current user
    chmod 700 "${target}"
    # msg_cli green ".gnupg linked"
}

# TODO: Check if true
# other stuff
home_others() {
    force_remove "${DOTFILES}/ctags/.ctags" "${HOME}/.ctags"
    force_remove "${DOTFILES}/etc/.sqliterc" "${HOME}/.sqliterc"
    # msg_cli green ".gnupg linked"
}

languages() {
    # node
    force_remove "${DOTFILES}/node/.npmrc" "${HOME}/.npmrc"
    # msg_cli green "Languages linked"
}

containers() {
    force_remove "${DOTFILES}/kube" "${XDG_CONFIG_HOME}/kube"
    # msg_cli green "Containers linked"
}


main() {
    dot_configs
    bins
    dot_gnu
    home_others
    languages
    containers

    msg_cli green "All dotfiles linked"
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
        y*|Y*|"") force=true; main ;;
        n*|N*) msg_cli white "Soft link creation skipped" ;;
        *) msg_cli yellow "Invalid choice. Shell change skipped" ;;
    esac
fi

unset ${force}

exit 0
