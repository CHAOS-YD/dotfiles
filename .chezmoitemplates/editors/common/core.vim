" ==================== Universal Vim/Neovim Core ====================
" This template is included by all Vim/Neovim config files.
" It contains basic settings, editor-specific features, and cross‑platform directories.
" This file is designed to be independent of configuration management systems.

" -------------------- Basic Settings (compatible with both) --------------------
set nocompatible
filetype plugin indent on
syntax on
if has('termguicolors')
  if exists('$COLORTERM') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
    set termguicolors
  elseif has('nvim')
    " Neovim generally handles terminal capability detection well.
    set termguicolors
  endif
endif
set hlsearch incsearch
set ignorecase smartcase
set tabstop=4 shiftwidth=4
set expandtab autoindent
set showcmd wildmenu
set ruler cursorline

" Leader key set to space (common shortcut prefix).
let mapleader = " "

" -------------------- Smart Number Mode (dynamic line numbers) --------------------
" Relative numbers in normal mode, absolute in insert mode.
set number                  " Enable line numbers
augroup smartnumber
  autocmd!
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" -------------------- Editor-Specific Features --------------------
if has('nvim')
  set inccommand=nosplit        " Neovim: live preview of substitute command.
else
  set ttymouse=sgr              " Vim: terminal mouse support (prevents escape sequence issues).
endif

" -------------------- Platform-Specific Shell & Clipboard --------------------
" Use Vim's has() function for runtime detection.
if has('win32')
  " Windows: use cmd.exe for maximum compatibility with vim-plug.
  set shell=cmd.exe
  set shellcmdflag=/c
  set shellredir=>%s\ 2>&1
  set shellpipe=>%s\ 2>&1
  set shellquote= shellxquote=
  set clipboard=unnamed          " Use Windows clipboard directly.
else
  " Unix-like: chezmoi detects if we are in WSL during template rendering.
  {{- if eq .chezmoi.os "linux" }}
    {{- $kernel := output "uname" "-r" | trim }}
    {{- if or (contains $kernel "WSL") (contains $kernel "microsoft") }}
      {{ template "editors/env/wsl.vim" . }}
    {{- else }}
      " Non-WSL Linux.
      set shell=/bin/bash
      set clipboard=unnamedplus
    {{ end }}
  {{- else }}
    " macOS or other Unix.
    set shell=/bin/bash
    set clipboard=unnamedplus
  {{ end }}
endif

" -------------------- Helper Functions --------------------
" Ensure the directory for the given path exists.
function! EnsureDirExists(path) abort
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path), 'p')
  endif
endfunction

" -------------------- Cross-Platform Directory Settings --------------------
set undofile                     " Enable persistent undo (save edit history across sessions).

if has('nvim')
  " ----- Neovim: use XDG standard paths (stdpath returns absolute paths) -----
  let s:cache = stdpath('cache')
  let s:data  = stdpath('data')
  let s:state = stdpath('state')

  let &directory = s:cache . '/swap//'
  let &backupdir = s:data . '/backup//,.'
  set writebackup
  let &undodir = s:state . '/undo//'

  call EnsureDirExists(s:cache . '/swap//')
  call EnsureDirExists(s:data . '/backup//')
  call EnsureDirExists(s:state . '/undo//')

  " Expose directories for other templates.
  let s:vim_data_dir = s:data
  let s:vim_cache_dir = s:cache
  let s:vim_state_dir = s:state
else
  " ----- Vim: platform-specific paths -----
  if has('win32')
    " Windows: expand prefix, then add /backup// to preserve // literal.
    let s:swap_dir   = expand('$TEMP') . '/vim-swap//'
    let s:backup_dir = expand('~/vimfiles') . '/backup//'
    let s:undo_dir   = expand('~/vimfiles') . '/undo//'

    let &directory   = s:swap_dir
    let &backupdir   = s:backup_dir . ',.'
    let &undodir     = s:undo_dir
    set writebackup

    call EnsureDirExists(s:swap_dir)
    call EnsureDirExists(s:backup_dir)
    call EnsureDirExists(s:undo_dir)

    " Vim data directory (plugins, autoload, etc.).
    let s:vim_data_dir = expand('~/vimfiles')
    " Windows usually doesn't have separate cache/state, reuse data dir with subfolders.
    let s:vim_cache_dir = expand('$TEMP') . '/vim'
    let s:vim_state_dir = s:vim_data_dir . '/undo'
  else
    " Unix-like: follow XDG spec, use expand() for fallback defaults.
    let s:cache = exists('$XDG_CACHE_HOME') ? $XDG_CACHE_HOME : expand('~/.cache')
    let s:data  = exists('$XDG_DATA_HOME')  ? $XDG_DATA_HOME  : expand('~/.local/share')
    let s:state = exists('$XDG_STATE_HOME') ? $XDG_STATE_HOME : expand('~/.local/state')

    let s:vim_cache = s:cache . '/vim'
    let s:vim_data  = s:data  . '/vim'
    let s:vim_state = s:state . '/vim'

    let &directory   = s:vim_cache . '/swap//'
    let &backupdir   = s:vim_data . '/backup//,.'
    let &undodir     = s:vim_state . '/undo//'
    set writebackup

    call EnsureDirExists(s:vim_cache . '/swap//')
    call EnsureDirExists(s:vim_data . '/backup//')
    call EnsureDirExists(s:vim_state . '/undo//')

    let s:vim_data_dir = s:vim_data
    let s:vim_cache_dir = s:vim_cache
    let s:vim_state_dir = s:vim_state
  endif
endif

" Platform flag for convenience.
let s:is_windows = has('win32')

" Ensure vim data directory is in runtimepath (critical for vim-plug)
if exists('s:vim_data_dir')
  execute 'set runtimepath^=' . s:vim_data_dir
endif

" -------------------- Additional Best Practices --------------------
set hidden                      " Allow modified buffers to be hidden (switch without saving)
set history=1000                 " Keep more command line history
set updatetime=300               " Decrease update time (affects Git gutter, etc.)
set timeoutlen=500 ttimeoutlen=0 " Set timeouts for mapped sequences and key codes
set wildmode=list:longest,full   " Better command-line completion
set shortmess+=I                  " Disable splash screen
set noerrorbells visualbell       " No beeping, use visual bell
set autowrite                    " Automatically save before commands like :next, :make
set mouse=a                       " Enable mouse support in all modes
set encoding=utf-8                " Default encoding
set fileencodings=ucs-bom,utf-8,gbk,default,latin1 " File encoding detection order
set splitright splitbelow         " Prefer opening new splits to the right and below
set autoread                      " Auto-reload files changed externally
set confirm                       " Ask for confirmation instead of failing

" Show matching brackets briefly when typing
set showmatch
set matchtime=2                  " Show match for 0.2 seconds (default is 5)

" Cursor shape per mode (helps identify mode at a glance)
if has('nvim')
  " Neovim handles cursor shapes automatically; optional explicit config:
  " set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
else
  " For Vim in terminal, enable mode-dependent cursor shapes
  let &t_SI = "\<Esc>[6 q"  " Insert mode: line cursor
  let &t_SR = "\<Esc>[4 q"  " Replace mode: underline cursor
  let &t_EI = "\<Esc>[2 q"  " Normal mode: block cursor
endif

" Optional: spell checking (disabled by default)
" set spell spelllang=en_us

" Better folding (manual fold method, open all folds by default)
set foldmethod=manual          " Manual folding (fast, no performance hit)
set foldlevelstart=99          " Start with all folds open

" Minimal status line (if you don't use plugins like lightline)
set laststatus=2               " Always show status line
set statusline=%F%m%r%h%w\ [%Y]\ [%{&ff}]\ [%03v]

" Scroll offsets (keep context when scrolling)
set scrolloff=5                " Keep 5 lines above/below cursor
set sidescrolloff=5            " Keep 5 columns left/right of cursor (horizontal)

" Better completion (popup menu behavior)
set completeopt=menuone,noinsert,noselect  " Show menu even with one match, don't insert
set pumheight=10               " Limit popup menu height

" Improve diff experience (if you use Vim as diff tool)
set diffopt+=vertical          " Prefer vertical diffs

" Automatically trim trailing whitespace on save (optional)
" autocmd BufWritePre * :%s/\s\+$//e

" ==================== End of Universal Core ====================
