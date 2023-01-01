require 'telescope'.setup {
    pickers = {
        colorscheme = {
            enable_preview = true
        },
        lsp_references = {
            path_display = { "tail" },
            fname_width = 30
        }
    }
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.git_branches, {})
