-- This module does all lsp-specific setup that needs to be done after plugins
-- are loaded

require('jakob.misc.lsp-progress')

-- Advertise Blink's completion capabilities to every language server. This is
-- required for neocmakelsp, which only provides completions to clients that
-- support snippets.
vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities({}, true),
})

vim.diagnostic.config({
    float = { border = 'rounded' },
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = ''
        }
    }
})

local map = function(m, lhs, rhs, bufnr, desc)
    local key_opts = { buffer = bufnr, desc = desc }
    vim.keymap.set(m, lhs, rhs, key_opts)
end

vim.lsp.enable("ruff")

if vim.g.python_use_pyrefly_ruff then
    vim.lsp.enable("pyrefly")
elseif pylance_available() then
    vim.lsp.enable("pylance")
else
    vim.lsp.enable("pyright")
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        -- print(string.format("Attaching %s to buffer %d", client.name, bufnr))

        -- Pyrefly provides richer hover information. Keep Ruff focused on
        -- linting, code actions, and formatting when both servers are active.
        if client ~= nil and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end

        -- For C++ files we want "gi" to use the clangd functionality to switch
        -- between source and header files.
        if client ~= nil and client.name == "clangd" then
            vim.keymap.set("n", "gi", vim.cmd.LspClangdSwitchSourceHeader,
                { desc = "(lsp, C++) [gi] switch source/header", noremap = true, buffer = bufnr }
            )
        end

        -- LSP actions
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufnr, "(lsp) [c]ode [a]ction")
        map('n', '<leader>rn', vim.lsp.buf.rename, bufnr, "(lsp) [r]e[n]ame")
        map('n', 'K', function() vim.lsp.buf.hover { border = "rounded" } end, bufnr, "(lsp) [K]hover doc")

        map('n', 'gd', vim.lsp.buf.definition, bufnr, "(lsp) [g]o [d]efinition")
        map('n', 'gD', vim.lsp.buf.declaration, bufnr, "(lsp) [g]oto [D]eclaration")
        map('n', 'go', vim.lsp.buf.type_definition, bufnr, "(lsp) [go] type definition")
        map('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end, bufnr,
            "(lsp) [g]oto [r]eferences")
        -- map('n', '<C-k>', vim.lsp.buf.signature_help, bufnr, "(lsp) [<C-k>] signature help")

        -- Diagnostics
        map('n', 'gl', vim.diagnostic.open_float, bufnr, "(lsp) [gl]ine diagnostics")

        local repeat_move = require("repeatable_move")
        local next_diag = function()
            vim.diagnostic.jump({ count = 1, float = true })
        end
        local prev_diag = function()
            vim.diagnostic.jump({ count = -1, float = true })
        end

        next_diag, prev_diag = repeat_move.make_repeatable_move_pair(next_diag, prev_diag)

        map('n', 'gj', next_diag, bufnr, "(lsp) diagnostic jump next")
        map('n', 'gk', prev_diag, bufnr, "(lsp) diagnostic jump previous")

        -- Formatting
        map('n', 'gm', vim.lsp.buf.format, bufnr, "(lsp) [g]o for[m]at")

        -- if client.supports_method(client, "inlayHintProvider") then
        --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        -- end
    end
})
