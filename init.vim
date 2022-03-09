filetype off

call plug#begin('~/.config/nvim/plugged')

" Gerais
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'blackcauldron7/surround.nvim'
Plug 'gennaro-tedesco/nvim-peekup'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sunjon/shade.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'glepnir/indent-guides.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'numToStr/Comment.nvim'

" Temas
Plug 'wojciechkepka/vim-github-dark'

" Haskell

call plug#end()

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 80 column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
colorscheme ghdark

lua require('surround').setup{}
lua require('indent_guides').setup{}
lua require('Comment').setup{}
