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
