local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
    local caps = client.server_capabilities

    -- semantic highlighting
    if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
        -- print("highlighting")

        local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
        -- vim.api.nvim_create_autocmd("TextChanged", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --         vim.lsp.buf.semantic_tokens_full()
        --     end,
        -- })

        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            group = augroup,
            buffer = bufnr,
            callback = function()
                require 'nvim-semantic-tokens.semantic_tokens'.refresh(0)
            end,
        })

        -- fire it first time on load as well
        vim.lsp.buf.semantic_tokens_full()
    else
        -- print("not highlighting")
    end

    -- formatting
    if caps.documentRangeFormattingProvider then

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
end
)


lsp.setup()
