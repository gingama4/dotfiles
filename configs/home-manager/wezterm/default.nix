{
  inputs,
  pkgs,
  ...
}:
{
  programs.wezterm = {
    package =
      if pkgs.stdenv.isDarwin then pkgs.wezterm else inputs.wezterm.packages.${pkgs.system}.default;
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
