set nocompatible                                        " use vim rather than vi
set nobackup                                            " do not keep a backup file
set nowritebackup                                       " Prevent 'jumping files'
set noswapfile                                          " no swap files...?
set history=50                                          " keep 50 lines of command line history
set ruler                                               " show the cursor position all the time
set showcmd                                             " display incomplete commands
set incsearch                                           " do incremental searching
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode
set hlsearch                                            " highlight search results
set autoindent                                          " make new lines indent to same as line before
set textwidth=80                                        " set textwidth to 80 lines (for gq and stuff)
set nu                                                  " line numbers
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab      " insert 4 spaces when hitting tab
set autochdir                                           " Change directory to the current buffer when opening files.

colorscheme pablo

syntax on                                               " syntax highlighting

set runtimepath^=~/.vim/bundle/ctrlp.vim                " add ctrl-p plugin

autocmd BufWritePre * :%s/\s\+$//e                      " delete trailing whitespace on save

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Default to tree mode
let g:netrw_liststyle=3
