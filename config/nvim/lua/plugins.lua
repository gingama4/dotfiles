local packer = nil

local nocode = function()
  return not vim.g.vscode
end

local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  use 'wbthomason/packer.nvim'

  --=============================================================
  -- Library
  --=============================================================
  use { 'nvim-lua/popup.nvim', module = "popup" }
  use 'nvim-lua/plenary.nvim'
  use { 'MunifTanjim/nui.nvim', module = 'nui' }
  use { 'rcarriga/nvim-notify', module = 'notify' }

  --=============================================================
  -- Appearance
  --=============================================================

  -- --------------------------
  -- Colorscheme
  -- --------------------------
  local colorscheme = 'nightfox.nvim'
  use { 'EdenEast/nightfox.nvim', config = function() require('plug.nightfox') end }

  -- --------------------------
  -- Font
  -- --------------------------
  use { 'kyazdani42/nvim-web-devicons', after = colorscheme }

  -- --------------------------
  -- Statusline
  -- --------------------------
  use {
    'nvim-lualine/lualine.nvim',
    after = colorscheme,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plug.lualine') end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    after = colorscheme,
    run = ':TSUpdate',
  }

  use {
    'SmiteshP/nvim-gps',
    requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
    after = 'nvim-treesitter',
    config = function() require('nvim-gps').setup() end,
  }

  -- --------------------------
  -- Bufferline
  -- --------------------------
  use {
    'akinsho/bufferline.nvim',
    cond = nocode,
    after = colorscheme,
  }

  --=============================================================
  -- LSP
  --=============================================================
  
  if nocode() then

    -- --------------------------
    -- Language Server Protocol
    -- --------------------------
    use { 'neovim/nvim-lspconfig', config = function() require('plug.nvim-lspconfig') end }
    use {
      'williamboman/nvim-lsp-installer',
      after = { 'nvim-lspconfig', 'cmp-nvim-lsp'  },
      config = function() require('plug.nvim-lsp-installer') end,
    }

    -- --------------------------
    -- Auto Complete
    -- --------------------------
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'L3MON4D3/LuaSnip', event = "VimEnter" },
        { 'windwp/nvim-autopairs', event = "VimEnter" },
      },
      after = { 'LuaSnip', 'nvim-autopairs' },
      config = function() require('plug.nvim-cmp') end,
    }
    use { 'onsails/lspkind-nvim', module = 'lspkind', config = function() require('plug.lspkind-nvim') end }
    use { 'hrsh7th/cmp-nvim-lsp', module = 'cmp_nvim_lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }

    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }

    use { 'hrsh7th/cmp-omni', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' }
    use { 'f3fora/cmp-spell', after = 'nvim-cmp' }
    use { 'ray-x/cmp-treesitter', after = 'nvim-cmp' }

    use { 'L3MON4D3/LuaSnip', config = function() end }

    -- --------------------------
    -- LSP UI
    -- --------------------------
    use { 'tami5/lspsaga.nvim', after = 'nvim-lsp-installer', config = function() require('plug.lspsaga') end }
  
  end

  --=============================================================
  -- Telescope
  --=============================================================
  use { 'nvim-telescope/telescope.nvim', after = colorscheme }

  --=============================================================
  -- File System
  --=============================================================
  use {
    'nvim-neo-tree/neo-tree.nvim',
    cond = nocode,
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('plug.neo-tree')
    end,
  }

  --=============================================================
  -- Other
  --=============================================================
  use { 'windwp/nvim-autopairs', config = function() require('plug.nvim-autopairs') end }
  use { 'esensar/nvim-dev-container', requires = { 'nvim-treesitter/nvim-treesitter' }, config = function() require('devcontainer').setup{} end }

end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
