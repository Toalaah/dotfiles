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
export PATH="$PATH:$HOME"/.local/share/pnpm

export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"/docker
export ELINKS_CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config/}"/elinks
export ANSIBLE_HOME="$HOME"/.config/ansible
export RUSTUP_HOME="$HOME"/.local/rustup
export CARGO_HOME="$HOME"/.local/cargo
export GOPATH="$HOME"/.local/go
export HISTFILE="$ZDOTDIR"/.zsh_history
export PNPM_HOME="$HOME"/.local/share/pnpm
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH_PLUGIN_ENABLE=1
export ZSH_PLUGIN_DIR="$HOME"/.local/zsh/plugins

export EDITOR=${EDITOR:-nvim}
export VISUAL=${VISUAL:-nvim}
export BROWSER=${BROWSER:-firefox}
export LESSHISTFILE=-

# overwrite prompt arrow by setting ARROW here
# ARROW="$"
# ARROW="%%"
# export ARROW=$'\n'"﬌"

if [[ is_installed("bat") ]]; then
  export PAGER=${PAGER:-bat}
  export BAT_THEME="Visual Studio Dark+"
  export BAT_STYLE="numbers,header,grid"
else
  export PAGER=${PAGER:-less}
fi

TERM_MAC=kitty
TERM_LINUX=st
export TERMINAL=${TERMINAL:-$(
  [[ $(uname -s) = "Darwin" ]] && { echo $TERM_MAC; true } || echo $TERM_LINUX
)}

export MANPAGER=${MANPAGER:-$(
  if is_installed "nvim"; then
   echo "nvim -M +Man!"
  elif is_installed "bat"; then
    echo "bat --style=plain --language=man"
  else
    echo "less"
  fi
)}

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
