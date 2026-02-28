" ==================== Common Key Mappings ====================
" These mappings are shared by both Vim and Neovim.
" They rely on <Leader> being set to space (set in core.vim).

nnoremap <Leader>w :w<CR>       " Save file
nnoremap <Leader>x :x<CR>       " Save and quit

" Generic fallback: quit current window (will be overridden by plugins if available)
nnoremap <Leader>q :q<CR>

" Add more common mappings here...
