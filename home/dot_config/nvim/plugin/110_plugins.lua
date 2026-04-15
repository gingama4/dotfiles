local add = vim.pack.add
local now, later = GinVim.now, GinVim.later
local keymap = GinVim.keymap.set

-- Mason
later(function()
  add({ "https://github.com/mason-org/mason.nvim" })
  require("mason").setup()
end)

-- vimdoc-ja
later(function()
  add({ "https://github.com/vim-jp/vimdoc-ja" })
  vim.opt.helplang:prepend("ja")
end)

-- Formatting
later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    format_on_save = {
      timeout_ms = 3000,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      php = { "pint" },
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      tsx = { "eslint_d", "prettier" },
      markdown = { "prettier" },
    },
  })

  keymap({ "<leader>ci", require("conform").format, desc = "Format" })
end)

-- Colorscheme
now(function()
  add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })
  vim.cmd("colorscheme catppuccin")
end)

-- File Explorer
later(function()
  add({ { src = "https://github.com/stevearc/oil.nvim", name = "oil" } })
  require("oil").setup()
  keymap({ "<leader>e", "<Cmd>Oil<CR>", desc = "Open Explorer" })
end)

-- Git
later(function()
  add({
    { src = "https://github.com/sindrets/diffview.nvim", name = "diffview.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns.nvim" },
  })

  require("diffview").setup({
    keymaps = {
      view = {
        { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_panel = {
        { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
      file_history_panel = {
        { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
      },
    },
    hooks = {
      view_enter = function()
        vim.o.showtabline = 0
      end,
      view_leave = function()
        vim.o.showtabline = 2
      end,
    },
  })

  local gitsigns = require("gitsigns")
  gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
  })

  -- keymap
  keymap({ "<leader>go", "<Cmd>DiffviewOpen<CR>", desc = "Open Diffview" })
  keymap({ "<leader>gs", gitsigns.stage_hunk, desc = "Stage hunk" })
  keymap({
    "<leader>gs",
    function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end,
    mode = "v",
    desc = "Stage hunk",
  })
  keymap({ "<leader>gS", gitsigns.stage_buffer, desc = "Stage buffer" })
end)

-- Markdown
later(function()
  add({ { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" } })
  require("render-markdown").setup({
    completions = { lsp = { enabled = true } },
  })
end)
