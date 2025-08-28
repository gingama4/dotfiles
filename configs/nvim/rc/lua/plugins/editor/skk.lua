return {
  name = "skkeleton",
  dir = "@skkeleton@",
  event = "InsertEnter",
  dependencies = {
    { name = "denops.vim", dir = "@denops_vim@" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "skkeleton-initialize-pre",
      callback = function()
        vim.fn["skkeleton#config"]({
          globalDictionaries = {
            vim.fn.expand("~/.skk/SKK-JISYO.L"),
          },
          eggLikeNewline = true,
          keepState = true,
        })
      end,
      group = vim.api.nvim_create_augroup("skkeletonInitPre", { clear = true }),
    })
  end,
  config = function()
    vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
    vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)")
  end,
}
