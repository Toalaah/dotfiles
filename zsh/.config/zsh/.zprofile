function is_installed () {
  hash $1 &>/dev/null
}

export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/go/bin"
export PATH="$PATH:$HOME/.local/flutter/bin"
export PATH="$PATH:$HOME/.local/cargo/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin/"

export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
export GOPATH="$HOME/.local/go"
export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH_PLUGIN_ENABLE=1
export ZSH_PLUGIN_DIR="$HOME/.local/zsh/plugins"

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=chromium
export LESSHISTFILE=-

# overwrite prompt arrow by setting ARROW here
# ARROW="$"
# ARROW="%%"
# export ARROW=$'\n'"﬌"

export PAGER=$(
  is_installed "bat" && { echo "bat --style=plain"; true } || echo "less"
)

TERM_MAC=alacritty
TERM_LINUX=st
export TERMINAL=$(
  [[ $(uname -s) = "Darwin" ]] && { echo $TERM_MAC; true } || echo $TERM_LINUX
)

export MANPAGER=$(
  if is_installed "nvim"; then
   echo "nvim -M +Man!"
  elif is_installed "bat"; then
    echo "bat --style=plain --language=man"
  else
    echo "less"
  fi
)

