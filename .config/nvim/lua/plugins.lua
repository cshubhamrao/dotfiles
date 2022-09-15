-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
  use 'nvim-treesitter/nvim-treesitter-context'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'nvim-treesitter/nvim-treesitter'
--  use {'neoclide/coc.nvim', branch = 'release'}
end)

