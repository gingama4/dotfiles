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
      bat
      cargo
      chezmoi
      cmake
      curl
      devenv
      eza
      fd
      fzf
      gh
      ghq
      git
      gnumake
      gnupg
      go
      jq
      lazygit
      mise
      neovim
      pnpm
      python3
      ripgrep
      rustc
      sheldon
      shellcheck
      starship
      tree
      tree-sitter
      vim
      yq-go
      zoxide
      zsh
    ]);

  home.file.".local/share/dotfiles/editor-bin".source =
    "${editorToolchain}/bin";
}
