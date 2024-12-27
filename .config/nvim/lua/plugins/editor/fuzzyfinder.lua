local build_cmd ---@type string?
for _, cmd in ipairs({ "make", "gmake" }) do
  if vim.fn.executable(cmd) == 1 then
    build_cmd = cmd
    break
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = {
      'Telescope',
    },
    version = false,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make",
        enabled = build_cmd ~= nil,
      },
    },
    keys = {
      { '<leader>m', ':Telescope marks<cr>',      desc = 'search by [M]arks' },
      { '<C-p>',     ':Telescope find_files<cr>', desc = 'search Files' },
      { '<C-g>',     ':Telescope live_grep<cr>',  desc = 'search Files' },
    },
    opts = function()
      local actions = require 'telescope.actions'

      local function find_command()
        if 1 == vim.fn.executable "rg" then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif 1 == vim.fn.executable "fd" then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable "fdfind" then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable "find" then
          return { "find", ".", "-type", "f" }
        elseif 1 == vim.fn.executable "where" then
          return { "where", "/r", ".", "*" }
        end
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-Down>'] = actions.cycle_history_next,
              ['<C-Up>'] = actions.cycle_history_prev,
              ['<C-f>'] = actions.preview_scrolling_down,
              ['<C-b>'] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    end,
  },
}
