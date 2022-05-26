#!/usr/bin/env bash

# globals
BASE_DEPENDENCIES=("stow" "git")
NVIM_DEPENDENCIES=("nvim" "unzip" "npm" "rg" "fd" "make")
dotfiles=("alacritty" "bat" "chromium" "kitty" "neomutt" "nvim" "picom" "scripts" "tmux" "wallpapers" "x11" "zathura" "zsh")
REPO="toalaah/config"
DEST="$HOME/.local/dotfiles"
STOW_TARGET="$HOME"
CHECK="[\e[38;5;46m✔\e[0m]"

# global helpers
function prompt_continue() {
  while true; do
      read -r -p "Do you wish to continue? [y/N] " 2>/dev/tty yn
      case $yn in
          [Yy]* ) return 0;;
          [Nn]* ) echo "Exiting without changes..." && return 1;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

# taken from https://stackoverflow.com/questions/2875424/correct-way-to-check-for-a-command-line-flag-in-bash
# returns 'true' if flag is present, and '' otherwise
function has_param() {
    local terms="$1"
    shift

    for term in $terms; do
        for arg; do
            if [[ $arg == "$term" ]]; then
                echo "true"
            fi
        done
    done
}

# if this flag is passed, script does not prompt user for overwrites, clones, etc.
NO_CONFIRM=$(has_param "-y --yes" "$@")
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
    [[ "$NO_CONFIRM" != "true" ]] && { prompt_continue || exit 0; }
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

  echo "Symlinking config for nvim"
  echo
  cd "$DEST" || exit 1
  delete_config_if_exists "nvim"
  stow nvim --target="$STOW_TARGET"

  echo "Checking nvim dependencies for boostrap-process..."
  check_dependencies "${NVIM_DEPENDENCIES[@]}" || { print_dependency_error "${NVIM_DEPENDENCIES[@]}" && echo "Skipping nvim boostrap process" && return; }

  echo -e "${CHECK}" "Requirements met"
  echo

  echo "Your system appears to be able to bootstrap its neovim configuration"
  echo "This will install all plugins, colorschemes, etc. automatically for you"
  echo
  [[ "$NO_CONFIRM" != "true" ]] && { prompt_continue || return 0; }

  # Sync plugins in headless nvim-instance to avoid errors on startup (if nvim is installed / requirements are met)
  echo "Bootstrapping nvim plugins. This may take a while..."
  echo
  nvim --headless -c 'exe ":!<command>" | redraw' -c 'autocmd User PackerComplete quitall'
  echo "Nvim installation complete"
}

function install_wallpapers {
  echo "Fetching and downloading wallpapers. This may take a while..."
  echo
  cd "$DEST" && delete_config_if_exists "wallpapers"
  git submodule init wallpapers/wallpapers &>/dev/null
  git submodule update
  stow wallpapers --target="$STOW_TARGET"
  echo "Sucessessfully installed and symlinked wallpapers"
  echo
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
  [[ "$NO_CONFIRM" != "true" ]] && { prompt_continue || exit 0; }
  echo

  echo "Cloning repo to" "$DEST"

  [ -d "$DEST" ] && rm -rf "$DEST"

  # clone repository to destination folder
  git clone https://github.com/"$REPO" "$DEST"

  # get user selection on what they want to install
  # (or select all if NO_CONFIRM flag is passed)
  declare result
  if [[ "$NO_CONFIRM" != "true" ]]; then
    multiselect result dotfiles
  else
    for ((i=0; i<${#dotfiles[@]}; i++)); do
      result+=("true")
    done
  fi

  mkdir -p "$HOME"/.config # ensure .config folder exists

  # advanced configs which require more setup than merely symlinking have
  # their own 'install_{conf}' function. If it does not exist we default to
  # the 'install_base' function which merely symlinks the configuration
  idx=0
  for option in "${dotfiles[@]}"; do
      [ "${result[idx]}" = "true" ] && { install_"$option" 2>/dev/null || install_base "$option"; }
      ((idx++))
  done

  echo "Done"
}

main

