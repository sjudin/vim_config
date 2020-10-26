" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

call plug#begin(stdpath('data').'/plugged')
    " Color scheme
    Plug 'morhetz/gruvbox'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Better file browser
    Plug 'scrooloose/nerdtree'

    " Fzf for fuzzy searching
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Git integration
    Plug 'tpope/vim-fugitive'
    " Git/mercurial/others diff icons on the side of the file lines
    Plug 'mhinz/vim-signify'

    " Nice icons in the file explorer and file type status line.
    Plug 'ryanoasis/vim-devicons'

    " Rainbow parentheses
    Plug 'luochen1990/rainbow'

    " Org-mode in Vim
    Plug 'vimwiki/vimwiki'

call plug#end()

source ~/.config/nvim/basic.vim
source ~/.config/nvim/bindings.vim
source ~/.config/nvim/plugins.vim
