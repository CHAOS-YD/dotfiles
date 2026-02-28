" ==================== Vim Plugin List ====================
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Smart number switching
Plug 'myusuf3/numbers.vim'

" Smart quit/buffer deletion (global <Leader>q will be mapped to :Sayonara)
Plug 'mhinz/vim-sayonara'

" ==================== Plugin Configuration ====================
let s:nerdtree_dir = s:vim_data_dir . '/plugged/nerdtree'
if isdirectory(s:nerdtree_dir)
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1

  " ------------------------------------------------------------------
  " NERDTree general settings
  " ------------------------------------------------------------------
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

  " ------------------------------------------------------------------
  " NERDTree variable-based mappings (unified with Neo-tree)
  " ------------------------------------------------------------------
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

  " ------------------------------------------------------------------
  " Preview functions (unchanged)
  " ------------------------------------------------------------------
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

  " ------------------------------------------------------------------
  " Buffer-local mappings for NERDTree (including <Leader>q)
  " ------------------------------------------------------------------
  function! NERDTreeSmartQuit()
    if winnr('$') == 1
      enew
      NERDTreeClose
    else
      NERDTreeClose
    endif
  endfunction

  augroup nerdtree_custom_mappings
    autocmd!
    autocmd FileType nerdtree nnoremap <buffer> <silent> l :call nerdtree#ui_glue#invokeKeyMap('o')<CR>
    autocmd FileType nerdtree nnoremap <buffer> <silent> h :call nerdtree#ui_glue#invokeKeyMap('P')<CR>
    autocmd FileType nerdtree nnoremap <buffer> <silent> <C-p> :call NERDTreeManualPreview()<CR>
    autocmd FileType nerdtree nnoremap <buffer> <silent> <Leader>tp :call NERDTreeToggleRealTimePreview()<CR>
    autocmd FileType nerdtree nnoremap <buffer> <silent> q :call NERDTreeSmartQuit()<CR>
    " Override <Leader>q in NERDTree to use the tree's own smart quit
    autocmd FileType nerdtree nnoremap <buffer> <silent> <Leader>q :call NERDTreeSmartQuit()<CR>
  augroup END

  " ------------------------------------------------------------------
  " Extra NERDTree helpers
  " ------------------------------------------------------------------
  autocmd BufEnter <buffer> if &filetype ==# 'nerdtree' | setlocal nonumber norelativenumber | endif
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | enew | endif

  " ------------------------------------------------------------------
  " Global external mappings
  " ------------------------------------------------------------------
  nnoremap <Leader>e :NERDTreeToggle<CR>
  nnoremap <Leader>f :NERDTreeFind<CR>
  nnoremap <Leader>n :NERDTreeToggle<CR>
else
  " NERDTree not installed; netrw fallback is in common/core.vim.
endif
unlet! s:nerdtree_dir

" ------------------------------------------------------------------
" numbers.vim configuration (exclude file manager windows)
" ------------------------------------------------------------------
let g:numbers_exclude = ['nerdtree', 'tagbar', 'vista', 'undotree', 'coc-explorer']

" Note: Global <Leader>q is handled by vim-sayonara plugin (installed above).
" No additional mapping is needed here; vim-sayonara will automatically map :Sayonara.
" If you want to ensure the mapping, you can add:
" nnoremap <silent> <Leader>q :Sayonara<CR>
" (but the plugin already does this by default)
