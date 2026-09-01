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
            "neocmake",
            "lua_ls",
            "jsonls",
            "bashls",
        },
        -- Python servers are selected explicitly in jakob.lsp so the toggle can
        -- choose one stack without Mason enabling the other one as well.
        -- Keep the legacy CMake server disabled if it is still installed.
        automatic_enable = {
            exclude = { "pyrefly", "pyright", "ruff", "cmake" }
        }
    }
}
