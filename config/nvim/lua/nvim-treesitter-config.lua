local treesitter_configs = require('nvim-treesitter.configs')

local parsers_to_install = {
  "bash",
  "bibtex",
  "c",
  "c_sharp",
  "cmake",
  "comment",
  "cpp",
  "css",
  "dockerfile",
  "gitignore",
  "go",
  "gomod",
  "gowork",
  "help",
  "html",
  "java",
  "javascript",
  "json",
  "latex",
  "lua",
  "make",
  "markdown",
  "python",
  "regex",
  "scss",
  "sql",
  "typescript",
  "yaml"
}

local configuration = {
  ensure_installed = parsers_to_install,
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr"
      }
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  }
}


local funcs = {}

funcs.setup = function ()
  treesitter_configs.setup(configuration)
end


return funcs
