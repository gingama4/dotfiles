inputs:
let
  defaultOverlays = [
    inputs.self.overlays.default
  ];
in 
{
  makeHomeManagerConfig =
    {
      modules,
      overlays ? defaultOverlays,
      system,
      username,
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit overlays system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit inputs system username;
        pkgs-stable = import inputs.nixpkgs-stable {
          inherit system overlays;
          config.allowUnfree = true;
        };
      };
      modules =
        [
          (
            { pkgs, ... }:
            {
              home = {
                inherit username;
                homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
                stateVersion = "25.05";
                enableNixpkgsReleaseCheck = false;
              };
              programs.home-manager.enable = true;
              programs.git.enable = true;
            }
          )
        ]
        ++ [ inputs.self.homeManagerModules.default ]
        ++ modules;
    };

    makeDarwinConfig =
      {
        hostname,
        modules,
        overlays ? defaultOverlays,
        system,
        username,
      }:
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit
            hostname
            inputs
            system
            username
            ;
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules =
          [
            {
              nixpkgs = {
                inherit overlays;
                config.allowUnfree = true;
                hostPlatform = system;
              };
            }
          ]
          ++ [ inputs.self.darwinModules.default ]
          ++ modules;
      };
}
