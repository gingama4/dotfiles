pkgs:
with pkgs; [
  ripgrep
  lazygit
  fd

  # Programming languages (LSP/Formatter)
  ## Lua
  lua-language-server
  stylua

  ## TypeScript
  typescript
  typescript-language-server

  ## Vue
  vue-language-server
]
