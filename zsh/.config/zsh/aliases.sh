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

alias gprune='git branch --merged| egrep -v "(^\*|master|main)" | xargs git branch -d'
alias g="git"
alias ga="git add"
alias gau="git add -u"
alias gaa="git add -A"
alias gr="git restore"
alias grS="git restore --staged"
alias gs="git status"
alias gb="git branch"
is_installed "fzf" && function gco() {
  TARGET=${1:-$(git branch -a | cut -c3- | sed -e '/->/d' | fzf --print-query | tail -n1 | sed -e 's|^remotes/origin/||')}
  [[ -z "$TARGET" ]] && return 130
  git checkout "$TARGET" 2>/dev/null || git checkout -b "$TARGET"
}
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git fetch --prune && git pull"
alias gP="git push"

