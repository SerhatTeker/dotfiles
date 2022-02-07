# -*- coding: utf-8 -*-
# vim: set ft=zsh et ts=4 sw=4 sts=4:

# Default - OLD
# PROMPT='%{$fg[cyan]%}%~%  %{$fg_bold[blue]%}$(git_prompt_info) %(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '

if [[ "$USER" == "root" ]]; then
        PROMPT="%F{red}%n%f"                                # user name
        PROMPT+="%F{red}@"
        PROMPT+="%F{red}${${(%):-%m}#zoltan-}%f"            # host name, minus zoltan
        PROMPT+=":"
        PROMPT+='%{$fg[red]%}%~%'                           # directory
        PROMPT+="  "
        PROMPT+='%(?.%{$fg[magenta]%}.%{$fg[red]%})%B$%b'   # $
        PROMPT+=" "
else
    if [[ -n $SSH_CONNECTION ]]; then
        PROMPT="%F{green}%n%f"                                # user name
        PROMPT+="%F{green}@"
        PROMPT+="%F{green}${${(%):-%m}#zoltan-}%f"            # host name, minus zoltan
        PROMPT+=":"
        PROMPT+='%{$fg[cyan]%}%~%'                          # directory
        PROMPT+="  "
        PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)'      # git
        PROMPT+=" "
        PROMPT+='%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b'     # $
        PROMPT+=" "
    # Default Host
    else
        PROMPT='%{$fg[cyan]%}%~%'                          # directory
        PROMPT+="  "
        PROMPT+='%{$fg_bold[blue]%}$(git_prompt_info)'      # git
        PROMPT+=" "
        PROMPT+='%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b'     # $
        PROMPT+=" "
    fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
