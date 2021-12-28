#!/usr/bin/env bash

# globals
BASE_DEPENDENCIES=("stow" "git")
NVIM_DEPENDENCIES=("unzip" "npm" "rg" "fd" "make")
dotfiles=("nvim" "tmux" "alacritty" "zsh" "x11" "scripts" "wallpapers" "bat")
REPO="toalaah/config"
DEST="$HOME/.local/dotfiles"
STOW_TARGET="$HOME"
CHECK="[\e[38;5;46m✔\e[0m]"

# global helpers
prompt_continue() {
  while true; do
      read -r -p "Do you wish to continue? [y/N] " yn
      case $yn in
          [Yy]* ) return 0;;
          [Nn]* ) echo "Exiting without changes..." && return 1;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

normal=$(tput sgr0)
emph=$(tput bold smul)

# taken and slightly modified from: https://unix.stackexchange.com/questions/146570/arrow-key-enter-menu/673436#673436
function multiselect {
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "${ESC}[?25h"; }
    cursor_blink_off()  { printf "${ESC}[?25l"; }
    cursor_to()         { printf "${ESC}[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  ${ESC}[7m $1 ${ESC}[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW _; echo ${ROW#*[}; }

    echo "${emph}Warning!${normal} The configurations you select ${emph}will${normal} overwrite any existing configurations!"
    echo
    echo "Please make sure any configurations you wish to keep are backed up ${emph}before${normal} running this script!"
    echo
    prompt_continue || exit 0
    echo "Please select the configurations you wish to install:"

    local return_value=$1
    local -n options=$2

    local selected=()
    for ((i=0; i<${#options[@]}; i++)); do
          selected+=("false")
        printf "\n"
    done

    # determine current screen position for overwriting the options
    local lastrow
    lastrow=$(get_cursor_row)
    local startrow=$(($lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    key_input() {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = ""      ]]; then echo enter; fi;
        if [[ $key = $'\x20' ]]; then echo space; fi;
        if [[ $key = "k" ]]; then echo up; fi;
        if [[ $key = "j" ]]; then echo down; fi;
        if [[ $key = $'\x1b' ]]; then
            read -rsn2 key
            if [[ $key = [A || $key = k ]]; then echo up;    fi;
            if [[ $key = [B || $key = j ]]; then echo down;  fi;
        fi 
    }

    toggle_option() {
        local option=$1
        if [[ ${selected[option]} == true ]]; then
            selected[option]=false
        else
            selected[option]=true
        fi
    }

    print_options() {
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
            local prefix="[ ]"
            if [[ ${selected[idx]} == true ]]; then
              prefix="${CHECK}"
            fi

            cursor_to $(($startrow + $idx))
            if [ "$idx" -eq "$1" ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done
    }

    local active=0
    while true; do
        print_options $active

        # user key control
        case $(key_input) in
            space)  toggle_option $active;;
            enter)  print_options -1; break;;
            up)     ((active--));
                    if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                    if [ $active -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    eval $return_value='("${selected[@]}")'
}

function check_dependencies {
  DEPS=("$@")
  for PROG in "${DEPS[@]}"; do
    command -v "$PROG" &>/dev/null || return 1
  done
  return 0
}

function print_dependency_error {
  DEPS=("$@")
  echo "Missing dependencies! Required dependencies:"
  for PROG in "${DEPS[@]}"; do
    echo -e "  - $PROG"
  done
  echo "Please make sure these are all installed and in your path before proceeding!"
}

function delete_config_if_exists {
  # Deletes the config files of the passed argument ($1), which is determined
  # based on the folder structure in the repo and the relative stow target. Ex
  # for nvim, which relative to this script is in ./nvim/.config/nvim, it would
  # delete the necessary files in  $HOME/.config/nvim (if they exist) as the
  # stow target is $HOME
  find "$1" -type f | sed "s|^$1/|$STOW_TARGET/|" | xargs -I {} bash -c '[ -f {} ] && rm -rf {}'
}

function install_nvim {
  echo "Checking nvim dependencies..."
  check_dependencies "${NVIM_DEPENDENCIES[@]}"|| { print_dependency_error "${NVIM_DEPENDENCIES[@]}" && echo "Skipping nvim installation" && return; }

  echo -e "${CHECK}" "Requirements met"
  cd "$DEST" || exit 1

  delete_config_if_exists "nvim"
  stow nvim --target="$STOW_TARGET"
  # Sync plugins in headless nvim-instance to avoid errors on startup (if nvim is installed)
  echo "Bootstrapping nvim plugins. This may take a while..."
  echo
  command -v nvim && nvim --headless -c 'autocmd User PackerComplete quitall'
  echo "Nvim installation complete"
}

function install_wallpapers {
  echo "Fetching and downloading wallpapers. This may take a while..."
  echo
  cd "$DEST" && delete_config_if_exists "wallpapers"
  git submodule init wallpapers/wallpapers
  git submodule update
  stow wallpapers --target="$STOW_TARGET"
}

function install_base {
  # Removes the target folder of the first argument passed and stows the first
  # argument passed relative to the user's home folder
  echo "Symlinking config for" "$1"
  echo
  cd "$DEST" && delete_config_if_exists "$1"
  stow "$1" --target="$STOW_TARGET"
}

function main {
  echo "Checking dependencies..."
  echo
  check_dependencies "${BASE_DEPENDENCIES[@]}"|| { print_dependency_error "${BASE_DEPENDENCIES[@]}"&& exit 1; }
  echo -e "${CHECK}" "Requirements met" 
  echo

  echo "${emph}Warning!${normal} This script will completely overwrite the folder" "$DEST"
  echo
  prompt_continue || exit 0
  echo

  echo "Cloning repo to" "$DEST"

  [ -d "$DEST" ] && rm -rf "$DEST"

  # prefer cloning with ssh if possible
  git clone git@github.com:"$REPO" "$DEST" 2>/dev/null || \
  git clone https://github.com/"$REPO" "$DEST"

  # get user selection on what they want to install
  declare result
  multiselect result dotfiles

  # advanced configs which require more setup than merely symlinking have
  # their own 'install_{conf}' function. If it does not exist we default to
  # the 'install_base' function which merely symlinks the configuration
  mkdir -p "$HOME"/.config # ensure .config folder exists
  idx=0
  for option in "${dotfiles[@]}"; do
      [ "${result[idx]}" = "true" ] && { install_"$option" 2>/dev/null || install_base "$option"; }
      ((idx++))
  done

  echo "Done"
}

main

