require("mason").setup {}
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "efm", "pyright", "cmake", "lua_ls", "jsonls" },
}
require('mason-tool-installer').setup {
    ensure_installed = {
        "misspell",
        "black",
        "flake8",
        "isort",
        "cpplint",
    }
}
