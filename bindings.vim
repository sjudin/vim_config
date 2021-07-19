let mapleader = " "

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Paste visual selection without overwriting register
vnoremap <leader>p "_dP

" Source rc file
nnoremap <C-s> :so $NVIMRC<CR>

" Recenter on jump with L and H
" Deprecated for vim-smoothie instead, see plugins.vim
" nnoremap H Hzz
" nnoremap L Lzz

" Clear search
nnoremap <esc> :noh<return><esc>

" Keep escape behaviour in terminal
tnoremap <leader><Esc> <c-\><c-n>                            --for vim
