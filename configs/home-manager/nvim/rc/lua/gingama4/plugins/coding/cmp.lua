return {
  name = "blink.cmp",
  dir = "@blink_cmp@",
  build = "nix run .#build-plugin",
  event = "InsertEnter",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      },
    },
    keymap = {
      preset = "enter",
      ["<tab>"] = { "select_next", "fallback" },
      ["<S-tab>"] = { "select_prev", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
      kind_icons = GinVim.config.icons.kinds,
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    cmdline = {
      enabled = false,
    },
  },
  opts_extend = {
    "sources.default",
  },
}
