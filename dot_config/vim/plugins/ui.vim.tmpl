" ==================== UI Plugins ====================
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Theme Management Plugins
Plug 'vimpostor/vim-lumen'               " System-wide dark mode sync
Plug 'brcick/gardenal'                    " Quick theme cycling

" Theme plugins (still needed for vim-lumen/gardenal to apply)
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'catppuccin/vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'ayu-theme/ayu-vim'
Plug 'noctis/noctis-vim'

" ==================== Configuration ====================

" --- Airline ---
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" --- indentLine ---
let g:indentLine_char = '│'
let g:indentLine_enabled = 1

" --- Goyo + Limelight ---
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" --- vim-lumen: Auto-switch themes with system dark mode ---
let g:lumen_light_colorscheme = 'catppuccin'   " Light mode theme
let g:lumen_dark_colorscheme = 'gruvbox'       " Dark mode theme

" Auto-refresh lightline on theme switch
function! s:lumen_update_lightline() abort
  if exists('g:loaded_lightline')
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction
autocmd User LumenLight call s:lumen_update_lightline()
autocmd User LumenDark  call s:lumen_update_lightline()

" --- gardenal: Quick manual theme cycling ---
let g:gardenal_themes = [
    \ 'gruvbox',
    \ 'nord',
    \ 'catppuccin',
    \ 'monokai_pro',
    \ 'ayu',
    \ 'noctis'
    \ ]

" NOTE: <Leader>tp is used by NERDTree preview, so we use different keys.
" Next theme: <Leader>tn
" Previous theme: <Leader>tN (capital N)
nnoremap <silent> <Leader>tn :call gardenal#next()<CR>
nnoremap <silent> <Leader>tN :call gardenal#prev()<CR>

" Set default theme
colorscheme gruvbox
set background=dark
