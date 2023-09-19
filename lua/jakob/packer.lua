-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrap packer (will try to install packer if it is not installed)
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Most important plugin ever
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    -- Comments
    use 'numToStr/Comment.nvim'

    -- Fast file navigation
    use 'ThePrimeagen/harpoon'

    -- Remember last cursor placement when reopening neovim
    use 'farmergreg/vim-lastplace'

    -- telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- color scheme
    use "ellisonleao/gruvbox.nvim"
    use 'sainnhe/gruvbox-material'
    use 'olimorris/onedarkpro.nvim'
    use 'folke/tokyonight.nvim'
    use 'marko-cerovac/material.nvim'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    -- Leap
    use 'ggandor/leap.nvim'

    -- Rainbow parentheses
    -- use 'mrjones2014/nvim-ts-rainbow'
    use 'HiPhish/rainbow-delimiters.nvim'

    -- LSP stuff
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
            {
                'nvimdev/lspsaga.nvim', --[[commit = '990be59c4ec904ff5c7d980cb0d067dfa806848e']]
                after = 'nvim-lspconfig',
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- signatures
            { 'ray-x/lsp_signature.nvim' },

            -- vs-code like pictograms to completion menu
            { 'onsails/lspkind.nvim' },

            -- presets for efm language server
            { 'creativenull/efmls-configs-nvim' },

        }
    }

    -- Session management
    use {
        'jedrzejboczar/possession.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly'                    -- optional, updated every week. (see issue #1193)
    }


    -- colorize hex
    use 'norcalli/nvim-colorizer.lua'

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }

    -- floating terminal
    use 'voldikss/vim-floaterm'


    -- show indents
    use "lukas-reineke/indent-blankline.nvim"

    -- autopairs
    use "windwp/nvim-autopairs"

    -- highlights occurrences of word under cursor using treesitter and LSP
    use { 'RRethy/vim-illuminate', config = function()
        require('illuminate').configure()
    end }

    -- startup dashboard
    use { 'glepnir/dashboard-nvim', commit = '4dac085331b6c6ccb98a7057bf7b2df424ccc088' }

    use { "asiryk/auto-hlsearch.nvim", tag = "1.0.0",
        config = function()
            require("auto-hlsearch").setup()
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
