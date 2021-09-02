#!/usr/bin/env bash
set -eo pipefail

# TODO: choose more appropriate, hidden directory to clone repo to (perhaps $HOME/.local/share)
# TODO: add installers for tmux, neovim, zsh and alacritty
# TODO: add installers for zsh-syntax-highlighting, zsh-autosuggestions
# TODO: clean up script (documentation, consistencies with > /dev/null, etc.)
# TODO: add ssh key installer for github, etc. (put this at the end of the script, perhaps make optional)
# TODO: improve neovim installation (add packer installer, run neovim headlessly with packerSync / LspInstall, etc.)

dependencies=()
dotfiles=("alacritty" "nvim" "tmux" "zsh")
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"
REPO="toalaah/config"
DEST="$HOME/.local/share/.dotfiles"

# this function was taken and modified from the lunarvim installer
function determine_os_type {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        RECOMMEND_INSTALL="sudo pacman -S"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        RECOMMEND_INSTALL="sudo dnf install -y"
      elif [ -f "/etc/gentoo-release" ]; then
        RECOMMEND_INSTALL="emerge install -y"
      else # assume debian based
        RECOMMEND_INSTALL="sudo apt install -y"
      fi
      ;;
    Darwin)
      RECOMMEND_INSTALL="brew install"
      ;;
    *)
      printf "[${RED}Unsupported OS $OS detected! Exiting.${NC}]\n"
      exit 1
      ;;
  esac
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
  # we need to delete any existing files to avoid stow conflicts...
  for PROG in ${dotfiles[@]}; do 
    rm -rf $(find "${DEST}/${PROG}" -type f | sed "s/\/.dotfiles\/${PROG}//g") ||:
    stow -d "${DEST}" -S "${PROG}" 
  done
}

function install_font {
  # all fonts: https://www.nerdfonts.com/font-downloads
  FONT_NAME=$1
  curl -Lo /tmp/font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$FONT_NAME.zip -O /tmp/font.zip > /dev/null 2>&1
  unzip -n /tmp/font.zip -d ~/.local/share/fonts > /dev/null 2>&1
  fc-cache -fv > /dev/null 2>&1
  rm /tmp/font.zip
}

function print_status {
  printf "[${CYAN}$@${NC}]\n"
}

function ask_for_overwrite {
  printf "[${RED}Warning! The following files will be created / overwritten!${NC}]\n"
  for PROG in ${dotfiles[@]}; do 
    # black magic replacing to get all files which will be overwritten
    printf "$(find "${DEST}/${PROG}" -type f | sed "s/\/.dotfiles\/${PROG}//g")\n"
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
  determine_os_type
  print_status "Checking dependencies..."
  check_dependencies
  print_status "Requirements met"
  print_status "Cloning repo to ${DEST}"
  git clone "https://github.com/${REPO}" "$DEST"
  ask_for_overwrite
  print_status "Installing dotfiles..."
  symlink_dotfiles
  print_status "Done"
  print_status "Installing fonts..."
  install_font "UbuntuMono"
  install_font "FiraCode"
  print_status "Done"

  return 0
}

main

