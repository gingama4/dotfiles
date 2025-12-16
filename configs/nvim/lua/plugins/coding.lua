local add = vim.pack.add
local now, later = MiniDeps.now, MiniDeps.later

-- LSP
later(function()
  add({ "https://github.com/neovim/nvim-lspconfig" })
  vim.lsp.enable({
    "copilot",
    "lua_ls",
    "intelephense",
    "vtsls",
  })
end)

-- Formatting
later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    format_on_save = {
      timeout_ms = 3000,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      php = { "pint" },
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
    },
  })

  GinVim.keymap.set({ "<leader>ci", require("conform").format, desc = "Format" })
end)

-- Completion
later(function()
  add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1.7.0" },
  })
  require("blink.cmp").setup({
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      menu = { border = "single" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = "single" },
      },
    },
    signature = { window = { border = "single" } },
  })
end)
