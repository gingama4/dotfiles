vim.loader.enable()
vim.uv = vim.uv or vim.loop
vim.tbl_islist = vim.islist

local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

local configpath = "@gingama4_nvim_config_path@"
vim.opt.rtp:prepend(configpath)
vim.g.my_config_path = configpath

require("main")
