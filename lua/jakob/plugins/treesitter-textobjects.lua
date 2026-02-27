return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = "main",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        -- Needed because we remap the fFtT movements using eyeliner
        'jinh0/eyeliner.nvim'
    },
    config = function()
        require("nvim-treesitter-textobjects").setup({
            move = {
                set_jumps = true,
            },
        })

        local move = require("nvim-treesitter-textobjects.move")
        local modes = { "n", "x", "o" }

        vim.keymap.set(modes, "]}", function()
            move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next class/function start" })

        vim.keymap.set(modes, "[{", function()
            move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Previous class/function start" })


        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        local eyeliner = require("eyeliner")

        vim.keymap.set({ "n", "x", "o" }, "f", function()
            eyeliner.highlight({ forward = true })
            return ts_repeat_move.builtin_f_expr()
        end, { expr = true })

        vim.keymap.set({ "n", "x", "o" }, "F", function()
            eyeliner.highlight({ forward = false })
            return ts_repeat_move.builtin_F_expr()
        end, { expr = true })

        vim.keymap.set({ "n", "x", "o" }, "t", function()
            eyeliner.highlight({ forward = true })
            return ts_repeat_move.builtin_t_expr()
        end, { expr = true })

        vim.keymap.set({ "n", "x", "o" }, "T", function()
            eyeliner.highlight({ forward = false })
            return ts_repeat_move.builtin_T_expr()
        end, { expr = true })

    end,
}
