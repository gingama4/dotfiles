{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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
          "hades" = self.lib.makeHomeManagerConfig {
            system = "aarch64-darwin";
            username = "gingama4";
            modules = [ ./nix/hosts/hades/home-manager.nix ];
          };

          "hythlodaeus" = self.lib.makeHomeManagerConfig {
            system = "x86_64-linux";
            modules = [ ./nix/hosts/hythlodaeus/home-manager.nix ];
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
