{...}: {
  imports = [
    ./browsers/firefox
    ./dev/git
    ./dev/k8s
    ./dev/tmux
    ./editors/neovim
    ./misc/services/dunst
    ./misc/services/picom
    ./misc/services/redshift
    ./productivity/zathura
    ./shells/aliases
    ./shells/zsh
    ./terminals/alacritty
    ./terminals/st
    ./tools/dmenu
    ./tools/fzf
    ./tools/ripgrep
    ./tools/zoxide
    ./wm/bspwm
    ./wm/eww
    ./wm/general.nix
    ./wm/sxhkd
  ];
}
