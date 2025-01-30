{
  services.nix-daemon.enable = true;

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = 8;
      accept-flake-config = true;
      trusted-users = [
        "root"
        "@admin"
      ];
      warn-dirty = false;
    };
  };
}
