local packer = require('packer')

-- Recompile if plugins.lua has changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


packer.startup(function(use)
  -- Let Packer manage itself
  use 'wbthomason/packer.nvim'

  -- Helper Functions
  use 'nvim-lua/plenary.nvim'

  -- Theme & Icons
  use { 'folke/tokyonight.nvim',
        branch = 'main',
        config = function() require('tokyonight-config').setup() end
      }

  -- File Tree
  use { 'kyazdani42/nvim-tree.lua',
        config = function()
          local config = require('nvim-tree-config')
          config.setup()
          config.setup_keybindings()
        end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }

  -- Status Line
  use { 'nvim-lualine/lualine.nvim',
        config = function() require('nvim-lualine-config').setup() end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }

  -- KNAP - Auto Refresh Preview for LaTeX, Markdown, HTML etc.
  use { 'frabjous/knap',
        config = function()
          local config = require('knap-config')
          config.setup()
          config.setup_keybindings()
        end
      }

  -- LSP - Language Server Protocol
  use { 'neovim/nvim-lspconfig',
        config = function () require('nvim-lspconfig-config').setup() end,
        requires = { 'hrsh7th/cmp-nvim-lsp' }
      }

  -- Code Snippets
  use 'rafamadriz/friendly-snippets'
  use { 'L3MON4D3/LuaSnip', tag = "v1.*",
        config = function ()
          require('luasnip.loaders.from_vscode').lazy_load()
        end
      }

  -- Code Completion
  use { 'hrsh7th/nvim-cmp',
        config = function() require('nvim-cmp-config').setup() end,
        requires = {
          { 'hrsh7th/cmp-path' },
          { 'hrsh7th/cmp-buffer' },
          { 'hrsh7th/cmp-cmdline' },
          { 'L3MON4D3/LuaSnip', tag = "v<CurrentMajor>.*" },
          { 'saadparwaiz1/cmp_luasnip' },
          { 'lukas-reineke/cmp-rg' }
        }
      }

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter',
        config = function () require('nvim-treesitter-config').setup() end,
        run = ':TSUpdate',
        requires = {
          { 'nvim-treesitter/nvim-treesitter-context',
            config = function () require('nvim-treesitter-context-config').setup() end
          },
          { 'nvim-treesitter/nvim-treesitter-refactor' }
        }
      }

  -- Fuzzy Finder
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
        config = function () require('telescope-config').setup_keybindings() end,
        requires = {
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        }
      }

  -- Effects
  use {
    "folke/twilight.nvim",
    config = function() require("twilight-config").setup() end
  }

end)
