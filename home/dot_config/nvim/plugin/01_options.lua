-- Leader -----------------------------------------------------------------
vim.g.mapleader = ' '
--vim.g.maplocalleader = "\\"

-- General ----------------------------------------------------------------
vim.o.mouse = 'a'
vim.o.mousescroll = 'ver:25,hor:6'
vim.o.switchbuf = 'usetab'
vim.o.undofile = true

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

vim.o.backup = false
vim.o.writebackup = false

vim.cmd('filetype plugin indent on')

-- UI ---------------------------------------------------------------------
vim.o.breakindent = true
vim.o.breakindentopt = 'list:-1'
vim.o.colorcolumn = '+1'
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.pumheight = 10
vim.o.ruler = false
vim.o.shortmess = 'CFOSWaco'
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.wrap = false

vim.o.cursorlineopt = 'screenline,number'

vim.o.fillchars = 'eob: ,fold:╌'
vim.o.listchars = 'extends:…,nbsp:␣,precedes:…,tab:> '

vim.o.foldlevel = 1
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.winborder = 'rounded'
vim.o.pummaxwidth = 100
vim.o.completetimeout = 100
vim.o.pumborder = 'rounded'

vim.o.foldlevelstart = 99
vim.g.markdown_folding = 1
vim.o.foldtext = ""

-- Editing ----------------------------------------------------------------
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = 'rqnl1j'
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = 'en,cjk'
vim.o.spelloptions = 'camel'
vim.o.tabstop = 2
vim.o.virtualedit = "block"

vim.o.complete = '.,w,b,kspell'
vim.o.completeopt = 'menu,menuone,noselect,fuzzy,popup'

-- Autocommands ===============================================================
-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local ensure_fo = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
GinVim.create_autocmd('FileType', '*', ensure_fo, "Proper 'formatoptions'")

-- Diagnostics ================================================================
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },

  -- Show all diagnostics as underline (for their meessages type `<Leader>ld`)
  underline = { severity = { min = 'HINT', max = 'ERROR' } },

  -- Show more details immediately only for errors at current line end
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
GinVim.later(function() vim.diagnostic.config(diagnostic_opts) end)

