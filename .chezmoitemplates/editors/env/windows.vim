" ==================== Windows-specific Environment ====================
" This template is included by Vim/Neovim configs on native Windows.
" It contains optimizations for terminal encoding, file formats, etc.

if has('win32')
    " ----- Terminal encoding (Vim only; Neovim doesn't support termencoding) -----
    if !has('nvim')
        set termencoding=utf-8
    endif

    " ----- File format defaults (CRLF for new files) -----
    set fileformats=dos,unix   " Auto-detect, prioritize dos
    set fileformat=dos          " New files use dos (CRLF)

    " ----- Optional: adjust encoding detection order for GBK files -----
    " Uncomment if you frequently work with GBK-encoded files:
    " set fileencodings=ucs-bom,gbk,utf-8,default,latin1
    " Note: Keep utf-8 first if you mix UTF-8 and GBK files.

    " ----- Additional Windows tweaks (e.g., GUI font) -----
    " if has('gui_running')
    "     set guifont=Consolas:h12
    " endif
endif
