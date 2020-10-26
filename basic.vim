" Basic settings

set nocompatible
set hidden
set wildmenu
set wildmode=longest:full,full
set nowrap
set formatoptions=cq
set mouse=n
set ls=2
set cmdheight=2

" Rendering
set ttyfast
set lazyredraw
set updatetime=50

" Filetypes for plugins
filetype on
filetype plugin on
filetype indent on

syntax enable

" Line numbers, no visualbell etc
set number relativenumber
set ruler
set visualbell
set encoding=utf-8

" Indenting
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set signcolumn=yes
set colorcolumn=80

" Always show 3 lines at bottom
set scrolloff=3

" Appearance
set listchars=tab:▸\ ,eol:¬
set t_Co=256
set background=dark
colorscheme gruvbox

" Read project local .vimrc files
set exrc
set secure
