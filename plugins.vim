" This file contains settings for all plugins used. Including Keybindings,
" thus there are keybindings present both here and in the "bindings" config
"
" Enable this if you have a nerdfont installed and want nicer symbols for
" airline
let fancy_symbols_enabled = 1


" #####################
" ######## Coc ########
" #####################
" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup
" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" 
" 
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" 
" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" 
" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" " nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" " GoTo header from coc-clangd
" nmap <silent> gi :CocCommand clangd.switchSourceHeader<CR>
" nmap <silent> go :CocCommand clangd.symbolInfo<CR>
" 
" 
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction
" 
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ##############################
" ######## Coc-snippets ########
" ##############################
" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
" 
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" 
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
" 
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
" 
" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

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
" map <leader>fb :Buffers<cr>

" #############################
" ####### Fzf-checkout ########
" #############################
let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_checkout_merge_settings = v:false
let g:fzf_branch_actions = {
      \ 'checkout': {
      \   'prompt': 'Checkout> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'enter',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

nnoremap <silent> <leader>fb :GBranches checkout --locals<CR>


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
" let g:rainbow_active = 1 
" 
" " Disable rainbox for .cmake files
" let g:rainbow_conf = {
" \   'separately': {
" \       'cmake': 0,
" \   }
" \}

lua << EOF
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
" highlight clear LspCxxHlSkippedRegion "ctermfg=DarkGray guifg=DarkGray

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
nnoremap <silent><leader><leader> :HopWord<CR>
" nnoremap <silent><leader>hc :HopChar2<CR>


" #################################
" ########## Floatterm ############
" #################################
let g:floaterm_autoclose=1
nnoremap <silent><leader>tpp :FloatermNew venv/bin/python<CR>
nnoremap <silent><leader>tp :FloatermNew python<CR>
nnoremap <silent><leader>tr :FloatermNew ranger<CR>
nnoremap <silent><leader>tt :FloatermToggle<CR>
tnoremap <silent><leader>tt <c-\><c-n>:FloatermToggle<CR>

hi FloatermNC guibg=gray

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

" #############################
" ########### Compe ###########
" #############################
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

" Compe mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

" Tab and S-Tab for menu navigation
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

EOF

" #############################
" ########## VSnip ############
" #############################

" NOTE: You can use other key to expand snippet.
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'


" #############################
" ######## Neovim LSP #########
" #############################
nnoremap <silent>gi :ClangdSwitchSourceHeader<CR>

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)


end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
     'documentation',
     'detail',
     'additionalTextEdits',
   }
}
-- capabilities.textDocument.semanticHighlightingCapabilities = {
--     semanticHighlighting = true
-- }

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'cmake' }
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--header-insertion=never" },
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
}

require'lspconfig'.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- configurationSources = {"flake8"},
    flags = {
      debounce_text_changes = 150,
    }
}
require'lspconfig'.pylsp.configurationSources = {"flake8"}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF

" #############################
" ##### Gruvbox babyyyyyy #####
" #############################
let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=1

let use_gruvbox_material = 0

if use_gruvbox_material
    let g:airline_theme = 'gruvbox_material'
    let g:gruvbox_material_background = 'soft'
    " let g:gruvbox_material_palette = 'mix'
    let g:gruvbox_material_palette = 'original'
    let g:gruvbox_material_transparent_background = 1
    augroup set_gruvbox_material
        autocmd!
        autocmd vimenter * ++nested colorscheme gruvbox-material
        autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    augroup END
else
    let g:gruvbox_contrast_dark = 'medium'
    let g:airline_theme = 'gruvbox'
    augroup set_gruvbox
        autocmd!
        autocmd vimenter * ++nested colorscheme gruvbox
        autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
    augroup END
endif

" #################################
" ########## Treesitter ###########
" #################################
augroup treesitter_config
    autocmd!
    autocmd vimenter * luafile ~/.config/nvim/lua/treesitter.lua
augroup END

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
