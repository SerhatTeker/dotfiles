# PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%~%  %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}%B$%b '
PROMPT='%{$fg[cyan]%}%~%  %{$fg_bold[blue]%}$(git_prompt_info) %(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"
