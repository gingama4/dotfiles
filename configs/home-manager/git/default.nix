{
  programs.git = {
    enable = true;
    userName = "gingama4";
    userEmail = "gingama4@gmail.com";
    extraConfig = {
      pull.rebase = false;
      init.defaultBranch = "main";
      fetch.prune = true;
      core.ignoreCase = false;
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
    };
    delta.enable = true;
  };
}
