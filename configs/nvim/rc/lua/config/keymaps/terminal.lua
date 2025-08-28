return {
  {
    "<c-/>",
    function()
      Snacks.terminal()
    end,
    desc = "Terminal",
  },
  { "<c-/>", "<cmd>close<cr>", mode = "t", desc = "Hide terminal" },
}
