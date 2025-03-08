{
  pkgs,
  vimUtils,
}:
let
  sources = import ./sources.nix {
    inherit (pkgs)
      fetchurl
      fetchFromGitHub
      ;
  };
in
{
  vimPlugins = builtins.mapAttrs (
    key: value:
    vimUtils.buildVimPlugin {
      inherit (value) pname version src;
      dontBuild = true;
    }
  ) sources;
}
