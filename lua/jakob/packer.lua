-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Most important plugin ever
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    -- Remember last cursor placement when reopening neovim
    use 'farmergreg/vim-lastplace'

    -- telescope (fuzzy finder)
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- color scheme
    -- use "ellisonleao/gruvbox.nvim"
    use 'sainnhe/gruvbox-material'

    -- smooth scrolling
    use "psliwka/vim-smoothie"

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    -- hop
    use 'phaazon/hop.nvim'

    -- Rainbow parentheses
    use 'p00f/nvim-ts-rainbow'

    -- scrollbar
    use 'dstein64/nvim-scrollview'

    -- LSP stuff
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- signatures
            { 'ray-x/lsp_signature.nvim' },
        }
    }

    -- Session management
    use {
        'jedrzejboczar/possession.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
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

    -- Zen mode
    use 'folke/zen-mode.nvim'

end)
