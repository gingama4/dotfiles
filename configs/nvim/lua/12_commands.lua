vim.api.nvim_create_user_command("GinPackUpdate", function()
  vim.pack.update()
end, { desc = "Update Packages" })
