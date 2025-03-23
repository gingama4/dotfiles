{
  pkgs,
  prev,
}:
let
  myPkgs = import ./lib.nix { inherit pkgs; inherit (pkgs) vimUtils; };
in
prev.vimPlugins // myPkgs.vimPlugins
