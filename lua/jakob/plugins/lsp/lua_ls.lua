local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = "Disable",
            },
        },
    },
})
