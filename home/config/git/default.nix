{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "gingama4";
        email = "me@gingama4.com";
      };
      core = {
        editor = "nvim";
        ignoreCase = false;
      };
      credential."https://github.com".helper = [ "" "!gh auth git-credential" ];
      fetch.prune = true;
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
