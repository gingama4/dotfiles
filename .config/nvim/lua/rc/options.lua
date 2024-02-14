local basic_options = {
  -- Tab
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,

  -- Command
  wildmenu = true,
  wildmode = "longest,list,full",

  -- Search
  wrapscan = true,
  ignorecase = true,
  smartcase = true,
  incsearch = true,
  hlsearch = true,

  -- Window
  splitbelow = true,
  splitright = true,

  -- File
  autoread = true,
  swapfile = false,
  hidden = true,
  backup = true,
  backupdir = vim.fn.stdpath("data") .. "/backup/",
  backupskip = "",
  directory = vim.fn.stdpath("data") .. "/swap/",
  updatecount = 100,
  undofile = true,
  undodir = vim.fn.stdpath("data") .. "/undo/",
  clipboard = 'unnamedplus,unnamed,' .. vim.o.clipboard,

  -- Beep
  errorbells = false,
  visualbell = false,

  -- Display
  cursorline = true,
  cursorlineopt = 'number',
  display = 'lastline',
  showmode = false,
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

  -- Status line
  laststatus = 3,
}

for k, v in pairs(basic_options) do
  vim.opt[k] = v
end

-- Create File Dir
vim.fn.mkdir(vim.o.backupdir, "p")
vim.fn.mkdir(vim.o.directory, "p")
vim.fn.mkdir(vim.o.undodir, "p")

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if
  vim.g.colorterm == "truecolor"
  or vim.g.colorterm == "24bit"
  or vim.g.colorterm == "rxvt"
  or vim.g.colorterm == ""
then
  if vim.fn.exists("+termguicolors") then
    vim.o.termguicolors = true
  end
end

