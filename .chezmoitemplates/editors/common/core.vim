" ==================== Universal Vim/Neovim Core ====================
" This template is included by all Vim/Neovim config files.
" It contains basic settings, editor-specific features, and cross‑platform directories.
" This file is designed to be independent of configuration management systems.

" -------------------- Basic Settings --------------------
set nocompatible
filetype plugin indent on
syntax on

" -------------------- True Color Support --------------------
if has('termguicolors')
  if exists('$COLORTERM') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
    set termguicolors
  elseif has('nvim')
    set termguicolors
  endif
endif

" -------------------- Search Settings --------------------
set hlsearch incsearch
set ignorecase smartcase

" -------------------- Indentation --------------------
set tabstop=4 shiftwidth=4
set expandtab autoindent

" -------------------- UI --------------------
set showcmd wildmenu
set ruler cursorline
set number                  " Enable line numbers (relative/absolute toggled by plugin)

" -------------------- Leader --------------------
let mapleader = " "

" -------------------- Editor-Specific Features --------------------
if has('nvim')
  set inccommand=nosplit        " Neovim: live preview of substitute command.
else
  set ttymouse=sgr              " Vim: terminal mouse support.
endif

" -------------------- Platform-Specific Shell & Clipboard --------------------
if has('win32')
  set shell=cmd.exe
  set shellcmdflag=/c
  set shellredir=>%s\ 2>&1
  set shellpipe=>%s\ 2>&1
  set shellquote= shellxquote=
  set clipboard=unnamed
else
  {{- if eq .chezmoi.os "linux" }}
    {{- $kernel := output "uname" "-r" | trim }}
    {{- if or (contains $kernel "WSL") (contains $kernel "microsoft") }}
      {{ template "editors/env/wsl.vim" . }}
    {{- else }}
      set shell=/bin/bash
      set clipboard=unnamedplus
    {{ end }}
  {{- else }}
    set shell=/bin/bash
    set clipboard=unnamedplus
  {{ end }}
endif

" -------------------- Helper Functions --------------------
function! EnsureDirExists(path) abort
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path), 'p')
  endif
endfunction

" ==================== Editor Configuration Home ====================
" This global variable points to the main configuration directory of the current editor.
" It can be used in plugin configurations to reference files inside the config folder.
if has('nvim')
  let g:editor_config_home = stdpath('config')
else
  if has('win32')
    let g:editor_config_home = expand('~/vimfiles')
  else
    " Respect XDG_CONFIG_HOME for Vim
    if exists('$XDG_CONFIG_HOME') && !empty($XDG_CONFIG_HOME)
      let g:editor_config_home = $XDG_CONFIG_HOME . '/vim'
    else
      let g:editor_config_home = expand('~/.vim')
    endif
  endif
endif

" ==================== Vim Plugin Modules Directory ====================
" This variable points to the directory containing Vim's plugin configuration modules.
" It is only defined in Vim (not Neovim) and can be used in plugins.vim.
if !has('nvim')
  let g:vim_plugin_modules_dir = g:editor_config_home . '/plugins'
endif

" -------------------- Cross-Platform Directory Settings --------------------
set undofile

if has('nvim')
  " ----- Neovim: use XDG standard paths -----
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
  " Expose data directory for other templates (used for vim-plug etc.)
  let s:editor_data_dir = s:data
else
  " ----- Vim: platform-specific paths -----
  if has('win32')
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
    let s:editor_data_dir = expand('~/vimfiles')
  else
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
    let s:editor_data_dir = s:vim_data
  endif
endif

let s:is_windows = has('win32')
if exists('s:editor_data_dir')
  execute 'set runtimepath^=' . s:editor_data_dir
endif

" ==================== netrw (Built-in File Explorer) ====================
" Only apply netrw settings if it hasn't been disabled by an external plugin.
if !exists('g:loaded_netrw')
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 4
  let g:netrw_winsize = 25
  let g:netrw_chgwin = -1
  let g:netrw_keepdir = 0
  nnoremap <Leader>e :Lexplore<CR>
  nnoremap <Leader>f :Lexplore %:p:h<CR>
  nnoremap <Leader>n :Lexplore<CR>
endif

" -------------------- Additional Best Practices --------------------
set hidden
set updatetime=300
set shortmess+=I
set noerrorbells visualbell
set autowrite
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,default,latin1
set splitright splitbelow
set autoread
set showmatch
set matchtime=2

if !has('nvim')
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

set foldmethod=manual foldlevelstart=99
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y]\ [%{&ff}]\ [%03v]
set scrolloff=5 sidescrolloff=5
set completeopt=menuone,noinsert,noselect pumheight=10
set diffopt+=vertical

" ==================== End of Universal Core ====================
