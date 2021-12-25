#!/bin/bash

DOTFILES=${HOME}/dotfiles/
ZMAIN="${HOME}/.zsh"
CONFIG=${HOME}/.config


# Essantials {{{

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
# }}}

# .config {{{

ln -s ${DOTFILES}/.config/ansible/ ${HOME}/.config
ln -s ${DOTFILES}/.config/bat/ ${HOME}/.config
ln -s ${DOTFILES}/.config/git/ ${HOME}/.config
ln -s ${DOTFILES}/.config/lsd/ ${HOME}/.config
ln -s ${DOTFILES}/.config/rg/ ${HOME}/.config
ln -s ${DOTFILES}/.config/flake8 ${HOME}/.config
# }}}

# Languages {{{

# node
ln -s ${DOTFILES}/node/.npmrc ${HOME}/.npmrc
# }}}

# Kubernetes {{{

ln -s ${DOTFILES}/kube/kind.yaml ${HOME}/.kube
# }}}

# Others {{{

# sqliterc
ln -s ${HOME}/dotfiles/etc/.sqliterc ${HOME}
# }}}
