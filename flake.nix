{
  description = "Localhost configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nur.url = "github:nix-community/nur";

    firefox-nightly.url = "github:colemickens/flake-firefox-nightly";
    firefox-nightly.inputs.nixpkgs.follows = "nixpkgs";

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

    nvim-utils.url = "github:toalaah/nvim-utils";
    nvim-utils.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly.url = "github:neovim/neovim/nightly?dir=contrib";
    neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

    eww.url = "github:ralismark/eww/tray-3";

    gulp.url = "github:toalaah/gulp";
    gulp.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    nur,
    nvim-utils,
    neovim-nightly,
    gulp,
    ...
  } @ inputs: let
    users = import ./home/users;
    lib' = import ./lib {inherit nixpkgs;};
    overlays = [
      (import ./overlays inputs)
      nur.overlay
      (_final: prev: {
        eww = inputs.eww.packages.${prev.system}.default;
        nvim = self.packages.${prev.system}.nvim;
      })
    ];
    eachSystem = f:
      nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ] (system: let pkgs = import nixpkgs {inherit system;}; in f {inherit system pkgs;});
  in {
    nixosConfigurations = with lib'; {
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
        roles = [
          "bspwm"
          "docker"
          "gpg"
          "libvirt"
          "locale"
          "misc"
          "networking"
          "nfs"
          "nix"
          "nvidia"
          "pipewire"
          "ssh"
          "sudo"
          "tor"
          "vpn"
          "wireguard"
          "xorg"
          "yubikey"
        ];
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

    formatter = eachSystem ({pkgs, ...}: pkgs.alejandra);

    devShells = eachSystem ({pkgs, ...}: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          alejandra
          deadnix
          git-crypt
          just
        ];
      };
    });

    # use legacyPackages to expose hm-config for each system type
    legacyPackages = eachSystem ({system, ...}: {
      homeConfigurations = lib'.makeHomeConfigurations {
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
    });

    packages = eachSystem ({
      pkgs,
      system,
      ...
    }: {
      default = pkgs.hello;
      nvim = with nvim-utils.lib;
        mkNvimPkg {
          inherit pkgs;
          configuration = ./nvim/conf;
          modules = [baseModules.all ./nvim/modules];
          package = neovim-nightly.packages.${system}.default;
        };
    });
  };
}
