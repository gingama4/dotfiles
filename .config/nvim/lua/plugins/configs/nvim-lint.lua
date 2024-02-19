return function()
  local config = require('utils.lint.loader').load()
  require('lint').linters_by_ft = config
  require('lint').try_lint()

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      require('lint').try_lint()
    end,
  })
end
