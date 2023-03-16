{
  description = "Localhost configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    st = {
      url = "github:toalaah/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dmenu = {
      url = "github:toalaah/dmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fzf-tab = {
      url = "github:aloxaf/fzf-tab";
      flake = false;
    };

    # Temporary fix for unreproducable build. See nix-community/neovim-nightly-overlay #164
    nixpkgs-neovim-nightly.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
    neovim-nightly = {
      url = "github:neovim/neovim/nightly/?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs-neovim-nightly";
    };
  };

  outputs = {
    flake-utils,
    home-manager,
    nixpkgs,
    nur,
    ...
  } @ inputs: let
    users = import ./home;
    self.lib = import ./lib {inherit nixpkgs;};
    overlays = [
      (import ./overlays inputs)
      nur.overlay
    ];
    mkPkgs = system:
      import nixpkgs {
        inherit system overlays;
        config = {};
      };
  in
    {
      nixosConfigurations = with self.lib; {
        lilith = makeHost {
          hostname = "lilith";
          primaryUser = users.personal;
          specialArgs = inputs;
          inherit overlays;
        };
      };
      homeConfigurations = let
        # TODO: allow many systems via flake-utils. currently placing in
        # eachDefaultSystem causes errors during hm builds
        pkgs = mkPkgs "x86_64-linux";
        # TODO: map over each user to auto-create home-configs
        userAttrs = import users.personal.attributes {inherit pkgs;};
        name = userAttrs.attributes.primaryUser.name;
      in {
        ${name} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs;
          modules = [users.personal.homeConfig];
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = mkPkgs system;
    in {
      formatter = pkgs.alejandra;
      devShells.default = import ./shell.nix {inherit pkgs;};
      packages.default = pkgs.hello;
    });
}
