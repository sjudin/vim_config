return {
    'neovim/nvim-lspconfig',
    config = function()
        local configs = require 'lspconfig.configs'
        if not configs.pylance then
            configs.pylance = require('jakob.lsp_servers.pylance')
        end
    end
}
