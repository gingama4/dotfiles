{
  description = "gingama4 dotfiles system and user packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin }:
    {
      darwinConfigurations.hades = nix-darwin.lib.darwinSystem {
        modules = [ ./nix/darwin ];
      };
    };
}
