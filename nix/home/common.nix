{ lib, ... }:
{
  home.username = "gingama4";
  home.homeDirectory = lib.mkForce "/Users/gingama4";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

