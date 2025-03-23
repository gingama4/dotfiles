{
  pkgs,
  prev,
}:
{
  gh-q = pkgs.callPackage ./gh-q { };
  vimPlugins = pkgs.callPackage ./vimPlugins { inherit pkgs; inherit prev; };
}
