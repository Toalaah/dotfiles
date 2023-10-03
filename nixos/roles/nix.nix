{
  pkgs,
  nixpkgs,
  ...
}: {
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };
  nix = {
    # make nixpkgs registry use current flake input
    registry.nixpkgs.flake = nixpkgs;
    package = pkgs.nixFlakes;
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    settings = {
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # set nixpkgs in NIX_PATH to currently pinned flake input
  environment.etc.nixpkgs.source = builtins.toString pkgs.path;
  nix.nixPath = ["nixpkgs=/etc/nixpkgs"];
  # nix.channel.enable = false;
}
