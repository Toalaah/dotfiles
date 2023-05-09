{
  description = "Localhost configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/nur";
    firefox-nightly.url = "github:colemickens/flake-firefox-nightly";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    zsh-nix-shell = {
      url = "github:goolord/simple-zsh-nix-shell";
      flake = false;
    };

    neovim-nightly = {
      url = "github:neovim/neovim/nightly/?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-utils,
    home-manager,
    nixpkgs,
    nur,
    ...
  } @ inputs: let
    users = import ./home/users;
    self.lib = import ./lib {inherit nixpkgs;};
    overlays = [
      (import ./overlays inputs)
      nur.overlay
    ];
  in
    {
      nixosConfigurations = with self.lib; {
        lilith = makeHost {
          hostname = "lilith";
          primaryUser = users.personal;
          specialArgs = inputs;
          config = {allowUnfree = true;};
          inherit overlays;
        };
        gaige = makeHost {
          hostname = "gaige";
          primaryUser = users.personal;
          specialArgs = inputs;
          config = {allowUnfree = true;};
          inherit overlays;
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system overlays;
        config = {};
      };
    in {
      formatter = pkgs.alejandra;
      devShells.default = with pkgs;
        mkShell {
          buildInputs = [
            alejandra
            deadnix
            git-crypt
            just
          ];
        };

      legacyPackages.homeConfigurations = self.lib.makeHomeConfigurations {
        inherit home-manager;
        users = {
          personal = {
            inherit overlays system;
            user = users.personal;
            config = {allowUnfree = true;};
            specialArgs = inputs;
          };
        };
      };
      packages.default = pkgs.hello;
    });
}
