{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      save = 512;
    };

    zsh-abbr = {
      enable = true;
      abbreviations = {
        v = "nvim";
        la = "ls -la";
        lg = "lazygit";
      };
    };

    shellAliases = {
      ls = "eza --icons=auto";
    };

    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    eza
    lazygit
  ];
}
