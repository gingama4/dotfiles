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
      username ? builtins.getEnv "USER",
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
}
