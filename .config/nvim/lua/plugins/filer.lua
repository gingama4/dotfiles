return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'main',
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "toggle neo-tree", silent = true },
    },
    cmd = "Neotree",
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'MunifTanjim/nui.nvim' },
    },
    init = function() vim.g.neo_tree_remove_legacy_commands = true end,
    opts = function ()
      return {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          }
        },
      }
    end,
  },
}

