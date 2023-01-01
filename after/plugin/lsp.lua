local lsp = require('lsp-zero')

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = false,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
    print(string.format("Attaching %s to buffer %d", client.name, bufnr))
    local caps = client.server_capabilities

    -- formatting
    if caps.documentRangeFormattingProvider or caps.documentFormattingProvider then

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("format", {}),
            buffer = bufnr,
            callback = function()
                -- vim.lsp.buf.format()
                vim.cmd.LspZeroFormat()
            end,
        })

    end

    -- automatically open floating window showing errors
    -- comment this out and use "gl" if it is annoying
    -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    --     group = vim.api.nvim_create_augroup("floating_diagnostic", {}),
    --     pattern = "*",
    --     callback = function()
    --         vim.diagnostic.open_float(nil, { focus = false })
    --     end,
    -- })

    require "lsp_signature".on_attach()

    -- LSP actions
    -- Lspsaga commands
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<cr>')
    vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>')
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<cr>')
    vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<cr>')
    vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<cr>")

    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    vim.keymap.set('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end)
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Diagnostics
    vim.keymap.set('n', 'gj', '<cmd>Lspsaga diagnostic_jump_next<cr>')
    vim.keymap.set('n', 'gk', '<cmd>Lspsaga diagnostic_jump_prev<cr>')

    -- For C++ files we want "gi" to use the clangd functionallity to switch
    -- between source and header files. For other files we want to use
    -- vim.lsp.buf.implementation
    if client.name == 'clangd' then
        vim.keymap.set("n", "gi", vim.cmd.ClangdSwitchSourceHeader)
    else
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    end

end
)

lsp.configure('clangd', {
    cmd = { "clangd", "--suggest-missing-includes", "--header-insertion=never" },
})

-- https://github.com/mattn/efm-langserver
-- Use efm (general-purpose language server) to get formatting for filetypes
-- where the LSP does not have documentFormatting=true. For examples of how this
-- works, have a look at
-- https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua
lsp.configure('efm', {
    init_options = { documentFormatting = true },
    filetypes = { "python" },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = {
                {
                    formatCommand = "black -",
                    formatStdin = true,
                }
            }
        }
    }
})


lsp.setup_nvim_cmp({
    formatting = {
        format = require 'lspkind'.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        })
    }
})
lsp.setup()
