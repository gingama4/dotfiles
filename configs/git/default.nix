{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cacert
    gh
    delta
  ];

  programs.git = {
    enable = true;
    userName = "gingama4";
    userEmail = "gingama4@gmail.com";
    extraConfig = {
      pull.rebase = false;
      init.defaultBranch = "main";
      fetch.prune = true;
      core.ignoreCase = false;
      core.pager = "delta";
      delta = {
        side-by-side = true;
        syntax-theme = "Visual Studio Dark+";
      };
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      "credential \"https://github.com\"" = {
        helper = "gh auth git-credential";
      };
    };
  };
}
