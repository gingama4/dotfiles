local default_opts = {
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
    }
  }
}

return function(_, opts)
  local utils = require 'utils'
  local merge_opts = utils.extend_tbl(default_opts, opts)

  local neo_tree = require('neo-tree')
  neo_tree.setup(merge_opts)
end

