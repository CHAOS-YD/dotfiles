" ==================== Universal Base Settings ====================
set nocompatible
filetype plugin indent on
syntax on

" True color support
if has('termguicolors')
  if exists('$COLORTERM') && ($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
    set termguicolors
  elseif has('nvim')
    set termguicolors
  endif
endif

" Search
set hlsearch incsearch ignorecase smartcase

" Indentation
set tabstop=4 shiftwidth=4 expandtab autoindent

" UI
set showcmd wildmenu ruler cursorline number

" ==================== Leader Keys ====================
let mapleader = "\<Space>"
let maplocalleader = "-"

" Editor-specific
if has('nvim')
  set inccommand=nosplit
else
  set ttymouse=sgr
endif

" Shell & clipboard (handled by chezmoi)
if has('win32')
  set shell=cmd.exe
  set shellcmdflag=/c
  set shellredir=>%s\ 2>&1
  set shellpipe=>%s\ 2>&1
  set shellquote= shellxquote=
  set clipboard=unnamed
else
  " (chezmoi injects platform-specific)
  set shell=/bin/bash
  set clipboard=unnamedplus
endif

" Helper
function! EnsureDirExists(path) abort
  if !isdirectory(expand(a:path))
    call mkdir(expand(a:path), 'p')
  endif
endfunction

" Editor configuration home
if has('nvim')
  let g:editor_config_home = stdpath('config')
else
  if has('win32')
    let g:editor_config_home = expand('~/vimfiles')
  else
    let g:editor_config_home = exists('$XDG_CONFIG_HOME') ?
          \ $XDG_CONFIG_HOME . '/vim' : expand('~/.vim')
  endif
endif

" Vim plugin modules directory
if !has('nvim')
  let g:vim_plugin_modules_dir = g:editor_config_home . '/plugins'
endif

" Cross-platform directories
set undofile
if has('nvim')
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
  let s:editor_data_dir = s:data
else
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

if exists('s:editor_data_dir')
  execute 'set runtimepath^=' . s:editor_data_dir
endif

" Additional best practices
set hidden
set updatetime=300
set timeoutlen=200 ttimeoutlen=0
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


