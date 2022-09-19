vim.keymap.set("n", "gx", function() require("nvim-tree.api").tree.toggle() end)

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  hijack_directories = { enable = true, auto_open = true },
  diagnostics = {
    enable = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  update_focused_file = { enable = true, update_root = false, ignore_list = {} },
  system_open = { cmd = nil, args = {} },
  filters = { dotfiles = false, custom = {} },
  view = {
    adaptive_size = false,
    centralize_selection = false,
    hide_root_folder = false,
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "name",
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "signcolumn",
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
