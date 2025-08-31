" ==============================
" VIM Configuration file
" ==============================

" ------------------------------
" Common Settings
" ------------------------------
syntax on                  " Enable syntax highlighting
set go-=T                  " Hide GUI toolbar
set tabstop=3              " Width of <Tab> character is 3 spaces
set expandtab              " Convert <Tab> keypress into spaces instead of tab chars
set wildmenu               " Enable command-line completion menu
set wildmode=list:longest,full " List options, insert longest match, cycle through all
set ruler                  " Show cursor position in the status line
set history=100            " Command-line history size
set number                 " Show line numbers
set incsearch              " Show search matches as you type
set hlsearch               " Highlight all search results
set background=dark        " Use colorscheme for dark background
set showmatch              " Highlight matching brackets/parentheses
set cursorline             " Highlight current line for better visibility
:highlight Cursorline cterm=bold ctermbg=black " Style for current line highlight

" ------------------------------
" Window and Font
" ------------------------------
set guifont=Monospace\ 11  " GUI font
set lines=102              " GUI window height
set columns=350            " GUI window width
" Commands to change font size
command! BS set guifont=Monospace\ 20  " Big Size font
command! NS set guifont=Monospace\ 11  " Normal Size font

" ------------------------------
" Colorscheme and True Colors
" ------------------------------
if !has('gui_running')
    set t_Co=256           " Enable 256-color terminal support
endif
colorscheme desert         " Use 'desert' colorscheme

" ------------------------------
" Code Folding
" ------------------------------
set foldmethod=indent      " Fold based on indentation
set foldlevel=99           " Start with all folds open

" ------------------------------
" Show spaces as dots
" ------------------------------
set conceallevel=2
highlight Conceal guifg=#7a7a7a guibg=#333333
syntax match MySpace / / conceal cchar=·
augroup ConcealSpaces
  autocmd!
  autocmd Syntax * syntax match MySpace / / conceal cchar=·
augroup END

" ------------------------------
" Plugins (EasyAlign)
" ------------------------------
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
call plug#end()
" Start EasyAlign in visual mode with `ga`
xmap ga <Plug>(EasyAlign)

" ------------------------------
" Plugins (Python, ALE, etc.)
" ------------------------------
set nocompatible              " Be iMproved, required
filetype off                  " Required by Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'dense-analysis/ale'
call vundle#end()
filetype plugin indent on     " Enable filetype plugins
au BufNewFile,BufRead *.py set fileformat=unix

" ------------------------------
" Key Mappings & Custom Commands
" ------------------------------
" Double <Esc> clears search highlight
nnoremap <silent> <Esc> <Esc>:noh<Bar>echo ""<CR>

" ------------------------------
" Copy Path of Current File
" :PX → copy full path into clipboard (Register *)
" ------------------------------
if !exists('g:copypath_copy_to_unnamed_register')
    let g:copypath_copy_to_unnamed_register = 0
endif
if !exists('*CopyPath')
  function! CopyPath()
      let @*=expand('%:p')
      if g:copypath_copy_to_unnamed_register
          let @"=expand('%:p')
      endif
  endfunction
endif

command! -nargs=0 PX call CopyPath()

" ------------------------------
" Increment by relative line number in visual mode
" ------------------------------
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" ------------------------------
" Quick search: escape full path in visual mode
" ------------------------------
vnoremap ;vhs yq/p:s/\([\.\[\]\!\/]\)/\\\1/ge<CR><CR>

" ------------------------------
" Save & Quit Shortcuts
" ------------------------------
nnoremap <leader>w  <Esc>:w<CR>
noremap  <leader>q  <Esc>:close<CR>
nmap     <leader>wq <Esc>:w<CR>:close<CR>

" ------------------------------
" Load SV Buffers from file
" ------------------------------
nnoremap <Leader>br  "7yiW:b <C-r>7<CR>
nnoremap <Leader>bw  "7yiW:b <C-r>7
command! LoadSVBuffersFromFile call LoadSVBuffers()
function! LoadSVBuffers()
  for lnum in range(1, line('$'))
    let line = getline(lnum)
    let line = substitute(line, '\s\+$', '', '')  " Explicitly remove trailing spaces
    if line =~ '^+incdir+'
      for f in glob(substitute(line, '^+incdir+', '', '') . '/**/*.sv', 0, 1)
        execute 'badd ' . fnameescape(f)
      endfor
    elseif line =~ '^/projects/'
      execute 'badd ' . fnameescape(line)
    endif
  endfor
endfunction

" ------------------------------
" Filetype settings
" ------------------------------
au BufRead,BufNewFile *.v,*.vh,*.sv,*.svi,*.svh set filetype=verilog_systemverilog_uvm

