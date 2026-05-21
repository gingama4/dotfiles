{ lib, username, pkgs, ... }:

{
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  home.packages =
    with pkgs;
    [
      codex
    ];
}
