return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim' 
        },
        config = function()
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        require 'telescope'.setup {
            pickers = {
                colorscheme = {
                    enable_preview = true
                },
                lsp_references = {
                    path_display = { "tail" },
                    fname_width = 30
                }
            },
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    }
                }
            }
            }
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "(Telescope) [f]ind [f]iles" })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "(Telescope) [C-p] git files" })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "(Telescope) [f]ind [w]ord" })
vim.keymap.set('n', '<leader>fb', builtin.git_branches, { desc = "(Telescope) [f]ind [b]ranch" })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "(Telescope) [f]ind [s]ymbol" })
vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = "(Telescope) [t]elescope [k]eymaps" })
vim.keymap.set('n', '<leader>tc', builtin.commands, { desc = "(Telescope) [t]elescope [c]ommands" })
        end
    }
}
