" ------------------------------------------------------------------
" NERDTree
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
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" ------------------------------------------------------------------
" vim-sayonara
" ------------------------------------------------------------------
nnoremap <Leader>q :Sayonara<CR>

" ------------------------------------------------------------------
" coc.nvim
" ------------------------------------------------------------------
inoremap <silent><expr> <C-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>cf  <Plug>(coc-format)
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
if exists('*CocActionAsync')
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif
nmap <leader>ca  <Plug>(coc-codeaction)
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" ------------------------------------------------------------------
" fzf.vim
" ------------------------------------------------------------------
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fg :GFiles<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>ft :Tags<CR>
nnoremap <Leader>f; :Commands<CR>

" ------------------------------------------------------------------
" fugitive.vim
" ------------------------------------------------------------------
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gl :Git log<CR>
nnoremap <Leader>gd :Gvdiffsplit<CR>

" ------------------------------------------------------------------
" tagbar
" ------------------------------------------------------------------
nnoremap <LocalLeader>t :TagbarToggle<CR>

" ------------------------------------------------------------------
" tinted-vim theme cycling
" ------------------------------------------------------------------
let s:theme_list = []
let s:theme_files = globpath(&rtp, 'colors/base16-*.vim', 0, 1)
for f in s:theme_files
  call add(s:theme_list, fnamemodify(f, ':t:r'))
endfor
call sort(s:theme_list)

function! CycleTheme()
  if !exists('g:colors_name')
    for theme in s:theme_list
      try
        execute 'colorscheme ' . theme
        echo "Theme set to: " . theme
        return
      catch
        continue
      endtry
    endfor
    return
  endif
  let current = g:colors_name
  let idx = index(s:theme_list, current)
  if idx == -1
    let idx = 0
  else
    let idx = (idx + 1) % len(s:theme_list)
  endif
  let attempts = 0
  while attempts < len(s:theme_list)
    let candidate = s:theme_list[idx]
    try
      execute 'colorscheme ' . candidate
      echo "Theme switched to: " . candidate
      return
    catch
      let idx = (idx + 1) % len(s:theme_list)
      let attempts += 1
    endtry
  endwhile
  echo "No valid theme found"
endfunction

function! CycleThemeReverse()
  if !exists('g:colors_name')
    for theme in s:theme_list
      try
        execute 'colorscheme ' . theme
        echo "Theme set to: " . theme
        return
      catch
        continue
      endtry
    endfor
    return
  endif
  let current = g:colors_name
  let idx = index(s:theme_list, current)
  if idx == -1
    let idx = len(s:theme_list) - 1
  else
    let idx = (idx - 1 + len(s:theme_list)) % len(s:theme_list)
  endif
  let attempts = 0
  while attempts < len(s:theme_list)
    let candidate = s:theme_list[idx]
    try
      execute 'colorscheme ' . candidate
      echo "Theme switched to: " . candidate
      return
    catch
      let idx = (idx - 1 + len(s:theme_list)) % len(s:theme_list)
      let attempts += 1
    endtry
  endwhile
  echo "No valid theme found"
endfunction

nnoremap <silent> <F2> :call CycleTheme()<CR>
nnoremap <silent> <F3> :call CycleThemeReverse()<CR>

" ------------------------------------------------------------------
" vim-lumen (optional)
" ------------------------------------------------------------------
if exists('g:loaded_lumen')
  let g:lumen_light_colorscheme = 'base16-solarized-light'
  let g:lumen_dark_colorscheme  = 'base16-gruvbox'
  function! s:lumen_update_lightline() abort
    if exists('g:loaded_lightline')
      call lightline#colorscheme()
      call lightline#update()
    endif
  endfunction
  autocmd User LumenLight call s:lumen_update_lightline()
  autocmd User LumenDark  call s:lumen_update_lightline()
endif
