{ pkgs, config, lib, ...}:
{
  home.packages = with pkgs; [
    sheldon
    bat
    eza
    fzf
    ripgrep
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    autocd = true;
    enableCompletion = true;

    envExtra = ''
      # path env
      if [[ -z "$ZSH_PATH_LOADED" ]]; then
        source "''${HOME}/.config/zsh/path.zsh"
        export ZSH_PATH_LOADED=1
      fi
    '';

    initContent = lib.mkBefore ''
      # source command override
      function source {
        ensure_zcompiled "''$1"
        builtin source "''$1"
      }

      function ensure_zcompiled {
        local target_dir="''$HOME/.config/zsh"
        local compiled="''$1.zwc"

        if [[ "''$1" == "''$target_dir/"* ]]; then
          if [[ ! -r "''$compiled" || "''$1" -nt "''$compiled" ]]; then
            echo "\033[1;36mCompiling\033[m ''$1"
            zcompile "''$1" "''$compiled"
          fi
        fi
      }

      ensure_zcompiled "''${ZDOTDIR}/.zshrc"

      # sheldon cache
      sheldon_cache="''${SHELDON_CONFIG_DIR}/sheldon.zsh"
      sheldon_toml="''${SHELDON_CONFIG_DIR}/plugins.toml"
      if [[ ! -r "''$sheldon_cache" || "''$sheldon_toml" -nt "''$sheldon_cache" ]]; then
        sheldon lock --update
        sheldon source > "$sheldon_cache"
      fi
      source "''$sheldon_cache"
      unset sheldon_cache sheldon_toml

      source "''${ZDOTDIR}/base.zsh"

      zsh-defer unfunction source
    '';

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 50000;
      save = 50000;
      ignoreAllDups = true;
      ignoreSpace = true;
      ignoreDups = true;
      share = true;
      extended = true;
    };

    shellAliases =
      {
        ls = "eza --icons";
        gd = "ghq list --full-path | cd";
      };
  };

  xdg.configFile = {
    "zsh/base.zsh" = {
      source = ./base.zsh;
      onChange = "rm -rf $HOME/.config/zsh/base.zsh.zwc";
    };

    "zsh/path.zsh" = {
      source = ./path.zsh;
      onChange = "rm -rf $HOME/.config/zsh/path.zsh.zwc";
    };

    "zsh/sheldon/plugins.toml" = {
      source = ./sheldon/plugins.toml;
      onChange = "rm -rf $HOME/.config/zsh/sheldon/sheldon.zs*";
    };

    "zsh/abbreviations".source = ./abbreviations;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };
}
