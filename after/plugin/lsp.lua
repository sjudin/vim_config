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
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    vim.keymap.set('x', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Diagnostics
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

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

lsp.setup()
