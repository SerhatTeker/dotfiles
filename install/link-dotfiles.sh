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


essantials() {
    # Bash
    ln -s ${DOTFILES}/bash/.bashrc ${HOME}
    ln -s ${DOTFILES}/bash/.bash_logout ${HOME}
    # Ctags
    ln -s ${DOTFILES}/ctags/.ctags ${HOME}
    # Git
    ln -s ${DOTFILES}/.gitconfig ${HOME}
    # Tmux
    ln -s ${DOTFILES}/tmux ${CONFIG}
    # tmux version < 3.1
    # ln -s ${DOTFILES}/tmux/tmux.conf ${HOME}/.tmux.conf
    # Vim
    ln -s ${DOTFILES}/vim/.vim ${HOME}
    ln -s ${DOTFILES}/vim/.nvimrc ${HOME}
}

local-config() {
    ln -s ${DOTFILES}/.config/ansible/ ${HOME}/.config
    ln -s ${DOTFILES}/.config/bat/ ${HOME}/.config
    ln -s ${DOTFILES}/.config/git/ ${HOME}/.config
    ln -s ${DOTFILES}/.config/lsd/ ${HOME}/.config
    ln -s ${DOTFILES}/.config/rg/ ${HOME}/.config
    ln -s ${DOTFILES}/.config/flake8 ${HOME}/.config
}

languages() {
    # node
    ln -s ${DOTFILES}/node/.npmrc ${HOME}/.npmrc
}

containers() {
    ln -s ${DOTFILES}/kube/kind.yaml ${HOME}/.kube
}

others() {
    # sqliterc
    ln -s ${DOTFILES}/etc/.sqliterc ${HOME}
}

main() {
    echo "Making soft links"
    essantials
    local-config
    languages
    containers
    others
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
