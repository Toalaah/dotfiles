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
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.email = mkOption {
      description = "Primary user's email";
      default = null;
      type = types.nullOr types.str;
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
      description = "Primary user's default shell";
      default = pkgs.zsh;
      type = types.package;
    };
    primaryUser.editor = mkOption {
      description = "User's editor";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.terminal = mkOption {
      description = "Primary user's terminal emulator";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.browser = mkOption {
      description = "Primary user's browser";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.windowManager = mkOption {
      description = "Primary user's window manager / desktop environment";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.locale = mkOption {
      description = "User's default locale";
      default = "en_US.UTF-8";
      type = types.str;
    };
    primaryUser.timeZone = mkOption {
      description = "User's timezone";
      default = null;
      type = types.nullOr types.str;
    };
    primaryUser.smartcard.id = mkOption {
      description = "User's smartcard ID (ex from a Yubikey)";
      default = null;
      type = types.nullOr types.str;
    };
  };
}
