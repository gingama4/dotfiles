{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    go
    gopls
    nodejs
  ];
}
