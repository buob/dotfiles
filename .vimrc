set nocompatible                                        " use vim rather than vi
set nobackup                                            " do not keep a backup file
set nowritebackup                                       " Prevent 'jumping files'
set noswapfile                                          " no swap files...?
set history=50                                          " keep 50 lines of command line history
set undofile                                            " save undos after file closes
set undodir=~/.vim/undos                                " save udo histories in this file
set clipboard=unnamed                                   " save yanks to pbcopy
set ruler                                               " show the cursor position all the time
set showcmd                                             " display incomplete commands
set incsearch                                           " do incremental searching
set backspace=indent,eol,start                          " allow backspacing over everything in insert mode
set hlsearch                                            " highlight search results
set autoindent                                          " make new lines indent to same as line before
set textwidth=0                                         " stop wrapping my shit
set nu                                                  " line numbers
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab      " insert 2 spaces when hitting tab
set nowrap                                              " I hate wordwrap, make me scroll that shiz
set laststatus=2                                        " Show statusline always (not only when 2+ windows)

let mapleader = ","

nnoremap <Leader>b :Unite buffer<cr>
nnoremap <Leader>c :noh<cr>
nnoremap <Leader>f :Unite -start-insert file_rec/async<cr>
nnoremap <Leader>/ :Unite grep:.<cr>
nnoremap <Leader>q :Bdelete<cr>
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gr :Gread<cr>
nnoremap <Leader><Leader> :b1<cr>
nnoremap <Space> <PageDown>
nnoremap - <PageUp>

" remap ; to : so you can just do ;w instead of <Shift-; w>
nnoremap ; :

" normalize pane switching when inside tmux
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>
  nnoremap <C-h> <C-w><C-h>
endif

autocmd BufWritePre * :%s/\s\+$//e                      " delete trailing whitespace on save

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif


" Default to tree mode
let g:netrw_liststyle=3

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/Users/jakebuob/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/jakebuob/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Schemes
NeoBundle 'buob/flatlandia', 'jb/256'
NeoBundle 'buob/soda.vim', 'jb/updates'

" Process
NeoBundle 'bling/vim-airline' " Nicer Status line
NeoBundle 'tpope/vim-surround' " surround arbitrary objects with arbitrary wrappers
NeoBundle 'moll/vim-bbye' " Delete buffers without quitting pane
NeoBundle 'tpope/vim-fugitive' " Git blame & reset from vim file
NeoBundle 'airblade/vim-gitgutter' " Show git diff symbols in gutter

" Unite (searching & buffer management)
NeoBundle 'Shougo/unite.vim' " find in files, fuzzy search, etc. wrapper
NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'mac' : 'make -f make_mac.mak' }} " required for async
NeoBundle 'rking/ag.vim' " silver searcher, faster more powerful `ack`; for use in unite

" Syntax Highlighting
NeoBundle 'groenewege/vim-less'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tfnico/vim-gradle'
NeoBundle 'derekwyatt/vim-scala'

" Language Specific Plugins

"" Clojure
NeoBundle 'tpope/vim-fireplace' " Run clojure REPL inside vim
NeoBundle 'vim-scripts/paredit.vim' " Prevents missing quotes/parens, provides slurping/barfing

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

syntax enable
colorscheme soda

" configure airline

let g:airline_powerline_fonts = 2
let g:airline_theme='flatlandia'

" configure fireplace

map crr :Require<CR>:e<CR>
map cra :Require!<CR>:e<CR>

map cxs :echom fireplace#eval('(user/serve)')<CR>

" configure unite
au FileType unite call s:unite_settings()

function! s:unite_settings()
  imap <buffer> <C-r>   <Plug>(unite_redraw)

  nmap <buffer> <Esc> <Plug>(unite_exit)
endfunction

" Use ag for search

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_ignore_source_files = ['node_modules', 'bower_components']
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".git" --hidden -g ""'
endif
