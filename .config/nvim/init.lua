vim.o.encoding = 'utf-8'
vim.o.fileencodings = 'utf-8,euc-jp,iso-2022-jp,sjis'
vim.o.fileformats = 'unix,dos,mac'

if vim.g.vscode then
  require('vscode')
else
  require('main')
end
