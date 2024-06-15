return {
  'nvim-treesitter/nvim-treesitter',
  event = { "BufReadPost", "BufNewFile" },
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  cmd = { "TSUpdateSync" },
  opts = {
    ensure_installed = {
      "bash",
      "go",
      "html",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "javascript",
      "php",
      "phpdoc",
      "php_only",
      "vim",
      "yaml",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    -- Add Blade(Laravel)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }
    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    })
  end
}
