vim.o.encoding = 'utf-8'
vim.o.fileencodings = 'utf-8,euc-jp,iso-2022-jp,sjis'
vim.o.fileformats = 'unix,dos,mac'

local options = {
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  number = true,
  splitbelow = true,
  splitright = false,
  termguicolors = true,
  cursorline = true,
  display = 'lastline',
  showmatch = true,
  matchtime = 1,
  showcmd = true,
  number = true,
  relativenumber = true,
  wrap = true,
  title = false,
  scrolloff = 5,
  sidescrolloff = 5,
  pumheight = 10,
  cursorlineopt = 'number',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

