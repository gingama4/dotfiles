{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../modules/home-manager

    ../../../configs/cli-utilities
    ../../../configs/gh
    ../../../configs/git
    ../../../configs/lazygit
    ../../../configs/nvim
    ../../../configs/sheldon
    ../../../configs/wezterm
    ../../../configs/xdg
    ../../../configs/zsh
  ];

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
  };

  development.enable = true;

  home.packages = with pkgs; [
    vscode
    discord
    slack
  ];

  programs.home-manager.enable = true;

  # Development
  programs.git.enable = true;
  
  # GUI
  programs.google-chrome.enable = true;
}
