{ pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  home.packages = with pkgs; [
    neovim

    ripgrep
    lazygit
  ];

  xdg.configFile = {
    # entry file
    "nvim/init.lua".source = ./init.lua;

    # config files
    "nvim/lua".source = ./lua;
    "nvim/after".source = ./after;

    # option files
    "nvim/lazyvim.json".source = ./lazyvim.json;
  };
}
