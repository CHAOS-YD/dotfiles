-- ==================== Neovim Plugin List ====================
-- This template contains the list of Neovim plugins for lazy.nvim.
-- It is used by both Unix and Windows Neovim configurations.

{
  'tpope/vim-sensible',
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({})
    end,
  },
  -- Add more Neovim plugins here...
}
