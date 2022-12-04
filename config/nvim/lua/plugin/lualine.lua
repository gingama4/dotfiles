local status, lualine = pcall(require, 'lualine')

if (not status) then return end

vim.opt.laststatus = 3
lualine.setup({
  options = {
    globalstatus = true,
  }
})
