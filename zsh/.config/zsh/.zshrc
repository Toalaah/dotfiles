export ZDOTDIR=${ZDOTDIR:-$HOME}

function is_installed () {
  hash $1 &>/dev/null
}

source $ZDOTDIR/aliases.sh
source $ZDOTDIR/preferences.sh
source $ZDOTDIR/keybindings.sh
source $ZDOTDIR/plugins.sh
source $ZDOTDIR/prompt.sh

unset -f is_installed

# Fix SSH issues with smartcard + GPG
export GPG_TTY=$(/usr/bin/tty)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
