return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = "main",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
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

    end,
}
