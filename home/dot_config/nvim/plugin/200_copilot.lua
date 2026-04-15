GinVim.on_event('InsertEnter', function ()
  vim.pack.add({
     "https://github.com/zbirenbaum/copilot.lua",
     "https://github.com/copilotlsp-nvim/copilot-lsp",
  })

  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    nes = {
      enabled = true,
      keymap = {
        accept = "<Tab>"
      },
    },
  })
end)
