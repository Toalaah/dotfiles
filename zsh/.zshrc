# =======================================================================
# =============================== ALIASES ===============================

alias vim=nvim
alias ..="cd .."
alias ...="cd ../../"
alias pw="pass -c"

# aliases get set to more aesthetic variants of ls / cat 
# (only if these variants are already installed on the system)
# this is only checked once per startup of every shell 
# instance, so the performance hit should be small
command -V exa &>/dev/null &&
  { alias ls="exa -ah  --color=auto --icons --group-directories-first" && 
    alias ll="exa -lah --color=auto --icons --group-directories-first"; } ||
  { alias ls="ls -Ah --color=auto" && alias ll="ls -lAh --color=auto"; }

command -V bat &>/dev/null && alias cat="bat"

# aliases for quickly opening various config files. the "-c 'lcd %:p:h'"
# flag sets the current working direcotry of the buffer to the root dir
# of the config file, which I personally find quite convenient
alias cz="nvim $HOME/.zshrc -c 'lcd %:p:h'"
alias cv="nvim $HOME/.config/nvim/init.lua -c 'lcd %:p:h'"
alias cdwm="nvim $HOME/.config/dwm/config.h -c 'lcd %:p:h'"
alias cst="nvim $HOME/.config/st/config.h -c 'lcd %:p:h'"
alias cdm="nvim $HOME/.config/dmenu/config.h -c 'lcd %:p:h'"
alias cblk="nvim $HOME/.config/dwmblocks/config.h -c 'lcd %:p:h'"

# =======================================================================
# =============================== PROMPT ================================

autoload -U colors && colors
COL1="%{$fg[cyan]%}"    # path color
COL2="%{$fg[blue]%}"    # arrow prompt color
RST="%{$reset_color%}"
ARROW="❯"
[ "$EUID" -eq 0 ] && ARROW="#"
function update_prompt() {
  # get name of python virtual environment (if in one)
  VENV=$([ -z "$VIRTUAL_ENV" ] || echo "("$(basename "$VIRTUAL_ENV")")")
  PS1="%B${COL2}${VENV}${RST}%B${COL1}%2~${RST}"
  # find out if in git repo or not, and if so what branch
  BRANCH=$(git branch --show-current 2>/dev/null)
  if [ -z "$BRANCH" ]; then
      PS1+=""
  else
      CHANGES=$(git status --short 2>/dev/null | wc -l | awk '{$1=$1};1')
      if [ $CHANGES -eq 0 ]; then
        PS1+=" on %B${COL1}$BRANCH${RST}"
      else
        PS1+=" on %B${COL1}$BRANCH (+$CHANGES)${RST}"
      fi
  
  fi
  PS1+="%B${COL2} ${ARROW}${RST}%b "
}
precmd_functions+=(update_prompt)

# =======================================================================
# ============================= OPTIONS ===============================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

export LANG=en_US.UTF-8
setopt globdots # enable tab-completion for hidden dirs / files
export VISUAL=nvim
export LANG=en_US.UTF-8
export PATH="$PATH:$HOME/.cargo/bin:/usr/local/opt/llvm/bin/:$HOME/.local/bin:$HOME/.bin:$HOME/.local/flutter/bin"
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

