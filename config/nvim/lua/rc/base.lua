vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require 'utils'
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

o.termguicolors = true

opt('encoding', 'utf-8')
opt('fileencodings', 'utf-8,euc-jp,iso-2022-jp,sjis')
opt('fileformats', 'unix,dos,mac')

opt('expandtab', true, buffer)
opt('tabstop', 2, buffer)
opt('shiftwidth', 2, buffer)

opt('number', true)

cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
