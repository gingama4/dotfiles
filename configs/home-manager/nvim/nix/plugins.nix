pkgs:
with pkgs.vimPlugins; [
  # Base Plugin
  lazy-nvim
  snacks-nvim
  denops-vim

  # Input
  skkeleton

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
  cmp-skkeleton

  # Coding
  lazydev-nvim
  conform-nvim

  # UI
  mini-icons
  bufferline-nvim
  lualine-nvim
  noice-nvim

  # Editor
  which-key-nvim
  gitsigns-nvim
  git-blame-nvim

  # AI
  copilot-lua
  CopilotChat-nvim

  # Other
  vimdoc-ja

  # Library
  plenary-nvim
  nui-nvim
]
