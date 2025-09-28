return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
        ensure_installed = {
            "misspell",
            "black",
            -- Disabled because we want to use the one that is (usually) installed in the venv
            -- "flake8",
            "isort",
            "cpplint",
        }
    }
}
