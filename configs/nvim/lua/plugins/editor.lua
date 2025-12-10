local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = GinVim.now_if_args

-- Tree-sitter
now_if_args(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })

  require("nvim-treesitter").setup()

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
  end
  GinVim.create_autocmd("FileType", filetypes, ts_start, "Ensure enabled tree-sitter")
end)

-- Mason
later(function()
  add("mason-org/mason.nvim")
  require("mason").setup()
end)

-- vimdoc-ja
later(function()
  add("vim-jp/vimdoc-ja")
  vim.opt.helplang:prepend("ja")
end)
