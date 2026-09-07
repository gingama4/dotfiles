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
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... }:
    {
      darwinConfigurations.hades = nix-darwin.lib.darwinSystem {
        modules = [ ./nix/darwin ];
      };

      homeConfigurations.normal = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = { username = "gingama4"; };
        modules = [ ./home/normal.nix ];
      };
    };
}
