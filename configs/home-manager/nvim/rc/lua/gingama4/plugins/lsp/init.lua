return {
  {
    name = "nvim-lspconfig",
    dir = "@nvim_lspconfig@",
    event = "LazyFile",
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua
      lspconfig.lua_ls.setup({})

      -- Global config
      local icons = GinVim.config.icons
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = function(diagnostics)
            for d, icon in pairs(icons.diagnostics) do
              if diagnostics.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
            return "●"
          end,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
          },
        },
      })
    end,
  },
}
