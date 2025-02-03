{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../modules/home-manager

    ../../../configs/home-manager/cli-utilities
    ../../../configs/home-manager/gh
    ../../../configs/home-manager/git
    ../../../configs/home-manager/lazygit
    ../../../configs/home-manager/nvim
    ../../../configs/home-manager/sheldon
    ../../../configs/home-manager/xdg
    ../../../configs/home-manager/zsh
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
  services.colima.enable = true;
  
  # GUI
  programs.google-chrome.enable = true;
  services.raycast.enable = true;
}
