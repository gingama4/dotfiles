{
  inputs,
  pkgs,
  ...
}:
{
  programs.wezterm = {
    package = inputs.wezterm.packages.${pkgs.system}.default;
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
