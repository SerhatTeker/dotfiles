#!/usr/bin/env bash

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


DOTFILES=${HOME}/dotfiles/
ZMAIN="${HOME}/.zsh"
CONFIG=${HOME}/.config


essantials() {
    # Bash
    ln -s ${HOME}/dotfiles/bash/.bashrc ${HOME}
    ln -s ${HOME}/dotfiles/bash/.bash_logout ${HOME}
    # Ctags
    ln -s ${HOME}/dotfiles/ctags/.ctags ${HOME}
    # Git
    ln -s ${DOTFILES}/.gitconfig ${HOME}
    # Tmux
    ln -s ${DOTFILES}/tmux ${CONFIG}
    # tmux version < 3.1
    # ln -s ${DOTFILES}/tmux/tmux.conf ${HOME}/.tmux.conf
    # Vim
    ln -s ${HOME}/dotfiles/vim/.vim ${HOME}
    ln -s ${HOME}/dotfiles/vim/.nvimrc ${HOME}
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
    ln -s ${HOME}/dotfiles/etc/.sqliterc ${HOME}
}

main() {
    echo "Making soft links"
    essantials
    local-config
    languages
    containers
    others
}

exit 0
