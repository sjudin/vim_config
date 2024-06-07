local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                }
            }
        }
    }
})
