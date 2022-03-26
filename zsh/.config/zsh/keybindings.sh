zmodload zsh/complist

# allows moving through completion-menu with vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# edit current command in $VISUAL
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line

# prefer CTRL-p/n to arrows when navigating through previous commands
bindkey "^p" up-history
bindkey "^n" down-history

# open interactive zoxide menu
bindkey -s '^f' 'zi^M'

# probably my most used keybinding...
bindkey "^l" autosuggest-accept

# bind for file browser (if installed)
is_installed "lf" && bindkey -s "^o" 'lf^M'

