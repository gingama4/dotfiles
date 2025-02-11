{ pkgs, ... }:
let
  makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix {
    inherit pkgs;
    neovim = pkgs.neovim;
  };

  tools = import ./nix/tools.nix pkgs;

  neovimWrapper = makeNeovimWrapper { extraPackages = tools; };
in
{
  home.packages = [ neovimWrapper ];
}
