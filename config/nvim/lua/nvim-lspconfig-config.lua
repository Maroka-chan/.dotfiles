local lspconfig = require('lspconfig')

-- Language Protocol Server Settings
local sumneko_lua_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}


-- Language Server Protocols to Enable
local LSP_servers = {
  -- ==== Sumneko Lua ====
  { 'sumneko_lua', settings = sumneko_lua_settings  },
  { 'bashls' },
  { 'csharp_ls' },
  { 'ansiblels' },
  { 'dockerls' },
  { 'gopls' },
  { 'pyright' },
  { 'texlab' },
  { 'clangd' }
}


local funcs = {}

funcs.setup = function ()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- For nvim-ufo
  capabilities.textDocument.FoldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  for _, lsp in ipairs(LSP_servers) do
    local conf = {
      capabilities = capabilities
    }

    if lsp.settings ~= nil then
      conf.settings = lsp.settings
    end

    lspconfig[lsp[1]].setup(conf)
  end
end

return funcs
