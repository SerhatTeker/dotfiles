# DEFAULT SETTINGS {{{1

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/serhat/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/serhat/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/serhat/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/serhat/.fzf/shell/key-bindings.zsh"
# }}}1

# CUSTOM SETTINGS {{{1

# fzf + ag configuration
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore-dir={__pycache__,undo,} -g ""'
# ripgrep alternative
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview {{{2

# WARNING
# https://github.com/sharkdp/bat/issues/357#issuecomment-429649196
## bat doesn't work with any input other than the list of files
### ps -ef | fzf
### seq 100 | fzf
### history | fzf
# https://github.com/sharkdp/bat/issues/357#issuecomment-429649196
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

# alternative
# https://github.com/sharkdp/bat/issues/357#issuecomment-555971886
# export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
# export FZF_CTRL_T_OPTS="--min-height 30 --preview-window down:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
# }}}2
# }}}1
#
# Git with fzf {{{1
#
# Key bindings for git with fzf
# https://junegunn.kr/2016/07/fzf-git
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# functions {{{2

# GIT heart FZF
# -------------

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
    fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_gf() {
    is_in_git_repo || return
    git -c color.status=always status --short |
    fzf-down -m --ansi --nth 2..,.. \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
    cut -c4- | sed 's/.* -> //'
}

_gb() {
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}

_gt() {
    is_in_git_repo || return
    git tag --sort -version:refname |
    fzf-down --multi --preview-window right:70% \
        --preview 'git show --color=always {}'
}

_gh() {
    is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
    fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
    grep -o "[a-f0-9]\{7,\}"
}

_gr() {
    is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq |
    fzf-down --tac \
        --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
    cut -d$'\t' -f1
}

_gs() {
    is_in_git_repo || return
    git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
    cut -d: -f1
}
# }}}2
#
# key bindings {{{2

join-lines() {
    local item
    while read item; do
        echo -n "${(q)item} "
    done
}

bind-git-helper() {
    local c
    for c in $@; do
        eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g^$c' fzf-g$c-widget"
    done
}
bind-git-helper f b t r h s
unset -f bind-git-helper
# }}}2
# }}}1
