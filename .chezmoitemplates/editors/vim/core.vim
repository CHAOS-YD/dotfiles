" ==================== Vim Core ====================
" Vim-specific core settings (vim-plug auto-install, etc.)

" Ensure vim data directory is defined (fallback if not set in common/core)
if !exists('s:vim_data_dir')
  if has('win32')
    let s:vim_data_dir = expand('~/vimfiles')
  else
    let s:vim_data_dir = exists('$XDG_DATA_HOME') ?
          \ $XDG_DATA_HOME . '/vim' :
          \ expand('~/.local/share/vim')
  endif
endif

" Auto-install vim-plug if missing
let s:plug_target = s:vim_data_dir . '/autoload/plug.vim'
if empty(glob(s:plug_target))
  " Silent download to avoid 'Press ENTER' prompt
  let s:urls = [
        \ 'https://raw.gitcode.com/gh_mirrors/vi/vim-plug/raw/master/plug.vim',
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
        \ 'https://gitee.com/wei_hongjie/vim-plug/raw/master/plug.vim'
        \ ]

  let s:downloaded = 0
  for url in s:urls
    if has('win32')
      silent execute '!curl.exe -s -fLo ' . shellescape(s:plug_target) . ' --create-dirs ' . url
    else
      silent execute '!curl -s -fLo ' . shellescape(s:plug_target) . ' --create-dirs ' . url
    endif
    " Check if file exists (v:shell_error may not be reliable)
    if filereadable(s:plug_target)
      let s:downloaded = 1
      break
    endif
  endfor

  if s:downloaded
    " Add data dir to runtimepath so autoload/plug.vim can be found
    execute 'set runtimepath^=' . s:vim_data_dir
    " Schedule plugin installation after Vim fully starts (official behavior)
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  else
    echohl WarningMsg
    echo "Failed to download vim-plug. Please check network or install manually."
    echohl None
  endif
  unlet! s:downloaded
endif
unlet! s:urls s:plug_target
