# =======================================================================
# =============================== ALIASES ===============================

alias vim=nvim
alias ..="cd .."
alias ...="cd ../../"
alias ls="ls -a --color"

ZSHRC=$HOME/.zshrc
VIMRC=$HOME/.config/nvim/init.vim

# =======================================================================
# =============================== PROMPT ================================

source $HOME/.prompt
precmd_functions+=(update_prompt)

# =======================================================================
# ============================= OPTIONS ===============================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt autocd

# tab completion (including for dotfiles)
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

update_prompt
# auto-ls on cd
chpwd() ls;  
