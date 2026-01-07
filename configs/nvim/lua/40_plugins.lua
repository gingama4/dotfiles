local add = vim.pack.add
local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = GinVim.now_if_args
local keymap = GinVim.keymap.set

-- Tree-sitter
now_if_args(function()
  GinVim.on_pack("nvim-treesitter", { "update" }, vim.cmd.TSUpdate, "Update tree-sitter parsers")
  add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

  -- Ensure installed
  local ensure_languages = {
    "bash",
    "c",
    "cpp",
    "css",
    "blade",
    "diff",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "toml",
    "typescript",
    "yaml",
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, ensure_languages)
  if #to_install > 0 then
    require("nvim-treesitter").install(to_install)
  end

  -- Ensure enabled
  local filetypes = vim.iter(ensure_languages):map(vim.treesitter.language.get_filetypes):flatten():totable()
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"

    -- Only php
    if ev.match == "php" then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()'"
    end
  end
  GinVim.create_autocmd("FileType", filetypes, ts_start, "Ensure enabled tree-sitter")
end)

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

  keymap({ "<leader>ci", require("conform").format, desc = "Format" })
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

-- Markdown
later(function()
  add({ { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" } })
  require("render-markdown").setup({
    completions = { lsp = { enabled = true } },
  })
end)
