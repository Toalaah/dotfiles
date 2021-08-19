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

# Check dependencies + install if necessary (This includes the font for alacritty!)
check_dependencies
# Stow files
# Install language servers
# Creating an ssh key just for you... ( + show link )
exit 0

