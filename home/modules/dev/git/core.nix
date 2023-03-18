{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  user = config.attributes.primaryUser;
  cfg = config.dev.git;
in {
  options = {
    dev.git = {
      enable = mkEnableOption "core git-related services";
      globalIgnore = mkOption {
        type = types.listOf types.str;
        default = [
          ".DS_Store"
          "node_modules"
          "result"
        ];
        description = "files / directories to globally ignore";
      };
      signing.enable = mkEnableOption "GPG commit-signing";
      git-crypt.enable = mkEnableOption "git-crypt";
      gitleaks = {
        enable = mkEnableOption "git-leaks";
        enablePreCommitHook = mkOption {
          type = types.bool;
          default = true;
          description = "configure gitleaks as precommit hook";
        };
      };
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      assertions = [
        {
          assertion = cfg.signing.enable -> (user.gpgKey != null);
          message = "can't sign commits without GPG key";
        }
        {
          assertion = user.email != null && user.fullName != null;
          message = "email / name need to be set in order to use git";
        }
      ];
      home.shellAliases = {
        g = "git";
        ga = "git add";
        gau = "git add -u";
        gaa = "git add -A";
        gr = "git restore";
        grv = "git remote -v";
        gd = "git diff";
        grs = "git restore --staged";
        gs = "git s";
        gb = "git branch -vv";
        gc = "git commit";
        gcm = "git commit -m";
        gca = "git commit --amend";
        gp = "git fetch --prune && git pull";
        gP = "git push";
      };
      programs.git = {
        enable = true;
        aliases = {
          s = "status";
          lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
        };
        delta = {
          enable = true;
          options = {
            side-by-side = false;
          };
        };
        ignores = cfg.globalIgnore;
        signing = mkIf cfg.signing.enable {
          key = user.gpgKey;
          signByDefault = true;
        };
        extraConfig = {
          user = {
            email = user.email;
            name = user.fullName;
          };
          core.editor = builtins.toString (lib.findFirst (x: x != null)
            pkgs.neovim # default editor fallback
            
            [
              (config.home.shellAliases.EDITOR or null)
              user.editor
            ]);
          init.defaultBranch = "master";
          pull.rebase = true;
          push.autoSetupRemote = true;
          rebase.autoStash = true;
          merge.confictStyle = "diff3";
          diff.colorMoved = "default";
        };
      };
    })

    (mkIf cfg.git-crypt.enable {
      assertions = [
        {
          assertion = cfg.enable;
          message = "git needs to be enabled for this service to work";
        }
      ];
      home.packages = with pkgs; [git-crypt];
    })

    (mkIf cfg.gitleaks.enable {
      assertions = [
        {
          assertion = cfg.enable;
          message = "Git needs to be enabled for this service to work";
        }
      ];
      home.packages = with pkgs; [gitleaks];
      programs.git = {
        hooks = mkIf cfg.gitleaks.enablePreCommitHook {
          pre-commit = pkgs.writeScript "./pre-commit" ''
            #!/bin/sh

            gitleaks -c ${./gitleaks.toml} detect
          '';
        };
      };
    })
  ];
}
