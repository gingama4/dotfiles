return {
  {
    name = "copilot.lua",
    dir = "@copilot_lua@",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_node_command = "node",
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    name = "CopilotChat.nvim",
    dir = "@copilotchat_nvim@",
    build = "make tiktoken",
    dependencies = {
      { name = "copilot.lua", dir = "@copilot_lua@" },
      { name = "plenary.nvim", dir = "@plenary_nvim@" },
    },
    opts = function()
      local select = require("CopilotChat.select")
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. "",
        answer_header = "  Copilot",
        window = {
          width = 0.4,
        },
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN カーソル上のコードの説明を段落をつけて書いてください。",
          },
          Tests = {
            prompt = "/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。",
          },
          Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。",
          },
          Optimize = {
            prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
          },
          Docs = {
            prompt = "/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、PHPのPHPDocなど）。",
          },
          FixDiagnostic = {
            prompt = "ファイル内の次のような診断上の問題を解決してください：",
            selection = select.diagnostics,
          },
        },
      }
    end,
    keys = {
      {
        "<leader>aa",
        function()
          require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
