{ pkgs, config, inputs, username, ... }:

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
      "manaflow-ai/homebrew-cmux" = inputs.homebrew-cmux;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    brews = [
      "colima"
      "docker"
      "docker-compose"
    ];

    casks = [
      "cmux"
      "codex"
      "codex-app"
      "ghostty"
      "google-chrome"
      "obsidian"
      "slack"
      "visual-studio-code"
    ];
  };

  fonts = {
    packages = with pkgs; [
      hackgen-nf-font
      udev-gothic-nf
      plemoljp-nf
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

    trackpad = {
      # 3本指ドラッグ
      TrackpadThreeFingerDrag = true;

      # tap-to-dragの無効化
      Dragging = false;
      DragLock = false;

      # 3本指ジェスチャーの無効化
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 0;
    };
  };

  system.primaryUser = username;
  system.stateVersion = 7;
}
