{ lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
  # Keep this at the initial compatibility version when updating inputs.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
