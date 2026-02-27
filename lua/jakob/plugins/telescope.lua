local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- Custom action: select the item and center the cursor on the screen
local select_and_center = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    vim.cmd("normal! zz")
end

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
                    ["<CR>"]  = select_and_center, -- Overrides default enter in insert mode
                },
                n = {
                    ["<CR>"] = select_and_center, -- Overrides default enter in normal mode
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
        { "<leader>ff", builtin.find_files,   desc = "(Telescope) [f]ind [f]iles" },
        { "<leader>fw", builtin.live_grep,    desc = "(Telescope) [f]ind [w]ord" },
        { "<leader>fb", builtin.git_branches, desc = "(Telescope) [f]ind [b]ranch" },
        {
            "<leader>fs",
            -- When confirming a search using aerial we want to make it so that the body
            -- of the function is in the middle of the screen with the confirmed search
            -- at the top
            function()
                require('telescope').extensions.aerial.aerial({
                    ---@diagnostic disable-next-line: unused-local
                    attach_mappings = function(prompt_bufnr, map)
                        local select_and_offset = function(bufnr)
                            actions.select_default(bufnr)

                            local offset_rows = vim.o.scrolloff
                            local cursor_line = vim.api.nvim_win_get_cursor(0)[1]

                            local top_line = math.max(1, cursor_line - offset_rows)
                            vim.fn.winrestview({ topline = top_line })
                        end

                        map('i', '<CR>', select_and_offset)
                        map('n', '<CR>', select_and_offset)

                        -- Return true to keep all other default Telescope mappings
                        return true
                    end
                })
            end,
            desc = "(Telescope) [f]ind [s]ymbol"
        },
        { "<leader>tk", builtin.keymaps,   desc = "(Telescope) [t]elescope [k]eymaps" },
        { "<leader>th", builtin.help_tags, desc = "(Telescope) [t]elescope [h]elptags" },
        { "<leader>tc", builtin.commands,  desc = "(Telescope) [t]elescope [c]ommands" },
        { "<C-p>",      builtin.git_files, desc = "(Telescope) [<C-p> Git files]" },
    },
}
