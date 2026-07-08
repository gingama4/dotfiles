{ lib, pkgs, ... }:

let
  optionalPackage =
    name:
    let
      package = builtins.tryEval (builtins.getAttr name pkgs);
    in
    lib.optional package.success package.value;
in
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages =
    with pkgs;
    [
      blade-formatter
      cargo
      chezmoi
      cmake
      devenv
      eza
      fzf
      gh
      ghq
      git
      gnupg
      go
      gopls
      gofumpt
      lazygit
      lua-language-server
      mise
      neovim
      nodejs
      ripgrep
      rust-analyzer
      rustc
      sheldon
      tree-sitter
      vim
      zsh
    ]
    ++ optionalPackage "intelephense"
    ++ optionalPackage "pnpm"
    ++ optionalPackage "vtsls";

  home.sessionVariables = {
    EDITOR_NODE = lib.getExe pkgs.nodejs;
  };
}
