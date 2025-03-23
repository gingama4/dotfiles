{ pkgs, ... }:
let
  makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix {
    inherit pkgs;
    neovim = pkgs.neovim;
  };

  tools = import ./nix/tools.nix pkgs;
  nodes = import ./nix/nodes.nix pkgs;

  neovimWrapper = makeNeovimWrapper { extraPackages = tools ++ nodes; };
in
{
  home.packages = [ neovimWrapper ];

  home.file.".skk" = {
    source = "${pkgs.skkDictionaries.l}/share/skk";
    recursive = true;
  };
}
