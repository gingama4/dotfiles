{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ...}:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      flake = {
        lib = import ./nix/lib inputs;

        overlays = import ./nix/overlays inputs;

        homeManagerModules.default = import ./nix/modules/home-manager;
        homeConfigurations = {
          "hythlodaeus" = self.lib.makeHomeManagerConfig {
            system = "x86_64-linux";
            username = "ubuntu";
            modules = [ ./nix/hosts/hythlodaeus/home-manager.nix ];
          };
        };

        darwinModules.default = import ./nix/modules/nix-darwin;
        darwinConfigurations = {
          hades = self.lib.makeDarwinConfig {
            system = "aarch64-darwin";
            hostname = "hades";
            username = "gingama4";
            modules = [ ./nix/hosts/hades/nix-darwin.nix ];
          };
        };

      };

      perSystem =
        {
          config,
          system,
          pkgs,
          lib,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
          };
        };
    };
}
