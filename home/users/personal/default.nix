{
  config,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  imports = [../../modules ../attributes.nix ./secrets];

  xresources.properties."Xft.dpi" = 144;

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.11";
  };

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    jetbrains-mono
  ];

  browsers.firefox.enable = true;

  shells.zsh.enable = true;

  misc.services = {
    redshift = {
      enable = true;
      autoDetermineLocation = true;
    };
  };

  terminals.alacritty = {
    enable = true;
    theme = "rose-pine";
  };

  tools = {
    dmenu = {
      enable = true;
      sxhkdIntegration.enable = true;
    };
    fzf.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  editors.neovim = {
    enable = true;
    useNightly = true;
    setManpager = true;
  };

  dev = {
    tmux.enable = true;
    git = {
      enable = true;
      signing.enable = true;
      git-crypt.enable = true;
      lazygit.enable = true;
      gh.enable = true;
      gitleaks.enable = true;
    };
    k8s = {
      kind.enable = true;
      k9s = {
        enable = true;
        theme = "rose-pine";
      };
    };
  };

  # TODO: xresources module
  # wm.bspwm = {
  #   enable = true;
  #   numDesktops = 6;
  # };
  wm.sxhkd.enable = true;

  productivity.zathura.enable = true;
}
