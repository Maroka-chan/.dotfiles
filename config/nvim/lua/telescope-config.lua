local telescope_builtin = require('telescope.builtin')


local funcs = {}

funcs.setup_keybindings = function ()
  vim.keymap.set('n', 'ff', telescope_builtin.find_files, {})
  vim.keymap.set('n', 'fg', telescope_builtin.live_grep, {})
  vim.keymap.set('n', 'fb', telescope_builtin.buffers, {})
  vim.keymap.set('n', 'fh', telescope_builtin.help_tags, {})
end


return funcs
