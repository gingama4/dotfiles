pkgs:
let
  normalizePname =
    pname:
    builtins.replaceStrings
      [
        "-"
        "."
      ]
      [
        "_"
        "_"
      ]
      (pkgs.lib.toLower pname);

  pkgListToAttr =
    pkgList: pkgs.lib.foldl' (acc: pkg: acc // { "${normalizePname pkg.pname}" = pkg; }) { } pkgList;

  plugins = with pkgs.vimPlugins; [
    lazy-nvim
    snacks-nvim
  ];
in
pkgListToAttr plugins
