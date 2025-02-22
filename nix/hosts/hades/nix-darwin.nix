{
  hostname,
  inputs,
  pkgs,
  system,
  username,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager

    ../../../configs/nix-darwin/macos-defaults.nix
    ../../../configs/nix-darwin/nix.nix
    ../../../configs/nix-darwin/homebrew.nix
  ];

  # System
  system.stateVersion = 5;
  networking.hostName = hostname;
  users.users.${username}.home = "/Users/${username}";

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home-manager.nix;
    extraSpecialArgs = {
      inherit
        hostname
        inputs
        username
        ;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
  };

  fonts = {
    packages = with pkgs; [
      hackgen-nf-font
    ];
  };
}
