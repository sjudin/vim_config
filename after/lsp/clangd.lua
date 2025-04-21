---@type vim.lsp.Config
return {
    cmd = { "clangd", "--header-insertion=never", "--background-index", "-j=8" },
}
