{ config, inputs, username, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.enable = false;

  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = username;
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };

    brews = [
      "colima"
      "docker"
      "docker-compose"
    ];

    casks = [
      "codex"
      "ghostty"
      "google-chrome"
      "obsidian"
      "slack"
      "visual-studio-code"
    ];
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };

    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
  };

  system.primaryUser = username;
  system.stateVersion = 5;
}
