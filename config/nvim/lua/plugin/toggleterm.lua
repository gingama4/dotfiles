local status, toggleterm = pcall(require, 'toggleterm')
local statusTerminal, toggletermTerminal = pcall(require, 'toggleterm.terminal')

if (not status or not statusTerminal) then return end

toggleterm.setup()

local Terminal = toggletermTerminal.Terminal
local lazygit = Terminal:new({
  cmd = 'lazygit',
  direction = 'float',
  hidden = true,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
