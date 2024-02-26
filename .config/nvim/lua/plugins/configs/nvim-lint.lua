return function()
  local config = require('utils.lint.loader').load()
  require('lint').linters_by_ft = config
  require('lint').try_lint()

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      require('lint').try_lint()
    end,
  })

  vim.api.nvim_create_user_command("LinterInfo", function()
    local linters = require('lint').get_running()
    if #linters == 0 then
      vim.notify('Not running linters.', vim.log.levels.INFO, { title = "nvim-lint" })
      return
    end
    local runningLinters = table.concat(linters, "\n")
    vim.notify(runningLinters, vim.log.levels.INFO, { title = "nvim-lint" })
  end, {})
end
