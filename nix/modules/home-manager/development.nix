{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.development;
in
{
  options.development = {
    enable = mkEnableOption "Enable development tools";

    languages = {
      c = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable C lang";
        };
      };

      go = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Go lang";
        };
      };

      javascript = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable JavaScript";
        };
      };

      lua = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Lua";
        };
      };

      nix = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Nix";
        };
      };

      shell = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable Lua";
        };
      };

    };
  };

  config = mkIf cfg.enable {
    home.packages =
      optionals cfg.languages.c.enable ([
        pkgs.gcc
        pkgs.clang-tools
      ])
      ++ optionals cfg.languages.go.enable ([
        pkgs.go
        pkgs.gopls
      ])
      ++ optionals cfg.languages.javascript.enable ([
        pkgs.bun
        pkgs.deno
        pkgs.eslint
        pkgs.nodePackages.typescript-language-server
        pkgs.nodejs
        pkgs.nodePackages.prettier
      ])
      ++ optionals cfg.languages.lua.enable ([
        pkgs.lua-language-server
        pkgs.stylua
      ])
      ++ optionals cfg.languages.nix.enable ([
        pkgs.nil
        pkgs.nixfmt-rfc-style
      ])
      ++ optionals cfg.languages.shell.enable ([
        pkgs.shellcheck
        pkgs.shfmt
      ]);
  };
}
