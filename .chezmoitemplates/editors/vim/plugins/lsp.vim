" ==================== LSP / Completion ====================
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ==================== Configuration ====================
" Use <C-space> to trigger completion
inoremap <silent><expr> <C-space> coc#refresh()

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting
nmap <leader>cf  <Plug>(coc-format)

" Show documentation
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Code action
nmap <leader>ca  <Plug>(coc-codeaction)
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>qf  <Plug>(coc-fix-current)

" Tab completion
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-Tab>
      \ coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Global extensions (auto-install on first start)
let g:coc_global_extensions = [
      \ 'coc-marketplace',      " Browse and manage extensions
      \ 'coc-tsserver',         " TypeScript/JavaScript
      \ 'coc-json',             " JSON
      \ 'coc-html',             " HTML
      \ 'coc-css',              " CSS
      \ 'coc-vetur',            " Vue
      \ 'coc-java',             " Java
      \ 'coc-clangd',           " C/C++/ObjC
      \ 'coc-pyright',          " Python
      \ 'coc-kotlin',           " Kotlin
      \ 'coc-prettier',         " Formatting
      \ 'coc-eslint'            " Linting
      \ ]
