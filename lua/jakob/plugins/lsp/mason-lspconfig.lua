return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        ensure_installed = {
            "clangd",
            "efm",
            "pyrefly",
            "pyright",
            "ruff",
            "cmake",
            "lua_ls",
            "jsonls",
            "bashls",
        },
        -- Python servers are selected explicitly in jakob.lsp so the toggle can
        -- choose one stack without Mason enabling the other one as well.
        automatic_enable = {
            exclude = { "pyrefly", "pyright", "ruff" }
        }
    }
}
