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
      "slack"
      "visual-studio-code"
    ];
  };
}
