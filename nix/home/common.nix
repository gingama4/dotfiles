{ lib, pkgs, ... }:

let
  editorPackages =
    with pkgs;
    [
      astro-language-server
      blade-formatter
      copilot-language-server
      gopls
      intelephense
      lua-language-server
      nodejs
      rust-analyzer
      vtsls
    ];

  editorToolchain = pkgs.buildEnv {
    name = "dotfiles-editor-toolchain";
    paths = editorPackages;
    pathsToLink = [ "/bin" ];
  };
in
{
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = editorPackages ++ 
    (with pkgs;[
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
      lazygit
      mise
      neovim
      pnpm
      ripgrep
      rustc
      sheldon
      tree-sitter
      vim
      zsh
    ]);

  home.file.".local/share/dotfiles/editor-bin".source =
    "${editorToolchain}/bin";
}
