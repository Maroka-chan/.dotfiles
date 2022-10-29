local luasnip = require('luasnip')
local types   = require('luasnip.util.types')

local funcs = {}


funcs.setup = function()
  luasnip.setup({
    delete_check_events = 'TextChanged',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = {{"●", "GruvboxOrange"}}
        }
      },
      [types.insertNode] = {
        active = {
          virt_text = {{"●", "GruvboxBlue"}}
        }
      }
    }
  })

  require('luasnip.loaders.from_vscode').lazy_load()
end


return funcs
