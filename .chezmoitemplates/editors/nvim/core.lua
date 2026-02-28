-- ==================== Neovim Core ====================
-- This template contains Neovim-specific core configuration.
-- It is loaded after common/core.vim and before plugins.

-- -------------------------------------------------------------------
-- 1. Global options (Neovim-specific)
-- -------------------------------------------------------------------
local opt = vim.opt

opt.termguicolors = true      -- Enable 24-bit true color
opt.mouse = 'a'               -- Enable mouse support

-- (shell and clipboard are already set in common/core via chezmoi template)

-- -------------------------------------------------------------------
-- 2. Auto-install lazy.nvim (with error handling)
-- -------------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.notify('Cloning lazy.nvim...', vim.log.levels.INFO, { title = 'nvim' })
    local clone_success, result = pcall(vim.fn.system, {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
    if not clone_success then
        vim.notify('Failed to clone lazy.nvim: ' .. vim.inspect(result), vim.log.levels.ERROR)
    end
end

-- Prepend lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- NOTE: Plugin setup is now handled in the main entry file (init.lua), not here.
