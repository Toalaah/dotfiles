{
  config,
  pkgs,
  ...
}: let
  user = config.attributes.primaryUser;
in {
  imports = [../../modules ../attributes.nix ./secrets];

  # xresources.properties."Xft.dpi" = 144;

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.11";
  };

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka"];})
    corefonts
    jetbrains-mono
    terminus-nerdfont
    iosevka-comfy.comfy
    xclip # fix clipboard not interoping w/ vim
  ];

  fonts.fontconfig.enable = true;

  browsers.firefox.enable = true;
  browsers.firefox.useNightly = true;

  shells.zsh.enable = true;

  misc.applications.spotify = {
    enable = true;
    windowManagerSupport = true;
    theme = "catppuccin-mocha";
    colorScheme = "flamingo";
  };

  security.gpg = {
    enable = true;
    sshSupport = true;
  };

  misc.services = {
    # picom.enable = true;
    redshift = {
      enable = true;
      autoDetermineLocation = true;
    };
    dunst.enable = true;
  };

  # terminals.st.enable = true;
  terminals.alacritty.enable = true;
  terminals.alacritty.fontFamily = "Iosevka Comfy";

  tools = {
    dmenu = {
      enable = true;
      sxhkdIntegration.enable = true;
    };
    fzf.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  editors.neovim.enable = true;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  wm = {
    general.displayManager = "xinit";
    bspwm = {
      enable = true;
      numDesktops = 6;
      defaultLayout = "even";
      # desktops."1".name = "web";
      statusBar = "tint2";
    };
    sxhkd.enable = true;
    eww.configuration = "sovl";
  };

  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.autorandr}/bin/autorandr --change
    '';
  };

  productivity.zathura.enable = true;
}
