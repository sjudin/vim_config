" Entry point for .vimrc, add plugins and source other settings from here

call plug#begin(stdpath('data').'/plugged')
    " Color scheme
    Plug 'morhetz/gruvbox'

    " Quickscope (Horizontal movement)
    Plug 'unblevable/quick-scope'
    
    " Smooth scrolling
    Plug 'psliwka/vim-smoothie'

    " Coc for semantic completion etc
    Plug 'neoclide/coc.nvim'
    " C++ syntax
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    " Python syntax
    Plug 'vim-python/python-syntax'

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

    " Visual split
    Plug 'wellle/visual-split.vim'

    " Prosession for workspace management. Obsession as dependency
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'

    " Debugging
    Plug 'puremourning/vimspector'

    " Autogenerating documentation
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

    " Autoclosing parentheses etc
    Plug 'tpope/vim-endwise'
    Plug 'rstacruz/vim-closer'


call plug#end()

source ~/.config/nvim/basic.vim
source ~/.config/nvim/bindings.vim
source ~/.config/nvim/plugins.vim
