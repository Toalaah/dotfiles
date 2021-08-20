#!/bin/bash

function check_dependencies() {
  for PROG in 'brew' 'git' 'node' 'stow'; do
    command -v $PROG &> /dev/null || print_dependency_error_and_exit
  done

}

function print_dependency_error_and_exit() {
  printf 'Missing dependencies! Required dependencies:\n\n'
  for PROG in 'brew' 'git' 'node' 'stow'; do
    printf $PROG'\n'
  done
  printf '\nPlease make sure these are all installed and in your path before proceeding!\n'
  exit 1
}

function symlink_dotfiles() {
  for PROG in 'alacritty' 'nvim' 'tmux' 'zsh'; do 
    stow $PROG 
  done
}

function install_font() {
  # all fonts: https://www.nerdfonts.com/font-downloads
  FONT_NAME=$1
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$FONT_NAME.zip
  unzip $FONT_NAME.zip -d ~/.local/share/fonts > /dev/null 2>&1
  fc-cache -fv > /dev/null 2>&1
  rm $FONT_NAME.zip
}

# Check dependencies + install if necessary (This includes the font for alacritty!)
check_dependencies
# Stow files
# Install language servers
# Creating an ssh key just for you... ( + show link )
exit 0

