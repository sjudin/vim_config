return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
        ensure_installed = { "clangd", "efm", "pyright", "cmake", "lua_ls", "jsonls", "bashls" },
        -- Handle pyright on its own since we want to launch pylance instead of pyright if it is available
        automatic_enable = {
            exclude = { "pyright" }
        }
    }
}
