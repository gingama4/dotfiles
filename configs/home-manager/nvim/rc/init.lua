local configpath = "@gingama4_nvim_config_path@"
vim.opt.rtp:prepend(configpath)

require("gingama4").setup()
