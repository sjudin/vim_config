local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
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
end
)


lsp.setup()
