{
  imports = [
    ../../modules/home-manager

    ../../../configs/cli-utilities
    ../../../configs/git
    ../../../configs/lazygit
    ../../../configs/nvim
    ../../../configs/sheldon
    ../../../configs/xdg
    ../../../configs/zsh
  ];

  development.enable = true;

  programs.home-manager.enable = true;

  # Development
  programs.git.enable = true;
}
