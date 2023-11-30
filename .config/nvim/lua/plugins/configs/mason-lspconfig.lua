local loader = require('utils.lsp.loader')

return function(_,_)
  local lspconfig = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')
  local setup = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,
  }

  local configs = loader.load()

  for lsp, config in pairs(configs) do
    setup[lsp] = function ()
      lspconfig[lsp].setup(config)
    end
  end

  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers(setup)
end

