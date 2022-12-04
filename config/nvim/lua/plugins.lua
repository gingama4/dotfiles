local fn = vim.fn
local jetpackfile = fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = 'https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
if fn.filereadable(jetpackfile) == 0 then
  fn.system({'curl', '-fLo', jetpackfile, '--create-dirs', jetpackurl})
end

local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'
vim.opt.runtimepath:append(parser_install_dir)

vim.cmd [[packadd vim-jetpack]]
require('jetpack.packer').startup(function(use)
  use { 'tani/vim-jetpack', opt = 1 }

  local colorscheme = 'nightfox.nvim'

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
    'onsails/lspkind.nvim'
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function() require('plugin.cmp') end,
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
    'hrsh7th/vim-vsnip'
  }

  use {
    'hrsh7th/cmp-vsnip'
  }

  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      local saga = require('lspsaga')
      saga.init_lsp_saga({})
    end,
  }

  use {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup{} end,
  }

  -- =========================
  -- Filer
  -- =========================
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    after = colorscheme,
    config = function() require('plugin.nvim-tree') end
  }

  -- =========================
  -- Colorscheme
  -- =========================
  use {
    'EdenEast/nightfox.nvim',
    config = function() require('plugin.nightfox') end
  }

  -- =========================
  -- Statusline
  -- =========================
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    after = colorscheme,
    config = function() require('plugin.lualine') end
  }

  use {
    'akinsho/bufferline.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('plugin.bufferline') end
  }

  -- =========================
  -- Other
  -- =========================
  use {
    'akinsho/toggleterm.nvim',
    config = function() require('plugin.toggleterm') end,
  }

end)

