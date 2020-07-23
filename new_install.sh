echo "* Running configuration setup..."
./setup.sh
echo "* Updating homebrew..."
brew update && brew upgrade
echo "* Installing Google Chrome..."
brew install google-chrome
echo "* Installing iTerm2..."
brew install iterm2
echo "* Installing tmux..."
brew install tmux
echo "* Installing gcc..."
brew install gcc
echo "* Installing gdb..."
brew install gdb

## optional: increase animation speed for dock appearing / hiding
defaults write com.apple.dock autohide-time-modifier -float 0.15; killall Dock
