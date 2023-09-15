{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.shells.aliases;
  user = config.attributes.primaryUser;
in {
  options = {
    shells.aliases.enable = mkOption {
      default = true;
      type = types.bool;
      description = "various useful aliases across all shells";
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      home.shellAliases = {
        v = (
          if user.editor != null
          then user.editor
          else "${pkgs.neovim}/bin/nvim"
        );
        "ns" = "nix-shell -p";
        ":wq" = "exit";
        ".." = "cd ../";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        ps = "ps -aef --forest";
        pw = "${pkgs.pass}/bin/pass -c";
        cp = "cp -iv";
        df = "df --block-size=1K --human-readable";
        mv = "mv -iv";
        rm = "rm -i";
        wget = "${pkgs.wget}/bin/wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
        grep = "${pkgs.ripgrep}/bin/rg -i --color=auto";
        ls = "${pkgs.eza}/bin/eza -ah  --color=auto --icons --group-directories-first";
        ll = "${pkgs.eza}/bin/eza -lah --color=auto --icons --group-directories-first";
        cat = "${pkgs.bat}/bin/bat";
      };
    })
  ];
}
