return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local configs = require 'lspconfig.configs'
        if not configs.pylance then
            configs.pylance = require('jakob.lsp_servers.pylance')
        end
        -- Normally we would set this up in mason-lspconfig but since pylance
        -- is not in the mason ecosystem we need to do it here
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("lspconfig")["pylance"].setup {
            capabilities = lsp_capabilities
        }
    end
}
