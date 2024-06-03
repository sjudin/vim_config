return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-under-comparator',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',

        -- signatures
        'ray-x/lsp_signature.nvim',

        -- vs-code like pictograms to completion menu
        'onsails/lspkind.nvim',

        -- presets for efm language server
        'creativenull/efmls-configs-nvim',

        -- Code action lightbulb
        'kosayoda/nvim-lightbulb',

        -- Autocompletion for neovim config stuff
        'folke/neodev.nvim',
    },
    config = function()
        -- Neodev, needs to be setup before other lsp stuff
        require('neodev').setup {}

        -- Mason, note that this must be setup before lsp-zero
        require('jakob.plugins.lsp.mason')

        local lsp = require('lsp-zero').preset({
            setup_servers_on_start = true,
            set_lsp_keymaps = false,
            configure_diagnostics = true,
            manage_nvim_cmp = true,
            call_servers = 'local',
        })
        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
        })

        vim.diagnostic.config({
            virtual_text = false
        })

        ---@diagnostic disable-next-line: unused-local
        lsp.on_attach(function(client, bufnr)
            -- print(string.format("Attaching %s to buffer %d", client.name, bufnr))
            require "lsp_signature".on_attach({}, bufnr)

            -- LSP actions
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "(lsp) [c]ode [a]ction" })

            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "(lsp) [r]e[n]ame" })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "(lsp) [K]hover doc" })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "(lsp) [g]o [d]efinition" })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "(lsp) [g]oto [D]eclaration" })
            vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = "(lsp) [go] type definition" })
            vim.keymap.set('n', 'gr', function() vim.cmd.Telescope { args = { 'lsp_references' } } end,
                { desc = "(lsp) [g]oto [r]eferences" })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "(lsp) [<C-k>] signature help" })

            -- Diagnostics
            vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "(lsp) [gl]ine diagnostics" })
            vim.keymap.set('n', '<C-[>', vim.diagnostic.goto_prev, { desc = "(lsp) [gk] diagnostic jump previous" })
            vim.keymap.set('n', '<C-]>', vim.diagnostic.goto_next, { desc = "(lsp) [gj] diagnostic jump next" })

            -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "(lsp) [g]oto [i]mplementation" })

            -- Formatting
            vim.keymap.set('n', 'gm', vim.lsp.buf.format, { desc = "(lsp) [g]o for[m]at" })

            -- if client.server_capabilities.inlayHintProvider then
            --     vim.lsp.inlay_hint.enable(true, {bufnr=bufnr})
            -- end
        end
        )


        -- Custom setup for language servers
        require('jakob.plugins.lsp.clangd')
        require('jakob.plugins.lsp.lua_ls')
        require('jakob.plugins.lsp.efm')

        local configs = require 'lspconfig.configs'
        if not configs.pylance then
            configs.pylance = require('jakob.plugins.lsp.pylance')
        end

        require 'lspconfig'.pylance.setup {}
        -- Use pyright as a fallback if pylance does not exist
        require 'lspconfig'.pyright.setup {
            autostart = not configs["pylance"]["autostart"]
        }

        lsp.setup()

        require('jakob.plugins.lsp.nvim-lightbulb')
        require('jakob.plugins.lsp.cmp')
        require('jakob.plugins.lsp.lsp-progress')
    end,
}
