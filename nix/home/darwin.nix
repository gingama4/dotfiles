{ lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
}
