" ==================== Global Mappings ====================
" These mappings use the global <Leader> (space) and are always available.
" They are defined before plugins, so plugins can override them if needed.

" ------------------------------------------------------------------
" File operations
" ------------------------------------------------------------------
nnoremap <Leader>w  :w<CR>                 " Save current file
nnoremap <Leader>x  :x<CR>                 " Save and close current window
nnoremap <Leader>q  :q<CR>                 " Quit current window (fallback)
nnoremap <Leader>qa :qa<CR>                " Quit all windows
nnoremap <Leader>wa :wa<CR>                " Save all files

" ------------------------------------------------------------------
" Search and navigation
" ------------------------------------------------------------------
nnoremap <Leader><Space> :nohlsearch<CR>   " Clear search highlight
nnoremap <Leader>h     :nohlsearch<CR>     " Alternative clear search
nnoremap <Leader>cn    :cnext<CR>           " Next quickfix item
nnoremap <Leader>cp    :cprevious<CR>       " Previous quickfix item
nnoremap <Leader>cl    :clist<CR>           " List quickfix items

" ------------------------------------------------------------------
" Buffer management
" ------------------------------------------------------------------
nnoremap <Leader>bn    :bnext<CR>           " Next buffer
nnoremap <Leader>bp    :bprevious<CR>       " Previous buffer
nnoremap <Leader>bd    :bdelete<CR>         " Delete current buffer
nnoremap <Leader>bl    :ls<CR>              " List buffers

" ------------------------------------------------------------------
" Editing and clipboard
" ------------------------------------------------------------------
nnoremap Y             y$                   " Make Y behave like C and D

" Copy file paths to clipboard
nnoremap <Leader>fp    :let @+ = expand('%:p')<CR>    " Full path
nnoremap <Leader>fr    :let @+ = expand('%')<CR>      " Relative path
nnoremap <Leader>fd    :let @+ = expand('%:p:h')<CR>   " Directory

" ------------------------------------------------------------------
" Quick editing and reloading of vimrc
" ------------------------------------------------------------------
nnoremap <Leader>ev    :e $MYVIMRC<CR>      " Edit vimrc
nnoremap <Leader>sv    :source $MYVIMRC<CR> " Source vimrc

" ------------------------------------------------------------------
" Working directory
" ------------------------------------------------------------------
nnoremap <Leader>cd    :cd %:p:h<CR>        " Change to current file's directory
nnoremap <Leader>pwd   :pwd<CR>             " Show current directory

" ------------------------------------------------------------------
" Toggles
" ------------------------------------------------------------------
nnoremap <Leader>ln    :set invnumber<CR>   " Toggle line numbers
nnoremap <Leader>lr    :set invrelativenumber<CR> " Toggle relative numbers
nnoremap <Leader>lw    :set invwrap<CR>      " Toggle line wrap

" ------------------------------------------------------------------
" Help
" ------------------------------------------------------------------
nnoremap <Leader>K     :help <C-r><C-w><CR> " Search help for current word

" ------------------------------------------------------------------
" Terminal (if available)
" ------------------------------------------------------------------
if has('terminal')
  nnoremap <Leader>tt   :terminal<CR>       " Open terminal in split
endif

" ==================== netrw Fallback ====================
" Built-in file explorer mappings (always available)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_chgwin = -1
let g:netrw_keepdir = 0
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>f :Lexplore %:p:h<CR>
