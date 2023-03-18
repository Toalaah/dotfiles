{config, ...}: let
  user = config.attributes.primaryUser;
in {
  imports = [../../modules ../../attributes.nix ./secrets];
  xresources.properties."Xft.dpi" = 144;
  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "22.11";
  };

  editors.neovim = {
    enable = true;
    useNightly = true;
    setManpager = true;
  };
  dev = {
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
}
