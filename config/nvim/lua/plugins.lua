local fn = vim.fn
local jetpackfile = fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
if fn.filereadable(jetpackfile) == 0 then
  fn.system({'curl', '-fLo', jetpackfile, '--create-dirs', jetpackurl})
end

local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'
vim.opt.runtimepath:append(parser_install_dir)

vim.cmd('packadd vim-jetpack')
require('jetpack.packer').startup(function(use)
  use { 'tani/vim-jetpack', opt = 1 }

  -- =========================
  -- treesitter
  -- =========================
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use {
    'yioneko/nvim-yati',
    after = 'nvim-treesitter'
  }

  -- =========================
  -- LSP
  -- =========================
  use {
    'neovim/nvim-lspconfig',
  }

  use {
    'williamboman/mason.nvim',
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function() require('plugin.lsp') end,
  }

  use {
    'hrsh7th/nvim-cmp'
  }

  use {
    'hrsh7th/cmp-nvim-lsp'
  }

  use {
    'hrsh7th/cmp-buffer'
  }

  use {
    'hrsh7th/cmp-path'
  }

  use {
    'onsails/lspkind.nvim'
  }

  -- =========================
  -- Filer
  -- =========================
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    after = 'nightfox.nvim',
    config = function() require('plugin.nvim-tree') end
  }

  -- =========================
  -- Colorscheme
  -- =========================
  use {
    'EdenEast/nightfox.nvim',
    config = function() require('plugin.nightfox') end
  }
end)

