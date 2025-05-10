return {
  {
    name = "gitsigns.nvim",
    dir = "@gitsigns_nvim@",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },
  {
    name = "git-blame.nvim",
    dir = "@git_blame_nvim@",
    event = "LazyFile",
    opts = {
      enabled = true,
      message_template = " <author>, <date> : <summary>",
      date_format = "%Y-%m-%d %H:%M:%S",
      virtual_text_column = 1,
    },
  },
}
