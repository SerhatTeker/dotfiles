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
