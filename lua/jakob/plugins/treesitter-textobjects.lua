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
        local select = require("nvim-treesitter-textobjects.select")
        local modes = { "n", "x", "o" }
        local set = vim.keymap.set

        set({ "x", "o" }, "iP", function() select.select_textobject("@parameter.inner", "textobjects") end)
        set({ "x", "o" }, "aP", function() select.select_textobject("@parameter.outer", "textobjects") end)

        set(modes, "]}", function()
            move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next class/function start" })

        set(modes, "[{", function()
            move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Previous class/function start" })


        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
        -- vim way: ; goes to the direction you were moving.
        set(modes, ";", ts_repeat_move.repeat_last_move)
        set(modes, ",", ts_repeat_move.repeat_last_move_opposite)

        local eyeliner = require("eyeliner")

        set(modes, "f", function()
            eyeliner.highlight({ forward = true })
            return ts_repeat_move.builtin_f_expr()
        end, { expr = true })

        set(modes, "F", function()
            eyeliner.highlight({ forward = false })
            return ts_repeat_move.builtin_F_expr()
        end, { expr = true })

        set(modes, "t", function()
            eyeliner.highlight({ forward = true })
            return ts_repeat_move.builtin_t_expr()
        end, { expr = true })

        set(modes, "T", function()
            eyeliner.highlight({ forward = false })
            return ts_repeat_move.builtin_T_expr()
        end, { expr = true })

    end,
}
