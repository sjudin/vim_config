local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-a>"] = actions.smart_send_to_qflist + actions.open_qflist,
                }
            },
            path_display = { "filename_first" }
        },
        extensions = {
            aerial = {
                -- Set the width of the first two columns (the second
                -- is relevant only when show_columns is set to 'both')
                col1_width = 4,
                col2_width = 30,
                -- How to format the symbols
                format_symbol = function(symbol_path, filetype)
                    if filetype == "json" or filetype == "yaml" then
                        return table.concat(symbol_path, ".")
                    else
                        return symbol_path[#symbol_path]
                    end
                end,
                -- Available modes: symbols, lines, both
                show_columns = "both",
            },
        },
    },
    keys = {
        { "<leader>ff", builtin.find_files,                            desc = "(Telescope) [f]ind [f]iles" },
        { "<leader>fw", builtin.live_grep,                             desc = "(Telescope) [f]ind [w]ord" },
        { "<leader>fb", builtin.git_branches,                          desc = "(Telescope) [f]ind [b]ranch" },
        { "<leader>fs", require('telescope').extensions.aerial.aerial, desc = "(Telescope) [f]ind [s]ymbol" },
        { "<leader>tk", builtin.keymaps,                               desc = "(Telescope) [t]elescope [k]eymaps" },
        { "<leader>tc", builtin.commands,                              desc = "(Telescope) [t]elescope [c]ommands" },
        { "<C-p>",      builtin.git_files,                             desc = "(Telescope) [<C-p> Git files]" },
    },
}
