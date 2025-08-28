pkgs:
with pkgs; [
  ripgrep
  lazygit
  fd

  # Copilot
  copilot-language-server

  # Programming languages (LSP/Formatter)
  ## Lua
  lua-language-server
  stylua

  # PHP
  intelephense

  ## TypeScript
  typescript
  typescript-language-server

  ## Vue
  vue-language-server

  # Go
  go
  gopls
  gofumpt
  gotools
]
