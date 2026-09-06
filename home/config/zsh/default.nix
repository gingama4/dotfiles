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

    initContent = ''
      ghq-fzf-cd() {
        local repo
        repo=$(ghq list --full-path | fzf --no-multi --prompt='ghq> ') || return 0
        [[ -n "$repo" ]] || return 0
        builtin cd -- "$repo"
        zle reset-prompt
      }
      zle -N ghq-fzf-cd
      bindkey -M emacs '^G' ghq-fzf-cd
      bindkey -M viins '^G' ghq-fzf-cd
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    eza
    fzf
    ghq
    lazygit
  ];
}
