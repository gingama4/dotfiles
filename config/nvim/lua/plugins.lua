local packer = nil
local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  use 'wbthomason/packer.nvim'

  local colorscheme = 'iceberg.vim'
  use { 'cocopon/iceberg.vim', config = function() require('plug.iceberg') end }

  use {
    'nvim-lualine/lualine.nvim',
    after = colorshceme,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plug.lualine') end,
  }

end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
