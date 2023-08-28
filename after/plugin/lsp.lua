-- Mason, note that this must be setup before lsp-zero
require("mason").setup{}
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "efm", "pyright", "cmake", "lua_ls" },
}
require('mason-tool-installer').setup {
    ensure_installed = {
        "misspell",
        "black",
        "flake8",
        "isort",
        "cpplint",
    }
}

local lsp = require('lsp-zero').preset({
    setup_servers_on_start = true,
    set_lsp_keymaps = false,
    configure_diagnostics = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
})
lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
})

vim.diagnostic.config({
    virtual_text = false
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls()) -- (Optional) Configure lua language server for neovim

require('lspsaga').setup({
    lightbulb = {
        virtual_text = false,
    },
    ui = {
        code_action = '🔨',
    },
    rename = {
        in_select = false
    }
})

lsp.on_attach(function(client, bufnr)
    -- print(string.format("Attaching %s to buffer %d", client.name, bufnr))
    require "lsp_signature".on_attach({}, bufnr)

    -- LSP actions
    -- Lspsaga commands
    vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<cr>", { silent = true, desc = "(lsp) [g]o [f]ind" })

    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<cr>', { desc = "(lsp) [c]ode [a]ction" })
    vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', { desc = "(lsp) [r]e[n]ame" })
    -- vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<cr>', { desc = "(lsp) [g]peek [d]efinition" })
    vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>', { desc = "(lsp) [gl]ine diagnostics" })
    vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<cr>", { desc = "(lsp) [K]hover doc" })

    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "(lsp) [g]o [d]efinition" })
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = "(lsp) [g]oto [D]eclaration" })
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = "(lsp) [go] type definition" })
    vim.keymap.set('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end,
        { desc = "(lsp) [g]oto [r]eferences" })
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "(lsp) [<C-k>] signature help" })

    -- Diagnostics
    vim.keymap.set('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<cr>', { desc = "(lsp) [gj] diagnostic jump next" })
    vim.keymap.set('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { desc = "(lsp) [gk] diagnostic jump previous" })

    -- For C++ files we want "gi" to use the clangd functionality to switch
    -- between source and header files. For other files we want to use
    -- vim.lsp.buf.implementation
    if client.name == 'clangd' then
        vim.keymap.set("n", "gi", vim.cmd.ClangdSwitchSourceHeader, { desc = "(lsp, C++) [gi] switch source/header" })
    else
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "(lsp) [g]oto [i]mplementation" })
    end

    -- Formatting
    vim.keymap.set('n', 'gm', vim.lsp.buf.format, { desc = "(lsp) [g]o for[m]at" })
end
)

-- https://github.com/mattn/efm-langserver
-- Use efm (general-purpose language server) to get formatting for filetypes
-- where the LSP does not have documentFormatting=true. For examples of how this
-- works, have a look at
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua

-- Custom setup for language servers
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lspconfig.clangd.setup({
    cmd = { "clangd", "--header-insertion=never" },
    capabilities = capabilities
})

local misspell = {
    lintCommand = "misspell",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    lintSource = "misspell",
}

lspconfig.efm.setup({
    init_options = { documentFormatting = true },
    -- filetypes = { "python" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            ["="] = { misspell },
            python = {
                require('efmls-configs.formatters.black'),
                require('efmls-configs.linters.flake8'),
                {
                    formatCommand = "isort --stdout ${-l:lineLength} --profile black -",
                    formatStdin = true,
                }
            },
            cpp = {
                require('efmls-configs.linters.cppcheck'),
                require('efmls-configs.linters.cpplint'),
            },
            c = {
                require('efmls-configs.linters.gcc'),
            }
        }
    }
})

lsp.setup()

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',  -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }
})
