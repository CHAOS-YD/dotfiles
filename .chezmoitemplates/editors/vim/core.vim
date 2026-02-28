" ==================== Vim Core ====================
" Vim-specific core settings (vim-plug auto-install, etc.)

" Ensure editor data directory is defined (fallback if not set in common/core)
if !exists('s:editor_data_dir')
  if has('win32')
    let s:editor_data_dir = expand('~/vimfiles')
  else
    let s:editor_data_dir = exists('$XDG_DATA_HOME') ?
          \ $XDG_DATA_HOME . '/vim' :
          \ expand('~/.local/share/vim')
  endif
endif

" Auto-install vim-plug if missing
let s:plug_target = s:editor_data_dir . '/autoload/plug.vim'
if empty(glob(s:plug_target))
  let s:urls = [
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
    if filereadable(s:plug_target)
      let s:downloaded = 1
      break
    endif
  endfor
  if s:downloaded
    execute 'set runtimepath^=' . s:editor_data_dir
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  else
    echohl WarningMsg
    echo "Failed to download vim-plug. Please check network or install manually."
    echohl None
  endif
  unlet! s:downloaded
endif
unlet! s:urls s:plug_target
