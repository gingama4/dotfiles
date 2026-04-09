vim.api.nvim_create_user_command("GinPackUpdate", function()
  vim.pack.update()
end, { desc = "Update Packages" })

-- Add diff to commit message
GinVim.create_autocmd("FileType", "gitcommit", function(args)
  vim.schedule(function()
    GinVim.git.attach(args.buf)
  end)
end, "Add Git Diff to Commit Message")
