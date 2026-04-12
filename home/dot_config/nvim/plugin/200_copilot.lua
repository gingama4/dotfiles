vim.pack.add({
  { src = "https://github.com/zbirenbaum/copilot.lua" },
  { src = "https://github.com/copilotlsp-nvim/copilot-lsp" },
})

require("copilot").setup({})
