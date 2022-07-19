alias v=${EDITOR:-nvim}
alias vim=${EDITOR:-nvim}
alias ..="cd .."
alias ...="cd ../../"
alias pw="pass -c"
alias cp="cp -iv"
alias mv="mv -iv"
if is_installed "rg"; then
  alias grep="rg"
else
  alias grep="grep --color=auto"
fi
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias tmp='$EDITOR $(mktemp /tmp/scratch.XXX)'

if is_installed "exa"; then
  alias ls="exa -ah  --color=auto --icons --group-directories-first"
  alias ll="exa -lah --color=auto --icons --group-directories-first"
else
  alias ls="ls -Ah --color=auto"
  alias ll="ls -lAh --color=auto"
fi

[[ "$TERM" = "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

is_installed "bat" && alias cat="bat"

alias ca="$EDITOR $HOME/.config/alacritty/alacritty.yml -c 'lcd %:p:h'"
alias cz="$EDITOR $ZDOTDIR/.zshrc -c 'lcd %:p:h'"
alias cv="$EDITOR $HOME/.config/nvim/init.lua -c 'lcd %:p:h'"
alias cdwm="$EDITOR $HOME/.config/dwm/config.h -c 'lcd %:p:h'"
alias cst="$EDITOR $HOME/.config/st/config.h -c 'lcd %:p:h'"
alias cdm="$EDITOR $HOME/.config/dmenu/config.h -c 'lcd %:p:h'"
alias cblk="$EDITOR $HOME/.config/dwmblocks/config.h -c 'lcd %:p:h'"

# sync to folders, usually I use this for syncing my media to an external
# drive
function sync() {
  if [ $# -ne 2 ]; then
    echo "Usage: sync <source> <destination>"
    return 1
  fi
  rsync -a --no-o --no-g --ignore-existing "$1" "$2"
}

function gprune() {
  git rev-parse -is-inside-work-tree > /dev/null 2>&1 || ( echo 'Not in git worktree, aborting prune'; false ) || return 1

  local merged_branches_origin
  local merged_branches_local

  merged_branches_origin=$(git branch --merged | grep -E -v '(^\*|master|main)')
  merged_branches_local=$(git branch -vv | grep ': gone]' | cut -d' ' -f3)

  [[ "" != "$merged_branches_origin$merged_branches_origin" ]] && echo "Nothing to clean" && return 0

  [[ ! -z "$merged_branches_origin" ]] && echo "$merged_branches_origin" | xargs git branch -d
  [[ ! -z "$merged_branches_local" ]] && echo "$merged_branches_local" | xargs git branch -D

  return 0
}

alias g="git"
alias ga="git add"
alias gau="git add -u"
alias gaa="git add -A"
alias gr="git restore"
alias grS="git restore --staged"
alias gs="git s"
alias gb="git branch -vv"
is_installed "fzf" && function gco() {
  TARGET=${1:-$(git branch -a | cut -c3- | sed -e '/->/d' | fzf --print-query | tail -n1 | sed -e 's|^remotes/origin/||')}
  [[ -z "$TARGET" ]] && return 130
  git checkout "$TARGET" 2>/dev/null || git checkout -b "$TARGET"
}
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git fetch --prune && git pull"
alias gP="git push"

