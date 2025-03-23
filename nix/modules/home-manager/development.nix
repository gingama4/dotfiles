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
        pkgs.gotools
      ])
      ++ optionals cfg.languages.javascript.enable ([
        pkgs.bun
        pkgs.deno
        pkgs.nodejs
      ])
      ++ optionals cfg.languages.shell.enable ([
        pkgs.shellcheck
        pkgs.shfmt
      ]);
  };
}
