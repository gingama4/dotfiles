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

  # Keep the baseline tool paths available through hm-session-vars.sh. Shell
  # startup files additionally source a shared environment for launchers that
  # do not start an interactive shell.
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/share/mise/shims"
    "$HOME/go/bin"
    "$HOME/.nix-profile/bin"
  ];

  # Bash only reads BASH_ENV for non-interactive invocations. The referenced
  # file is intentionally POSIX-compatible and silent.
  home.sessionVariables.BASH_ENV = "$HOME/.config/shell/agent-env.sh";

  home.packages = editorPackages ++ 
    (with pkgs;[
      bat
      bruno-cli
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
      google-cloud-sdk
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
