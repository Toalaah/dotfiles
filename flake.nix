{
  description = "Localhost configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/nur";
    firefox-nightly.url = "github:colemickens/flake-firefox-nightly";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    st.url = "github:toalaah/st";
    st.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    dmenu.url = "github:toalaah/dmenu";
    dmenu.inputs.nixpkgs.follows = "nixpkgs";

    fzf-tab.url = "github:aloxaf/fzf-tab";
    fzf-tab.flake = false;

    zsh-nix-shell.url = "github:goolord/simple-zsh-nix-shell";
    zsh-nix-shell.flake = false;

    neovim-nightly.url = "github:neovim/neovim/nightly/?dir=contrib";
    neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

    nvim-flake.url = "github:toalaah/neovim-flake";

    eww.url = "github:ralismark/eww/tray-3";
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
      (_final: prev: {
        eww = inputs.eww.packages.${prev.system}.default;
      })
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
        zer0 = makeHost {
          hostname = "zer0";
          primaryUser = users.vm;
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
