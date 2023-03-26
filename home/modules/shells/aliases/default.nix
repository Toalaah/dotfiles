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
        ":wq" = "exit";
        ".." = "cd ../";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        pw = "${pkgs.pass}/bin/pass -c";
        cp = "cp -iv";
        df = "df --block-size=1K --human-readable";
        mv = "mv -iv";
        rm = "rm -i";
        grep = "${pkgs.ripgrep}/bin/rg -i --color=auto";
        ls = "${pkgs.exa}/bin/exa -ah  --color=auto --icons --group-directories-first";
        ll = "${pkgs.exa}/bin/exa -lah --color=auto --icons --group-directories-first";
        cat = "${pkgs.bat}/bin/bat";
      };
    })
  ];
}
