{
  lib,
  pkgs,
  ...
}:
with lib; {
  options.attributes = {
    primaryUser.name = mkOption {
      description = "Primary user's username";
      type = types.str;
    };
    primaryUser.fullName = mkOption {
      description = "Primary user's full name";
      type = types.str;
    };
    primaryUser.email = mkOption {
      description = "Primary user's email";
      type = types.str;
    };
    primaryUser.gpgKey = mkOption {
      description = "Primary user's GPG key";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.sshKeys = mkOption {
      description = "Primary user's ssh keys";
      default = [];
      type = types.listOf types.str;
    };
    primaryUser.additionalGroups = mkOption {
      description = "Additional groups this user should be in";
      default = [];
      type = types.listOf types.str;
    };
    primaryUser.shell = mkOption {
      description = "User's default shell";
      default = pkgs.bash;
      type = types.package;
    };
    primaryUser.currentTerminal = mkOption {
      description = "Primary user's current terminal emulator";
      default = null;
      type = types.nullOr types.package;
    };
    primaryUser.currentBrowser = mkOption {
      description = "Primary user's current browser";
      default = null;
      type = types.nullOr types.package;
    };
    primaryUser.locale = mkOption {
      description = "User's default locale";
      default = "en_US.UTF-8";
      type = types.str;
    };
  };
}
