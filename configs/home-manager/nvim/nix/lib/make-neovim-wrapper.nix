{
  neovim,
  pkgs,
}:
{
  extraPackages,
}:
let
  pluginList = import ../plugins.nix pkgs;
  toolList = import ../tools.nix pkgs;
  pkgList = pluginList ++ toolList;

  plugins = import ./normalizer.nix { list = pkgList; inherit pkgs; };
  nvimConfig = pkgs.callPackage ../config.nix { inherit plugins; };
in
pkgs.writeShellScriptBin "nvim" ''
  PATH=$PATH:${pkgs.lib.makeBinPath extraPackages}
  MY_CONFIG_PATH=${nvimConfig} ${neovim}/bin/nvim -u ${nvimConfig}/init.lua "$@"
''
