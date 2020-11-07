" This file contains settings for all plugins used. Including Keybindings,
" thus there are keybindings present both here and in the "bindings" config
"
" Enable this if you have a nerdfont installed and want nicer symbols for
" airline
let fancy_symbols_enabled = 1

" #####################
" ##### Nerdtree ######
" #####################
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <leader>ne nop
nmap <leader>ne :NERDTreeToggle<cr>

" #######################
" ###### Fugitive #######
" #######################
" Git status
nmap <leader>gs :G<CR>
" When merging, use gj to take left and 
" gf to take right
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
" Stage hunk under cursor
nmap <leader>gp :diffput<CR>
" Discard hunk under cursor
nmap <leader>gg :diffget<CR>


" #######################
" ##### Quickscope ######
" #######################
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=120


" ####################
" ####### Fzf ########
" ####################
set rtp+=~/.fzf
" Search files
map <leader>ff :Files<cr>
" Search tags
map <leader>ft :Tags<cr>
" Search word
map <leader>fw :Ag<cr>
" Search buffers
map <leader>fb :Buffers<cr>

" ########################
" ####### Airline ########
" ########################
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    "
    " let g:airline_left_sep = "\uE0B4"
    " let g:airline_right_sep = "\uE0B6"
    let g:airline_left_sep = "\uE0BC"
    let g:airline_right_sep = "\uE0BE"

    " Set line and column number
    let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

    let g:airline_left_alt_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'

else
    let g:webdevicons_enable = 0

endif

" #########################
" ###### Vimspector #######
" #########################
" Starting and stopping debugger
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nmap <leader>dc <Plug>VimspectorContinue
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint

nmap <leader>drc <Plug>VimspectorRunToCursor


" ########################
" ####### Rainbow ########
" ########################
" Set active globally
let g:rainbow_active = 1 


" ########################
" ####### VimWiki ########
" ########################
" Open VimWiki in vertical split instead
nnoremap <leader>ww :vsplit<CR>:VimwikiIndex<CR>

" #######################
" ##### C++ Syntax ######
" #######################
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_posix_standard = 1

" #########################
" ###### CtrlSpace ########
" #########################
nnoremap <Leader>pp :CtrlSpace<CR>
