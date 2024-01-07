local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

lspconfig.clangd.setup({
    -- For C++ files we want "gi" to use the clangd functionality to switch
    -- between source and header files.

    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "gi", vim.cmd.ClangdSwitchSourceHeader,
            { desc = "(lsp, C++) [gi] switch source/header", noremap = true }
        )
    end,

    cmd = { "clangd", "--header-insertion=never" },
    capabilities = capabilities
})
