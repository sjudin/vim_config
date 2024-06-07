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
                local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
                require("lspconfig")[server_name].setup {
                    capabilities = lsp_capabilities
                }
            end,

            ["clangd"] = function()
                require('jakob.lsp_servers.clangd')
            end,
            ["efm"] = function()
                require('jakob.lsp_servers.efm')
            end,
            ["lua_ls"] = function()
                require('jakob.lsp_servers.lua_ls')
            end,
            ["pyright"] = function()
                local configs = require 'lspconfig.configs'
                -- Use pyright as a fallback if pylance does not exist
                require 'lspconfig'.pyright.setup {
                    autostart = not configs["pylance"]["autostart"]
                }
            end
        }
    }
}
