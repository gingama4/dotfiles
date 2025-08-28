{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Coreutils
    bat
    eza
    fd
    ripgrep

    # Utilities
    fzf
    ghq
    nh

    #neofetch
  ];
}
