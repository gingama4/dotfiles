-- Leader -----------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General ----------------------------------------------------------------
vim.o.backup = false
vim.o.mouse = "a"
vim.o.switchbuf = "usetab"
vim.o.writebackup = false
vim.o.undofile = true

vim.cmd("filetype plugin indent on")

-- UI ---------------------------------------------------------------------
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.laststatus = 2
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.pumblend = 10
vim.o.pumheight = 10
vim.o.ruler = false
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.winblend = 10
vim.o.wrap = false

vim.o.fillchars = table.concat({ "foldopen:", "foldclose:", "fold:╌", "foldsep: ", "diff:╱", "eob: " }, ",")

if vim.fn.has("nvim-0.9") == 1 then
  vim.opt.shortmess:append("C")
  vim.o.splitkeep = "screen"
end

-- Editing ----------------------------------------------------------------
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.virtualedit = "block"

vim.opt.clipboard:append("unnamedplus,unnamed")

-- Spelling ---------------------------------------------------------------
vim.o.spelllang = "en"
vim.o.spelloptions = "camel"

-- Folds ------------------------------------------------------------------
vim.o.foldmethod = "indent"
vim.o.foldlevel = 1
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 10
vim.g.markdown_folding = 1
vim.o.foldtext = ""
