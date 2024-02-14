return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'main',
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "toggle neo-tree", silent = true },
    },
    cmd = "Neotree", dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'MunifTanjim/nui.nvim' },
    },
    init = function() vim.g.neo_tree_remove_legacy_commands = true end,
    opts = function ()
      return {
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        sources = { "filesystem", "buffers", "git_status" },
        source_selector = {
          winbar = true,
          content_layout = "center",
          sources = {
            { source = "filesystem", display_name = "󰉓 File" },
            { source = "buffers", display_name = "󰈙 Bufs" },
            { source = "git_status", display_name = "󰊢 Git" },
            { source = "diagnostics", display_name = "󰒡 Diagnostics" },
          },
        },
        default_component_configs = {
          modified = { symbol = "" },
          diagnostics = {
            symbols = {
              hint = "󰌵",
              info = " ",
              warn = " ",
              error = " ",
            },
          },
          git_status = {
            symbols = {
              added = "",
              deleted = "",
              modified = "",
              renamed = "➜",
              untracked = "★",
              ignored = "◌",
              unstaged = "✗",
              staged = "✓",
              conflict = "",
            },
          },
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = false,
            ["[b"] = "prev_source",
            ["]b"] = "next_source",
          },
        },
        filesystem = {
          follow_current_file = { enabled = true },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
          use_libuv_file_watcher = vim.fn.has "win32" ~= 1,
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end,
          },
        }
      }
    end,
  },
}

