"""""""""""""""""""
" General
"""""""""""""""""""
set history=700

filetype plugin on
filetype indent on

"With a map leader it's possible to do extra key combinations
"like <leader>w save the current file
let mapleader = ","
let g:mapleader = ","

"Fast Saving
nmap <leader>w :w!<cr>

""""""""""""""""""""
" User Interface
""""""""""""""""""""
set so=7
set ruler
set ignorecase
set smartcase

"""""""""""""""""""""""
" Text, tab and indents
"""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto Indent
set si "Smart Indent
set wrap "Wrap Lines


