#!/usr/bin/env bash

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


ZMAIN="${HOME}/.zsh"


home() {
    for files in \
        bash/.bashrc \
        bash/.bash_logout \
        ctags/.ctags \
        git/.gitconfig \
        .config/vim/.nvimrc \
        etc/.sqliterc; do

        ln -sf "${DOTFILES}/${files}" ${HOME}/.config
    done
}

local-config() {
    for files in \
        ansible/ \
        bat/ \
        git/ \
        lsd/ \
        nvim/ \
        rg/ \
        flake8; do

        ln -sf "${DOTFILES}/.config/${files}" ${HOME}/.config
    done
}

languages() {
    # node
    ln -s ${DOTFILES}/node/.npmrc ${HOME}/.npmrc
}

containers() {
    mkdir -p ${HOME}/.kube
    ln -s ${DOTFILES}/kube/kind.yaml ${HOME}/.kube
}

gnu() {
    # TODO: Decide install whether from dotfiles or sysbak
    # Seems broken, use similiar one in install/zsh.sh
    # gnupg
    if [ -f "${HOME}/.gnupg" ] && [ ! -L "${HOME}/.gnupg" ];then
        echo "${HOME}/.gnupg is not a symlink. Delete it manually."
        exit 1
    else
        [ -L "${HOME}/.gnupg" ] && unlink "${HOME}/.gnupg"
        ln -sf "${SYSBAK}/.gnupg" "${HOME}/.gnupg"
        # make directory unreadable by others
        chmod -R o-rx "${SCRIPT_DIR}/.gnupg"
        # make symlink available only to current user
        chmod 700 "${HOME}/.gnupg"
    fi
}


main() {
    echo "Making soft links"
    home
    local-config
    languages
    containers
    gnu
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	main
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		main
	fi
fi
unset main

exit 0
