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

autoload -U colors && colors
COL1=044
COL2=084
function update_prompt() {
  PS1="%F{$COL1}%K{000}%2~%F{015}%K{000} "
  # find out if in git repo or not, and if so what branch
  BRANCH=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -z "$BRANCH" ]; then
      PS1+=""
  else
      CHANGES=$(git status --short | wc -l | awk '{$1=$1};1')
      if [ $CHANGES -eq 0 ]; then
        PS1+="% on %F{$COL1}%K{000}$BRANCH%F{015}%K{000} "
      else
        PS1+="% on %F{$COL1}%K{000}$BRANCH (+$CHANGES)%F{015}%K{000} "
      fi
  
  fi
  PS1+="%F{$COL2}%K{000}➜%F{015}%K{000} "
}
precmd_functions+=(update_prompt)

# =======================================================================
# ============================= OPTIONS ===============================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt autocd

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

update_prompt
# auto-ls on cd
chpwd() ls;  

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
