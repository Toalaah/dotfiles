{config, ...}: let
  user = config.attributes.primaryUser;
in {
  imports = [
    ../../modules
    ../attributes.nix
    ./secrets
  ];

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.11";
  };

  home.packages = [];

  shells.zsh.enable = true;

  wm.general.displayManager = "none";

  tools = {
    fzf.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  dev = {
    tmux.enable = true;
    git = {
      enable = true;
      signing.enable = false;
      gitleaks.enable = false;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
