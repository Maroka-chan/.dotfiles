local knap = require('knap')

local pdflatex_flags = "-synctex=1 -halt-on-error -interaction=batchmode"
local pdflatex_default = "pdflatex " .. pdflatex_flags .. " %docroot%"
local pdflatex_shell_escape = "pdflatex " .. pdflatex_flags .. " -shell-escape" .. " %docroot%"

local gknapsettings = {
    texoutputext = "pdf",
    textopdf = pdflatex_default,
    textopdfviewerlaunch = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%"
}


local shell_escape_enabled = false

local toggle_shell_escape = function()
  if shell_escape_enabled then
    gknapsettings.textopdf = pdflatex_default
    print("-shell-escape disabled")
  else
    gknapsettings.textopdf = pdflatex_shell_escape
    print("-shell-escape enabled")
  end

  local bsettings = vim.b.knap_settings or {}
  bsettings = vim.tbl_extend("keep", gknapsettings, bsettings)
  vim.b.knap_settings = bsettings
  shell_escape_enabled = not shell_escape_enabled
end


local funcs = {}

funcs.setup = function()
  vim.g.knap_settings = gknapsettings
end

funcs.setup_keybindings = function()
  -- set shorter name for keymap function
  local kmap = vim.keymap.set

  -- F12 toggles wether the -shell-escape flag is used
  kmap('n','<F12>', function() toggle_shell_escape() end, { noremap = true })

  -- F5 processes the document once, and refreshes the view
  kmap('n','<F5>', function() knap.process_once() end, { noremap = true })

  -- F6 closes the viewer application, and allows settings to be reset
  kmap('n','<F6>', function() knap.close_viewer() end, { noremap = true })

  -- F7 toggles the auto-processing on and off
  kmap('n','<F7>', function() knap.toggle_autopreviewing() end, { noremap = true })

  -- F8 invokes a SyncTeX forward search, or similar, where appropriate
  kmap('n','<F8>', function() knap.forward_jump() end, { noremap = true })
end


return funcs
