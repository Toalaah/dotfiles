#!/bin/sh

function test_check_dependencies() {
  for PROG in 'brew' 'git' 'node' 'stow'
  do
    command -v $PROG &> /dev/null || print_dependency_error_and_exit
  done

}

function print_dependency_error_and_exit() {
  echo 'Missing dependencies!'
  exit 1
}

function symlink_dotfiles() {
  for PROG in 'alacritty' 'nvim' 'tmux' 'zsh'
  do
    stow $PROG 
  done
}


# Check dependencies + install if necessary (This includes the font for alacritty!)
# Stow files
# Install language servers
# Creating an ssh key just for you... ( + show link )


test_check_dependencies
echo 'more scripts'
exit 0
