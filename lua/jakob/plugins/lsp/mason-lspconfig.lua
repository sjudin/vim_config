return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
        ensure_installed = { "clangd", "efm", "pyright", "cmake", "lua_ls", "jsonls" },
        handlers = {
            function(server_name)
                vim.lsp.enable(server_name)
            end,
            -- Handle pyright on its own since we want to launch pylance instead of pyright if it is available
            ["pyright"] = function()
                if pylance_available() then
                    vim.lsp.enable("pylance")
                else
                    vim.lsp.enable("pyright")
                end
            end
        }
    }
}
