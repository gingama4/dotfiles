{ lib, pkgs, ... }:

let
  optionalPackage =
    name:
    lib.optional (builtins.hasAttr name pkgs) (builtins.getAttr name pkgs);
in
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home.packages =
    with pkgs;
    [
      cargo
      chezmoi
      cmake
      eza
      fzf
      gh
      ghq
      git
      gnupg
      go
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
    ++ optionalPackage "corepack"
    ++ optionalPackage "gh-copilot"
    ++ optionalPackage "intelephense"
    ++ optionalPackage "pnpm"
    ++ optionalPackage "vtsls";
}
