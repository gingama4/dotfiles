{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "chatgpt"
      "codex"
      "ghostty"
      "google-chrome"
      "raycast"
      "slack"
      "visual-studio-code"
    ];
  };
}
