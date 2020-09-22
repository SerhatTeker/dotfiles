#!bin/bash
# oh-my-zsh/themes/agnoster.zsh-theme
# https://github.com/robbyrussell/oh-my-zsh/blob/00ec11d3c0a2b2b7413ad84940ddec299aafbb04/themes/agnoster.zsh-theme#L63

# prompt
DEFAULT_USER=

prompt_context() {
	if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
		prompt_segment 235 10 "%(!.%{%F{yellow}%}.)$USER@%m"
	elif [[ "$USER" == "root" ]]; then
		prompt_segment 235 9 "%(!.%{%F{yellow}%}.)$USER@%m"
	else
		prompt_segment 235 cyan "%(!.%{%F{yellow}%}.)$USER"
        # prompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.)$user@%m "
	fi
}
# prompt dir
prompt_dir() {
    # default
	# prompt_segment blue white '%~'
    # if too long show parent and itself dir
	# prompt_segment blue white '%2~'
    # if too long show parent's parent, parent and itself dir
	prompt_segment blue white '%3~'
}

# To disable background jobs next to vsc
prompt_hg() {
    # blank
}
