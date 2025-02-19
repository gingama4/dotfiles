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
    # Base Plugin
    lazy-nvim
    snacks-nvim

    # Colorscheme
    kanagawa-nvim

    # UI
    mini-icons
    bufferline-nvim

    # Editor
    which-key-nvim
  ];
in
pkgListToAttr plugins
