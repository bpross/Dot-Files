set nocompatible              " be iMproved, required
filetype  on                  " required

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
Plugin 'scrooloose/syntastic'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'fatih/vim-go'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tpope/vim-commentary'
Plugin 'posva/vim-vue'
Plugin 'tmsvg/pear-tree'
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
syntax enable
colorscheme desert 

filetype plugin on
filetype indent on

"With a map leader it's possible to do extra key combinations
"like <leader>w save the current file
let mapleader = ","
let g:mapleader = ","
set backspace=2 " make backspace work like most other programs

"Fast Saving
nmap <leader>w :w!<cr>

" Spell check
set spelllang=en
set spellfile=$HOME/.spell/en.utf-8.add
highlight SpellBad     gui=undercurl guisp=red term=undercurl cterm=undercurl

" Solarized
" undercurl support
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

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

"Remove trailing whitespace
nnoremap <leader>T :%s/\s\+$//e<CR>

" PHP Config
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_dry_run = 0

" Python Config
au BufRead,BufNewFile *.py set expandtab

"to get syntax coloring for .t files
augroup filetypedetect
    au! BufRead,BufNewFile *.t setfiletype perl
augroup END

"to get syntax coloring for .ps1 files
au BufNewFile,BufRead *.ps1,*.psc1 setf ps1

"Syntastic config
let g:syntastic_mode_map = { 'passive_filetypes': ['php'] }

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

 autocmd FileType *.js BufWritePre <buffer> %s/\s\+$//e
 autocmd BufNewFile,BufRead *.vue set filetype=vue
 let g:ctrlp_map = '<c-p>'
 let g:ctrlp_cmd = 'CtrlP'
