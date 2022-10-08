local nvimtree = require('nvim-tree')

local configuration = {
  sort_by = "case_sensitive",
  hijack_cursor = true,
  diagnostics = {
    enable = true
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "all",
    indent_markers = {
      enable = true
    }
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
}


local funcs = {}

funcs.setup = function()
  nvimtree.setup(configuration)
end

funcs.setup_keybindings = function()
  vim.keymap.set('n', '<M-TAB>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
end


return funcs
