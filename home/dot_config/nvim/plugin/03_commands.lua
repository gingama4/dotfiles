local function delPack()
  local unused = vim.iter(vim.pack.get(nil, { info = false }))
    :filter(function(plugin)
      return not plugin.active
    end)
    :map(function(plugin)
      return plugin.spec.name
    end)
    :totable()

  if #unused > 0 then
    vim.pack.del(unused)
  end
end

vim.api.nvim_create_user_command("GinPackUpdate", function()
  delPack()
  vim.pack.update()
end, { desc = "Update Packages" })

vim.api.nvim_create_user_command("GinPackSync", function()
  delPack()
  vim.pack.update(nil, { target = 'lockfile' })
end, { desc = "Sync Packages" })

-- Add diff to commit message
GinVim.create_autocmd("FileType", "gitcommit", function(args)
  vim.schedule(function()
    GinVim.git.attach(args.buf)
  end)
end, "Add Git Diff to Commit Message")
