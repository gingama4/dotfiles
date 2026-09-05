{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "chatgpt"
      "ghostty"
      "google-chrome"
      "slack"
      "visual-studio-code"
    ];
  };
}
