# =======================================================================
# =============================== ALIASES ===============================

alias vim=nvim
alias ..="cd .."
alias ...="cd ../../"

# aliases get set to more aesthetic variants of ls / cat 
# (only if these variants are already installed on the system)
# this is only checked once per startup of every shell 
# instance, so the performance hit should be small

command -V exa &> /dev/null &&
  alias ls="exa -ah --group-directories-first --color=always --icons" ||
  alias ls="ls -a"

command -V bat &> /dev/null && alias cat="bat"

alias pw="pass -c"

ZSHRC=$HOME/.zshrc
VIMRC=$HOME/.config/nvim/init.lua

# =======================================================================
# ============================= FUNCTIONS ===============================

# this function finds all directories from the user's home directory
# and pipes them into fzf, the output of which is then used as an
# argument in cd. this required fd and fzf

function c {
  cd "$HOME/$(fd --type directory | fzf \
                                  --height=10 \
                                  --reverse \
                                  --border=sharp \
                                  --prompt='➜ ' \
                                  --cycle \
                                  --header='Go to:')"
}

# =======================================================================
# =============================== PROMPT ================================

autoload -U colors && colors
COL1=044 # path color
COL2=084 # arrow prompt color
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

export VISUAL=nvim
export PATH="$PATH:$HOME/.cargo/bin:/usr/local/opt/llvm/bin/"
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



[[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

