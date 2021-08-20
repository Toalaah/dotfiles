#!/bin/bash

dependencies=()
dotfiles=("alacritty" "nvim" "tmux" "zsh")
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"

function determine_os_type {
  [[ $OSTYPE == "linux-gnu"* ]] && dependencies=("wget" "git" "npm" "stow") && return
  [[ $OSTYPE == "darwin"* ]] && dependencies=("wget" "brew" "git" "npm" "stow") && return
  printf "[${RED}Unsupported os/distro detected! Exiting.${NC}]\n" && exit 1
}

function check_dependencies {
  for PROG in ${dependencies[@]}; do
    command -v $PROG &> /dev/null || print_dependency_error_and_exit
  done
}

function print_dependency_error_and_exit {
  printf "[${RED}Missing dependencies! Required dependencies:${NC}]\n"
  for PROG in ${dependencies[@]}; do
    printf "\t$PROG\n"
  done
  printf "[${RED}Please make sure these are all installed and in your path before proceeding!${NC}]\n"
  exit 1
}

function symlink_dotfiles {
  for PROG in ${dotfiles[@]}; do 
    stow -S $PROG 
  done
}

function install_font {
  # all fonts: https://www.nerdfonts.com/font-downloads
  FONT_NAME=$1
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$FONT_NAME.zip -O /tmp/font.zip
  unzip -n /tmp/font.zip -d ~/.local/share/fonts > /dev/null 2>&1
  fc-cache -fv > /dev/null 2>&1
  rm $FONT_NAME.zip
}

function print_status {
  printf "[${CYAN}$@${NC}]\n"
}

function ask_for_overwrite {
  printf "[${RED}Warning! The following files will be created / overwritten!${NC}]\n"
  for PROG in ${dotfiles[@]}; do 
    # black magic replacing to get all files which will be overwritten
    printf "$(find $PROG -type f | sed 's/^[^\/]*\//~\//g')\n"
  done
  while true; do
      read -p "Do you wish to continue? [y/N] " yn
      case $yn in
          [Yy]* ) return;;
          [Nn]* ) print_status "Exiting." && exit 0;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

function main {
  # Check dependencies + install if necessary (This includes the font for alacritty!)
  # Stow files 
  # Install language servers 
  # Creating an ssh key just for you... ( + show link )

  determine_os_type
  print_status "Checking dependencies..."
  check_dependencies
  print_status "Done"
  print_status "Requirements met"
  ask_for_overwrite
  print_status "Installing dotfiles..."
  # leave this off for debugging 
  # symlink_dotfiles
  print_status "Done"
  print_status "Installing fonts..."
  install_font "UbuntuMono"
  install_font "FiraCode"
  print_status "Done"

  return 0
}

main

