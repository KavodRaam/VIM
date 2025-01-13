" VIM Configuration file "

" Hide GUI's toolbar
set go-=T

set wildmenu
set wildmode=list:longest,full

" Set ruler to indicate cursor's location
set ruler

" Set the history size to maximum
set history=80

" Relative line numbers
set number
"set relativenumber

" Syntax highlighting
syntax on

" Highlight search matches while typing
set incsearch

" Enable highlighting of search results
set hlsearch

" Highlight current line
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

" Dark mode background
set background=dark

" Highlight matching parentheses
set showmatch

" Width of tab character
set tabstop   =3
set expandtab

" Window and Font definition 
set guifont=Monospace\ 11
set lines=102
set columns=350

" Enable color themes and true color support
if !has ('gui running')
    set t_Co=256
endif
colorscheme desert

"Enable folding method
set foldmethod=indent
set foldlevel=99

" Enable clipboard access
"set clipboard+=unnamedplus

"Python Plugins and Configurations - Start
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
call vundle#end()            " required
filetype plugin indent on    " required
au BufNewFile, BufRead *.py
    "\ set tabstop=4
    "\ set softtabstop=4
    "\ set shiftwidth=4
    "\ set textwidth=79
    "\ set expandtab
    "\ set autoindent
    \ set fileformat=unix
"Python Plugins and Configurations - End

" Commands
command -nargs=0 Ok noh

"Search and replace command - Start
command! -nargs=* -complete=command Replace call s:Replace(<q-args>)
function! s:Replace(...)
    if a:1 == '-h'
        echo "Example: :Replace sentence you want to replace  ||| in this sentence "
    else
        let args = split(a:1, ' ||| ')
        let old_sentence = args[0]
        let new_sentence = args[1]
        execute '%s/'.escape(old_sentence, '/').'/'.escape(new_sentence, '/').'/g'
    endif
endfunction
"Search and replace command - End

" Copy path of current file - Start
if !exists('g:copypath_copy_to_unnamed_register')
    let g:copypath_copy_to_unnamed_register = 0
endif
function CopyPath()
    let @*=expand('%:p')
    " copy unnamed register.
    if g:copypath_copy_to_unnamed_register
        let @"=expand('%:p')
    endif
endfunction
command! -nargs=0 PX call CopyPath()
" Copy path of current file - End

" Increment by line number relative - Start
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>
" Increment by line number relative - End

" Quick search of full path - mark everything in visual mode and then ;vhs
vnoremap ;vhs yq/p:s/\([\.\[\]\!\/]\)/\\\1/ge<cr><cr>


au BufRead,BufNewFile *.v,*.vh,*.sv,*.svi,*.svh      set filetype=verilog_systemverilog_uvm
