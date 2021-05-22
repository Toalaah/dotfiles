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

function update_prompt() {
  PS1="%F{blue}%2~%f"
  # find out if in git repo or not, and if so what branch
  BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -z "$BRANCH" ]; then
      PS1+=""
  else
      CHANGES=$(git s --short | wc -l | awk '{$1=$1};1')
      if [ $CHANGES -eq 0 ]; then
          PS1+=" on %F{blue}$BRANCH%f"
      else
        PS1+=" on %F{blue}$BRANCH%f (+$CHANGES)"
      fi
  
  fi
  PS1+=" > "
}
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

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
