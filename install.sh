#!/usr/bin/env bash
set -eo pipefail

dependencies=("stow" "git")
dotfiles=("nvim" "tmux" "alacritty" "zsh" "x11")
REPO="toalaah/config"
DEST="$HOME/.local/dotfiles"

check_dependencies() {
  for PROG in ${dependencies[@]}; do
    command -v $PROG &>/dev/null || print_dependency_error_and_exit
  done
}

print_dependency_error_and_exit() {
  echo "Missing dependencies! Required dependencies:"
  for PROG in ${dependencies[@]}; do
    echo -e "- $PROG"
  done
  echo "Please make sure these are all installed and in your path before proceeding!"
  exit 1
}

symlink_dotfiles() {
  cd $DEST
  # we need to delete any existing files to avoid stow conflicts...
  for PROG in ${dotfiles[@]}; do 
    rm -rf $(find $PROG -type f | sed -e "s|$PROG|$HOME|")
    stow $PROG --target=$HOME
  done
}

prompt_wallpaper_download() {
  while true; do
      read -p "Do you wish to download wallpapers? [y/N] " yn
      case $yn in
          [Yy]* ) return 0;;
          [Nn]* ) echo "Skipping wallpaper download" && return 1;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

download_wallpapers() {
  cd $DEST
  dotfiles+=("wallpapers")
  git submodule init
  git submodule update
}

prompt_dotfile_symlink() {
  cd $DEST
  echo -e "Warning! The following files will be created / overwritten!\n"
  for PROG in ${dotfiles[@]}; do 
    find $PROG -type f | sed -e "s|$PROG|$HOME|"
  done
  echo
  while true; do
      read -p "Do you wish to continue? [y/N] " yn
      case $yn in
          [Yy]* ) return;;
          [Nn]* ) echo "Exiting." && exit 0;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

main() {
  echo "Checking dependencies..."
  check_dependencies
  echo "Requirements met"

  echo "Cloning repo to $DEST"
  git clone "https://github.com/$REPO" "$DEST"
  prompt_wallpaper_download && download_wallpapers

  prompt_dotfile_symlink
  echo "Installing dotfiles..."
  symlink_dotfiles

  echo "Done"
}

main

