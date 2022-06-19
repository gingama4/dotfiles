vim.opt.termguicolors = true

require('bufferline').setup {
  options = {
    numbers = function(opts)
      return string.format("%s.%s", opts.ordinal, opts.lower(opts.id))
    end,
  },
}
