{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    plugins = import ./plugins.nix { inherit pkgs; };
    extraPackages = import ./tools.nix { inherit pkgs; };
  };

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
