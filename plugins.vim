" This file contains settings for all plugins used. Including Keybindings,
" thus there are keybindings present both here and in the "bindings" config
"
" Enable this if you have a nerdfont installed and want nicer symbols for
" airline
let fancy_symbols_enabled = 1

" #############################
" ##### Gruvbox babyyyyyy #####
" #############################
let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_termcolors=16

" #####################
" ######## Coc ########
" #####################
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" GoTo header from coc-clangd
nmap <silent> gi :CocCommand clangd.switchSourceHeader<CR>
nmap <silent> go :CocCommand clangd.symbolInfo<CR>


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ##############################
" ######## Coc-snippets ########
" ##############################
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

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

" ########################
" ###### Smoothie ########
" ########################
nnoremap <silent> H :call smoothie#upwards()<CR>
nnoremap <silent> L :call smoothie#downwards()<CR>


" #######################
" ##### Quickscope ######
" #######################
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=200


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
lua << EOF
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    colors = {}, -- table of hex strings
    termcolors = {} -- table of colour name strings
  }
}
EOF


" ########################
" ####### VimWiki ########
" ########################
" Open VimWiki in vertical split instead
nnoremap <leader>ww :vsplit<CR>:VimwikiIndex<CR>

" #######################
" ##### C++ Syntax ######
" #######################
" Do not gray out macros
highlight clear LspCxxHlSkippedRegion "ctermfg=DarkGray guifg=DarkGray

" ##########################
" ####### ProSession #######
" ##########################
let g:prosession_dir = '~/.config/nvim/session/'
" Dont create sessions in each folder we open
let g:prosession_on_startup = 0
" Need this in order for tab completion to work
set wildcharm=<tab>
nnoremap <Leader>pp :Prosession <tab>

" ##########################
" ######## VimWiki #########
" ##########################
let g:vimwiki_list = [{'path': '~/.config/nvim/vimwiki'}]

" ##########################
" ########## Hop ###########
" ##########################
lua require'hop'.setup()
nnoremap <silent><leader>hw :HopWord<CR>
nnoremap <silent><leader>hc :HopChar2<CR>


" #################################
" ########## Treesitter ###########
" #################################
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = false,              -- false will disable the whole extension
    disable = { "cpp" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

" #################################
" ############ Semshi #############
" #################################
function MyCustomHighlights()
    hi semshiLocal           ctermfg=209 guifg=#d65d0e
    hi semshiGlobal          ctermfg=214 guifg=#8ec07c
    hi semshiImported        ctermfg=214 guifg=#8ec07c cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#83a598
    hi semshiParameterUnused ctermfg=117 guifg=#458588 cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#d3869b
    hi semshiBuiltin         ctermfg=207 guifg=#b16286
    hi semshiAttribute       ctermfg=49  guifg=#fe8019
    hi semshiSelf            ctermfg=249 guifg=#fb4934
    hi semshiUnresolved      ctermfg=226 guifg=#fabd2f cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ebdbb2 ctermbg=161 guibg=#b57614

    hi semshiErrorSign       ctermfg=231 guifg=#ebdbb2 ctermbg=160 guibg=#fb4934
    hi semshiErrorChar       ctermfg=231 guifg=#ebdbb2 ctermbg=160 guibg=#fb4934
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction

augroup set_gruvbox_semshi
    autocmd!
    autocmd FileType python call MyCustomHighlights()
augroup END

