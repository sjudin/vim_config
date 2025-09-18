-- This module does all lsp-specific setup that needs to be done after plugins
-- are loaded

require('jakob.misc.lsp-progress')

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("*", { capabilities = lsp_capabilities })

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

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- print(string.format("Attaching %s to buffer %d", client.name, args.buf))

        -- For C++ files we want "gi" to use the clangd functionality to switch
        -- between source and header files.
        if client ~= nil and client.name == "clangd" then
            vim.keymap.set("n", "gi", vim.cmd.LspClangdSwitchSourceHeader,
                { desc = "(lsp, C++) [gi] switch source/header", noremap = true, buffer = args.buf }
            )
        end

        -- LSP actions
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, args.buf, "(lsp) [c]ode [a]ction")
        map('n', '<leader>rn', vim.lsp.buf.rename, args.buf, "(lsp) [r]e[n]ame")
        map('n', 'gK', function() vim.lsp.buf.hover { border = "rounded" } end, args.buf, "(lsp) [K]hover doc")

        map('n', 'gd', vim.lsp.buf.definition, args.buf, "(lsp) [g]o [d]efinition")
        map('n', 'gD', vim.lsp.buf.declaration, args.buf, "(lsp) [g]oto [D]eclaration")
        map('n', 'go', vim.lsp.buf.type_definition, args.buf, "(lsp) [go] type definition")
        map('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end, args.buf,
            "(lsp) [g]oto [r]eferences")
        -- map('n', '<C-k>', vim.lsp.buf.signature_help, args.buf, "(lsp) [<C-k>] signature help")

        -- Diagnostics
        map('n', 'gl', vim.diagnostic.open_float, args.buf, "(lsp) [gl]ine diagnostics")
        map('n', '<C-[>', function() vim.diagnostic.jump { count = -1, float = true } end, args.buf,
            "(lsp) [gk] diagnostic jump previous")
        map('n', '<C-]>', function() vim.diagnostic.jump { count = 1, float = true } end, args.buf,
            "(lsp) [gj] diagnostic jump next")

        -- Formatting
        map('n', 'gm', vim.lsp.buf.format, args.buf, "(lsp) [g]o for[m]at")

        -- if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        -- end
    end
})
