local options = {
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  number = true,
  splitbelow = true,
  splitright = false,
  termguicolors = true,
  cursorline = true,
  cursorlineopt = 'number',
  display = 'lastline',
  showmatch = true,
  matchtime = 1,
  showcmd = true,
  title = false,
  laststatus = 3,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
