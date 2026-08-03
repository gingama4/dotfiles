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

    homebrew-cmux = {
      url = "github:manaflow-ai/homebrew-cmux";
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
      linuxSystem = "x86_64-linux";

      mkLinuxHome =
        {
          username,
          system ? linuxSystem,
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs username; };
          modules =
            [
              ./nix/home/common.nix
              ./nix/home/linux.nix
            ]
            ++ modules;
        };

      mkWslWorkHome =
        args:
        mkLinuxHome (
          args
          // {
            modules = [ ./nix/home/wsl.nix ] ++ (args.modules or [ ]);
          }
        );

      mkDarwinConfiguration =
        {
          username,
          system ? darwinSystem,
          homeModules ? [ ],
          modules ? [ ],
        }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs username; };
          modules =
            [
              ./nix/darwin
              home-manager.darwinModules.home-manager
              nix-homebrew.darwinModules.nix-homebrew
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit inputs username; };
                home-manager.users.${username} = {
                  imports =
                    [
                      ./nix/home/common.nix
                      ./nix/home/darwin.nix
                    ]
                    ++ homeModules;
                };
              }
            ]
            ++ modules;
        };

      mkMacConfiguration = args: mkDarwinConfiguration args;
    in
    {
      lib = {
        inherit mkDarwinConfiguration mkLinuxHome mkMacConfiguration mkWslWorkHome;
      };

      homeModules = {
        common = ./nix/home/common.nix;
        darwin = ./nix/home/darwin.nix;
        linux = ./nix/home/linux.nix;
        wsl = ./nix/home/wsl.nix;
      };

      darwinConfigurations.hades = mkDarwinConfiguration {
        inherit username;
      };

      homeConfigurations.linux = mkLinuxHome {
        inherit username;
      };

      homeConfigurations.wsl-work = mkWslWorkHome {
        inherit username;
      };
    };
}
