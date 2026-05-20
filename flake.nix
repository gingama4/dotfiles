{
  description = "gingama4 dotfiles system and user packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      username = "gingama4";
      darwinSystem = "aarch64-darwin";
      wslSystem = "x86_64-linux";
    in
    {
      darwinConfigurations.hades = nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        specialArgs = { inherit inputs username; };
        modules = [
          ./nix/darwin
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs username; };
            home-manager.users.${username} = {
              imports = [
                ./nix/home/common.nix
                ./nix/home/darwin.nix
              ];
            };
          }
        ];
      };

      homeConfigurations.wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = wslSystem;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs username; };
        modules = [
          ./nix/home/common.nix
          ./nix/home/wsl.nix
        ];
      };
    };
}
