" Basic settings

set nocompatible
set hidden
set wildmenu
set wildmode=longest:full,full
set nowrap
set formatoptions=cq
set mouse=n
set ls=2
set noswapfile
set iskeyword-=_

" More space for cmd (bottom of screen)
set cmdheight=1

" Horizontal cursor line
" set cursorline

" Searching
set ignorecase
set smartcase
set hlsearch

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
" set t_Co=256
set termguicolors
set background=dark
" Makes sure all plugins are loaded before loading colorscheme
autocmd vimenter * ++nested colorscheme gruvbox
" Allows terminal transparency
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" Read project local .vimrc files
set exrc
set secure

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

au BufEnter *.py let &makeprg='venv/bin/python -m unittest discover -v'
au BufEnter *.cpp,*.h let &makeprg='cd build && cmake .. && make -j4'
