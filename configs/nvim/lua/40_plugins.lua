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
      markdown = { "prettier" },
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
      ["<Tab>"] = {
        "snippet_forward",
        function()
          return require("sidekick").nes_jump_or_apply()
        end,
        function()
          return vim.lsp.inline_completion.get()
        end,
        "fallback",
      },
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
    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      per_filetype = {
        markdown = { "snippets", "lsp", "path" },
      },
    },
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

-- AI
later(function()
  add({ { src = "https://github.com/folke/sidekick.nvim", name = "sidekick.nvim" } })
  require("sidekick").setup({
    cli = {
      mux = {
        enabled = true,
      },
    },
    nes = {
      enabled = true,
    },
  })

  keymap({
    "<Tab>",
    function()
      if not require("sidekick").nes_jump_or_apply() then
        return "<Tab>"
      end
    end,
    desc = "Goto/Apply Next Edit Suggestion",
  })
  keymap({
    "<leader>aa",
    function()
      require("sidekick.cli").toggle({ name = "copilot" })
    end,
    desc = "Toglle Sidekick CLI",
  })
end)

later(function()
  add({
    { src = "https://github.com/Copilot-C-Nvim/CopilotChat.nvim", name = "CopilotChat.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" },
  })

  local default = require("CopilotChat.config.prompts")
  require("CopilotChat").setup({
    prompts = vim.tbl_deep_extend("force", default, {
      COPILOT_BASE = { system_prompt = GinVim.copilot.prompt },
    }),
    language = "Japanese",
  })

  keymap({
    "<leader>ac",
    function()
      require("CopilotChat").toggle()
    end,
    desc = "Open Copilot Chat",
  })
  keymap({
    "<leader>as",
    function()
      require("CopilotChat").save()
    end,
    desc = "Save Chat",
  })
end)
