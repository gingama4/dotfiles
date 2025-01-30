local phpstan = vim.g.gin_php_phpstan or false

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "blade" } },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "intelephense",
        "blade-formatter",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft.php = {}
      if phpstan then
        table.insert(opts.linters_by_ft.php, "phpstan")
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "pint" },
        blade = { "blade-formatter" },
      },
    },
  },
}
