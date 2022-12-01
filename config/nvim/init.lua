if vim.g.vscode then
  require('vscode.init')
else
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require('rc.base')
  require('plugins')
end

