" VIM Configuration file "

" Temp - Disable arrow keys to practice h,j,k,l keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Configure width and hight of VIM window
win 260 92

" Hide toolbar from GUI
set go-=T

" Set ruler to indicate cursor's location
set ruler

" Set the history size to maximum
set history=80

" Enabling mouse support
set mouse=a

" Adds line numbers relatively
set number
set relativenumber

" Syntax highlighting
syntax on

" Highlight matches as you type the search pattern 
set incsearch

" Enable highlighting of search results
set hlsearch

" Highlight current line
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

" set dark mode background
set background=dark

" Show matching parentheses
set showmatch

" Set width of tab character
set tabstop	=4

" Enable color themes and true color support
if !has ('gui running')
	set t_Co=256
endif
set termguicolors
colorscheme desert
" colorscheme slate
" colorscheme sorbet
" colorscheme torte
" colorscheme wildcharm 
" colorscheme slate


