return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Development
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8'
  }
  use { 'mbbill/undotree' }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    }
  }
end)
