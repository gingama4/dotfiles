vim.keymap.set("n", "gx", function() require("nvim-tree.api").tree.toggle() end)

--require('nvim-tree').setup()

require("nvim-tree").setup({
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_directories = { enable = true, auto_open = true },
  open_on_setup = true,
  open_on_setup_file = true,
  sync_root_with_cwd = true,
  diagnostics = {
    enable = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = { enable = true, update_root = false, ignore_list = {} },
  view = {
    adaptive_size = false,
    mappings = {
      list = {
        { key = { '<2-RightMouse>', '<C-]>' }, action='' },
        { key = '<C-v>', action='' },
        { key = '<C-x>', action='' },
        { key = '<C-t>', action='' },
        { key = '<BS>', action='' },
        { key = '<Tab>', action='' },
        { key = 'D', action='' },
        { key = '[e', action='' },
        { key = ']e', action='' },
        { key = '[c', action='' },
        { key = ']c', action='' },
        { key = '-', action='' },
        { key = 's', action='' },
        { key = 'W', action='' },
        { key = 'g?', action='' },
        { key = 'bmv', action='' },
        { key = 'o', action='' },
        { key = '<2-LeftMouse>', action='' },
        { key = 'K', action='' },
        { key = '<C-r>', action='' },
        { key = 'J', action='' },
        { key = '>', action='' },
        { key = '<', action='' },
        { key = '<C-e>', action='' },

        { key = 's', action='vsplit' },
        { key = "'", action='close_node' },
        { key = '"', action='collapse_all' },
        { key = '?', action='toggle_help' },
      },
    },
  },
  renderer = {
    full_name = true,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "all",
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "signcolumn",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "!",
          staged = "+",
          unmerged = "=",
          renamed = "»",
          untracked = "?",
          deleted = "✘",
        },
      },
    },
  },
})
