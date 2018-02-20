set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"""""""""""""""""""
" General
"""""""""""""""""""
set history=700
set number

filetype plugin on
filetype indent on

"With a map leader it's possible to do extra key combinations
"like <leader>w save the current file
let mapleader = ","
let g:mapleader = ","
set backspace=2 " make backspace work like most other programs

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
syntax enable

set lbr
set tw=500

set ai "Auto Indent
set si "Smart Indent
set wrap "Wrap Lines

"to get syntax coloring for .t files
augroup filetypedetect
    au! BufRead,BufNewFile *.t setfiletype perl
augroup END

execute pathogen#infect()

"Syntastic config

"YCM config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"NerdTree config
 map <Leader>n <plug>NERDTreeTabsToggle<CR>
