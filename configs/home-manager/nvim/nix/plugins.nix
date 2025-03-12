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

    # Treesitter
    nvim-treesitter

    # LSP
    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    copilot-cmp

    # Coding
    lazydev-nvim
    conform-nvim

    # UI
    mini-icons
    bufferline-nvim
    lualine-nvim

    # Editor
    which-key-nvim
    gitsigns-nvim
    git-blame-nvim

    # AI
    copilot-lua
    CopilotChat-nvim

    # Library
    plenary-nvim
  ];
in
pkgListToAttr plugins
