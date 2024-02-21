return {
  'L3MON4D3/LuaSnip',
  event = { 'BufReadPre' },
  build = "make install_jsregexp",
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = require 'plugins.configs.luasnip',
}
