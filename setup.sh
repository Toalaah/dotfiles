#!/bin/sh

echo "* Beginning setup...\n"
sleep 0.2
echo "* Searching for pre-existing config files...\n"
sleep 0.2
FILE=~/.zshrc
if test -f "$FILE"; then
	echo "* Found zshrc at $FILE, backing up to $FILE.bac\n"
	cp ~/.zshrc ~/.zshrc.bac
fi

FILE=~/.tmux.conf
if test -f "$FILE"; then
	echo "* Found tmux config at $FILE, backing up to $FILE.bac\n"
	cp ~/.tmux.conf ~/.tmux.conf.bac
fi

FILE=~/.config/nvim/init.vim
if test -f "$FILE"; then
	echo "* Found nvim config at $FILE, backing up to $FILE.bac\n"
	cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bac 
fi

echo "* Backups completed\n"

echo "* Creating new source files...\n"
sleep 0.2
echo source ~/config/zsh/zshrc > ~/.zshrc
echo "* Created .zshrc\n"
echo source ~/config/nvim/init.vim > ~/.config/nvim/init.vim 
echo "* Created .vimrc\n"
echo source ~/config/tmux/tmux.conf > ~/.tmux.conf
echo "* Created tmux.conf\n"



# Add various git shortcuts
if [ "$*" == "-git" ] || [ "$*" == "--git" ]  
then
  echo "* Adding git shortcuts...\n"
  git config --global alias.s status
  git config --global alias.br branch
  git config --global alias.co checkout
  git config --global alias.cm commit
  echo "* Please enter your git username\n"
  read gitusername
  echo "* Please enter your git email\n"
  read gitemail
  echo "* Setting git credentials...\n"
  git config --global user.name $gitusername
  git config --global user.name $gitemail
  echo "* Done\n"
fi

if [ "$*" == "-min" ] || [ "$*" == "--min" ]
then
echo "* Done\n"
exit 0
fi


if [ "$*" == "-zsh" ] || [ "$*" == "--all" ]
then
  # ZSH Installation
  echo "* Installing zsh...\n"
  brew install zsh
  echo "* Installing zsh syntax highighting...\n"
  brew install zsh-syntax-highlghting
  echo "* Done\n"
fi


if [ "$*" == "-itrm" ] || [ "$*" == "--all" ]
then
  # iTerm Installation
  #cp ~/config/iTerm/term-configs.json ~/Library/Application\ Support/iTerm/DynamicProfiles/itermprofiles.json
  echo "* Installing iTerm2...\n"
  brew install --cask iterm && echo "* Done. Please import pre-existing iTerm config from ~/config/iTerm/term-config.json by opening the application and going to 'Preferences -> Profiles -> Other actions -> Import JSON Profile\n"
fi


if [ "$*" == "-tmx" ] || [ "$*" == "--all" ]
then
  # Tmux installation
  echo "* Installing Tmux"
  brew install tmux
  echo "* Installing Tmux Plugin Manager"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "* Done\n"
fi


if [ "$*" == "-llvm" ] || [ "$*" == "--all" ]
then
  # llmv installation
  echo "* Installing llvm...\n"
  brew install llvm
  echo "* Done\n"
fi

# TODO nvim requirements / other installs
# ctrlp-search (http://ctrlpvim.github.io/ctrlp.vim/#installation)
# coc (https://www.chrisatmachine.com/Neovim/04-vim-coc/)
# pass integration (with browser support)

# Faster dock hiding / appearing
defaults write com.apple.dock autohide-time-modifier -float 0.1 && killall Dock
# Disable mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1
echo "* Done\n"
