pkgs:
with pkgs; [
  ripgrep
  lazygit
  fd

  # Programming languages (LSP/Formatter)
  ## Lua
  lua-language-server
  stylua

  # PHP
  phpactor

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
