#!/usr/bin/env bash
set -eo pipefail

# TODO: add installers for tmux, neovim, zsh and alacritty
# TODO: clean up script (documentation, consistencies with > /dev/null, etc.)
# TODO: improve neovim installation (add packer installer, run neovim headlessly with packerSync / LspInstall, etc.)

dependencies=("stow" "git" "curl")
dotfiles=("nvim" "tmux" "alacritty" "zsh" "x11")
REPO="toalaah/config"
DEST="$HOME/.local/dotfiles"

# this function was taken and modified from the lunarvim installer
function determine_os_type {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        INSTALL="sudo pacman -S"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        INSTALL="sudo dnf install -y"
      elif [ -f "/etc/gentoo-release" ]; then
        INSTALL="emerge install -y"
      else # assume debian based
        INSTALL="sudo apt install -y"
      fi
      ;;
    Darwin)
      INSTALL="brew install"
      ;;
    *)
      echo "Unsupported OS '$OS' detected! Exiting."
      exit 1
      ;;
  esac
}

function check_dependencies {
  for PROG in ${dependencies[@]}; do
    command -v $PROG &>/dev/null || print_dependency_error_and_exit
  done
}

function print_dependency_error_and_exit {
  echo "Missing dependencies! Required dependencies:"
  for PROG in ${dependencies[@]}; do
    echo -e "\t$PROG"
  done
  echo "Please make sure these are all installed and in your path before proceeding!"
  exit 1
}

function symlink_dotfiles {
  cd $DEST
  # we need to delete any existing files to avoid stow conflicts...
  for PROG in ${dotfiles[@]}; do 
    rm -rf $(find "$DEST/$PROG" -type f | sed "s/\/.dotfiles\/$PROG//g") ||:
    stow -d "$DEST" -S "$PROG" 
  done
}

function install_programs {
  for PROG in ${dotfiles[@]}; do
    echo "Installing $PROG"
    $RECOMMEND_INSTALL $PROG
  done
}

function install_font {

  DST_DIR="$HOME/.local/share/fonts"
  [[ $(uname -s) == "Darwin"* ]] && DST_DIR="$HOME/Libary/Fonts/"
  FONT_NAME=$1
  echo "Installing font: $1"
  curl -Lo /tmp/font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$FONT_NAME.zip
  unzip -n /tmp/font.zip -d $DST_DIR
  fc-cache -fv
  rm /tmp/font.zip
}

function prompt_dotfile_symlink {
  echo "Warning! The following files will be created / overwritten!"
  for PROG in ${dotfiles[@]}; do 
    # black magic replacing to get all files which will be overwritten
    echo "$(find "${DEST}/${PROG}" -type f | sed "s/\/.dotfiles\/${PROG}//g")"
  done
  while true; do
      read -p "Do you wish to continue? [y/N] " yn
      case $yn in
          [Yy]* ) return;;
          [Nn]* ) echo "Exiting." && exit 0;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}


function configure_neovim {
  echo "Configuring neovim..."
  echo "Installing packer..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  echo "Installed packer"
  echo "Installing plugins..."
  # installs all plugins headlessly
  nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
  echo "Installed plugins"

}

function main {
  determine_os_type
  echo "Checking dependencies..."
  check_dependencies
  echo "Requirements met"
  echo "Cloning repo to ${DEST}"
  git clone "https://github.com/${REPO}" "$DEST"
  prompt_dotfile_symlink
  echo "Installing dotfiles..."
  symlink_dotfiles
  echo "Done"
  echo "Installing fonts..."
  install_font "UbuntuMono"
  install_font "Inconsolata"
  install_font "FiraCode"
  echo "Done"

}

main

