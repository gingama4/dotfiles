{ config, lib, pkgs, ... }:
let
  repoDir = "${config.home.homeDirectory}/ghq/github.com/gingama4/ginvim.nvim";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim/init.lua".text = ''
    local ginvim_path = "${repoDir}"

    assert(
      vim.uv.fs_stat(ginvim_path),
      "ginvim.nvim is not found: " .. ginvim_path
    )

    vim.opt.runtimepath:prepend(ginvim_path)

    local after_path = vim.fs.joinpath(ginvim_path, "after")
    if vim.uv.fs_stat(after_path) then
      vim.opt.runtimepath:append(after_path)
    end

    require("ginvim").setup()
  '';

  home.activation.cloneGinvim =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -e ${lib.escapeShellArg repoDir} ]; then
        run ${pkgs.coreutils}/bin/mkdir -p \
          ${lib.escapeShellArg (builtins.dirOf repoDir)}

        run ${pkgs.git}/bin/git clone \
          https://github.com/gingama4/ginvim.nvim.git \
          ${lib.escapeShellArg repoDir}
      fi
    '';
}
