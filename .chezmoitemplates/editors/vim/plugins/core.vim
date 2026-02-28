" ==================== Core Plugins ====================
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'myusuf3/numbers.vim'
Plug 'mhinz/vim-sayonara'
Plug 'wellle/targets.vim'               " Additional text objects
Plug 'raimondi/delimitmate'              " Auto-close brackets with intelligence

" ==================== Configuration ====================

" numbers.vim exclude list
let g:numbers_exclude = ['nerdtree', 'tagbar', 'vista', 'undotree', 'coc-explorer']

" NERDTree settings (your existing full config)
let g:NERDTreeWinSize = 30
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore = [
      \ '\~$', '\.swp$', '\.git$', '\.hg$', '\.svn$', '\.DS_Store$',
      \ '__pycache__$', '\.pyc$', '\.class$', '\.o$', '\.obj$'
      \ ]

let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapOpenTab = 't'
let g:NERDTreeMapDelete = 'd'
let g:NERDTreeMapRename = 'r'
let g:NERDTreeMapNewFile = 'a'
let g:NERDTreeMapCopy = 'y'
let g:NERDTreeMapCut = 'x'
let g:NERDTreeMapPaste = 'p'
let g:NERDTreeMapRefresh = 'R'
let g:NERDTreeMapCloseDir = 'q'

" Preview functions (your existing implementations)
function! NERDTreeOpenInEditWindow(fullpath)
  for winnr in range(1, winnr('$'))
    let bufname = bufname(winbufnr(winnr))
    if bufname !=# '' && bufname !~ 'NERD_tree'
      execute winnr . 'wincmd w'
      execute 'edit ' . fnameescape(a:fullpath)
      wincmd p
      return
    endif
  endfor
  for winnr in range(1, winnr('$'))
    let bufnr = winbufnr(winnr)
    if bufname(bufnr) ==# '' && getbufvar(bufnr, '&modified') == 0 && buflisted(bufnr)
      execute winnr . 'wincmd w'
      execute 'edit ' . fnameescape(a:fullpath)
      wincmd p
      return
    endif
  endfor
  rightbelow vertical new
  execute 'vertical resize 80'
  execute 'edit ' . fnameescape(a:fullpath)
  wincmd p
endfunction

function! NERDTreeManualPreview()
  let node = g:NERDTreeFileNode.GetSelected()
  if empty(node) || node.path.isDirectory
    return
  endif
  call NERDTreeOpenInEditWindow(node.path.str())
endfunction

let s:preview_enabled = 0
function! NERDTreeToggleRealTimePreview()
  if s:preview_enabled
    autocmd! NERDTreeRealTimePreview
    let s:preview_enabled = 0
    echo "NERDTree real-time preview disabled"
  else
    augroup NERDTreeRealTimePreview
      autocmd!
      autocmd CursorMoved <buffer> call NERDTreeRealTimePreviewHandler()
    augroup END
    let s:preview_enabled = 1
    echo "NERDTree real-time preview enabled"
  endif
endfunction

function! NERDTreeRealTimePreviewHandler()
  let node = g:NERDTreeFileNode.GetSelected()
  if empty(node) || node.path.isDirectory
    return
  endif
  call NERDTreeOpenInEditWindow(node.path.str())
endfunction

function! NERDTreeSmartQuit()
  if winnr('$') == 1
    enew
    NERDTreeClose
  else
    NERDTreeClose
  endif
endfunction

" Buffer-local mappings for NERDTree
augroup nerdtree_custom_mappings
  autocmd!
  autocmd FileType nerdtree nnoremap <buffer> <silent> l :call nerdtree#ui_glue#invokeKeyMap('o')<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> h :call nerdtree#ui_glue#invokeKeyMap('P')<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> <C-p> :call NERDTreeManualPreview()<CR>
  " Toggle real-time preview with gO (only in NERDTree window)
  autocmd FileType nerdtree nnoremap <buffer> <silent> gO :call NERDTreeToggleRealTimePreview()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> q :call NERDTreeSmartQuit()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> <Leader>q :call NERDTreeSmartQuit()<CR>
augroup END

" Global NERDTree settings
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

" Force disable line numbers in NERDTree
autocmd BufEnter * if &filetype ==# 'nerdtree' | setlocal nonumber norelativenumber | endif

" Auto-create new buffer if only NERDTree remains
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | enew | endif

" delimitmate settings
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
