local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- LSP
later(function()
  add('neovim/nvim-lspconfig')
  vim.lsp.enable({
    'copilot',
    'lua_ls',
    'intelephense',
    'vtsls',
  })
end)

-- Formatting
later(function()
  add('stevearc/conform.nvim')
  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      php = { 'pint' },
    },
  })
end)

-- Completion
later(function()
  add({
    source = 'https://github.com/saghen/blink.cmp',
    checkout = 'v1.7.0',
  })
  require('blink.cmp').setup({
    keymap = {
      preset = 'super-tab',
      ["<CR>"] = { 'accept', 'fallback' },
    },
    completion = {
      menu = { border = 'single' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'single' }
      },
    },
    signature = { window = { border = 'single' } },
  })
end)
