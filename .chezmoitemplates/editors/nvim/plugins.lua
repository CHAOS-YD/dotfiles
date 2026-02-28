-- ==================== Neovim Plugin List ====================
{
  'tpope/vim-sensible',
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      -- Image preview handled by snacks.nvim (listed separately)
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require('neo-tree').setup({
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        clipboard = {
          enable = true,
          sync = "universal",
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
          },
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = { 'node_modules', '.git' },
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          use_libuv_file_watcher = true,
        },
        window = {
          position = 'left',
          width = 30,
          mappings = {
            -- Navigation (unified with NERDTree: l open, h up)
            ['l'] = 'open',
            ['h'] = 'navigate_up',
            ['<CR>'] = 'open',

            -- File operations (full action names to avoid warnings)
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['a'] = 'add',
            ['y'] = 'copy',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['R'] = 'refresh',
            ['q'] = 'close_window',

            -- Split mappings
            ['s'] = 'open_split',
            ['v'] = 'open_vsplit',
            ['t'] = 'open_tabnew',

            -- Toggle preview mode with floating window and image support
            ['P'] = {
              "toggle_preview",
              config = {
                use_float = true,                -- Use floating window for previews
                title = "Preview",                -- Optional preview window title
                -- Enable snacks.nvim for image preview
                use_snacks_image = true,          -- Use snacks.nvim for images, PDF, etc.
                -- Text preview settings
                wrap = true,
                line_numbers = true,
                syntax_highlighting = true,
              },
            },
          },
        },
      })

      -- External global mappings
      vim.keymap.set('n', '<Leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<Leader>f', ':Neotree reveal<CR>', { noremap = true, silent = true })

      -- <Leader>q in Neo-tree window closes the tree directly
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = function()
          vim.keymap.set('n', '<Leader>q', ':Neotree close<CR>', { buffer = true, noremap = true, silent = true })
        end,
      })
    end,
  },
  -- Smart number switching
  {
    "cpea2506/relative-toggle.nvim",
    config = function()
      require("relative-toggle").setup({
        pattern = "*",
        events = {
          on  = { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
          off = { "BufLeave", "FocusLost",   "InsertEnter", "WinLeave", "CmdlineEnter" },
        },
      })
    end,
  },
  -- Snacks.nvim: modern toolkit providing image preview (and many other features)
  {
    "folke/snacks.nvim",
    priority = 1000,  -- Load early to ensure availability for other plugins
    lazy = false,
    opts = {
      image = {},  -- Enable image preview module
      -- You can add other snacks modules here as needed
    },
  },
  -- Smart quit/buffer deletion (global <Leader>q mapped to :Sayonara)
  {
    "mhinz/vim-sayonara",
    lazy = false,
    config = function()
      -- vim-sayonara automatically maps <Leader>q to :Sayonara.
      -- Customize if needed:
      -- vim.keymap.set('n', '<Leader>q', ':Sayonara<CR>', { noremap = true, silent = true })
    end,
  },
}
