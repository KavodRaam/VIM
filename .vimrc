" VIM Configuration file "

" Disable arrow keys to practice h,j,k,l keys (temporary)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Width and hight of VIM window
win 260 92

" Hide GUI's toolbar
set go-=T

" Set ruler to indicate cursor's location
set ruler

" Set the history size to maximum
set history=80

" Relative line numbers
set number
set relativenumber

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
set tabstop	=4

" Enable color themes and true color support
if !has ('gui running')
	set t_Co=256
endif
set termguicolors
colorscheme desert
