" ==================== NERDTree Configuration ====================
if exists('g:loaded_nerdtree')
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
endif
