{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    eza
    ripgrep

    fzf
    ghq
  ];
}
