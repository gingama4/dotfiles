{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
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
          "gingama4@hades" = self.lib.makeHomeManagerConfig {
            system = "aarch64-darwin";
            username = "gingama4";
            modules = [ ./nix/hosts/hades/home-manager.nix ];
          };

          "ubuntu@hythlodaeus" = self.lib.makeHomeManagerConfig {
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
