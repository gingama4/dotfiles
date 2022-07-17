vim.cmd([[
hi link NeoTreeDirectoryName Directory
hi link NeoTreeDirectoryIcon NeoTreeDirecotyName
]])

require('neo-tree').setup({
  close_if_last_window = false,
  popup_border_style = 'rounded',
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      highlight = 'NeoTreeIndentMarker',
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      highlight = 'NeoTreeDimText',
    },
  },
  event_handlers = {
    {
      event = 'file_opened',
      handler = function(file_path)
        require('neo-tree').close_all()
      end,
    },
    {
      event = 'file_added',
      handler = function(file_path)
        require('neo-tree.utils').open_file({}, file_path)
      end,
    },
  },
})

vim.keymap.set('n', 'gx', '<Cmd>NeoTreeRevealToggle<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', 'G', '<Cmd>NeoTreeFloatToggle git_status<CR>', { noremap = true, silent = true })
