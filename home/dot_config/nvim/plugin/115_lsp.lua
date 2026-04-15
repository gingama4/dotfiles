local add = vim.pack.add
local later = GinVim.later

later(function ()
  add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/copilotlsp-nvim/copilot-lsp",
  })
  vim.lsp.enable({
    "copilot_ls",
    "lua_ls",
    "intelephense",
    "vtsls",
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
  })
end)
