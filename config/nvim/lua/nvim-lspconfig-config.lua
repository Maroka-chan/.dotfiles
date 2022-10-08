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


-- Language Protocol Servers to Enable
LSP_servers = {
  -- ==== Sumneko Lua ====
  { 'sumneko_lua', settings = sumneko_lua_settings  },
  { 'bashls' },
  { 'csharp_ls' },
  { 'ansiblels' },
  { 'dockerls' },
  { 'gopls' },
  { 'pyright' },
  { 'texlab' }
}


local funcs = {}

funcs.setup = function ()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  for _, lsp in ipairs(LSP_servers) do
    lspconfig[lsp[1]].setup {
      capabilities = capabilities,
      settings = lsp.settings
    }
  end
end

return funcs
