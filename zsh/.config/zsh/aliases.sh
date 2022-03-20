alias v=${EDITOR:-nvim}
alias vim=${EDITOR:-nvim}
alias ..="cd .."
alias ...="cd ../../"
alias pw="pass -c"
alias cp="cp -iv"
alias mv="mv -iv"
alias grep="grep --color=auto"


if is_installed "exa"; then
  alias ls="exa -ah  --color=auto --icons --group-directories-first"
  alias ll="exa -lah --color=auto --icons --group-directories-first"
else
  alias ls="ls -Ah --color=auto"
  alias ll="ls -lAh --color=auto"
fi

is_installed "bat" && alias cat="bat"

alias ca="$EDITOR $HOME/.config/alacritty/alacritty.yml -c 'lcd %:p:h'"
alias cz="$EDITOR $ZDOTDIR/.zshrc -c 'lcd %:p:h'"
alias cv="$EDITOR $HOME/.config/nvim/init.lua -c 'lcd %:p:h'"
alias cdwm="$EDITOR $HOME/.config/dwm/config.h -c 'lcd %:p:h'"
alias cst="$EDITOR $HOME/.config/st/config.h -c 'lcd %:p:h'"
alias cdm="$EDITOR $HOME/.config/dmenu/config.h -c 'lcd %:p:h'"
alias cblk="$EDITOR $HOME/.config/dwmblocks/config.h -c 'lcd %:p:h'"

alias g="git"
alias ga="git add"
alias gau="git add -u"
alias gaa="git add -A"
alias gr="git restore"
alias grS="git restore --staged"
alias gs="git status"
alias gb="git branch"
function gco() { git checkout $1 2>/dev/null || git checkout -b $1 }
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git fetch --prune && git pull"
alias gP="git push"

