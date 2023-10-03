{
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    extraConfig = ''
      Defaults timestamp_timeout=30
      Defaults timestamp_type=global
    '';
  };
}
