require 'nvim-treesitter.configs'.setup {
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["<C-[>"] = { query = { "@function.outer" },
                    desc = "Next class/functon start" },
            },
            -- goto_next_end = {
            --     ["]M"] = "@function.outer",
            --     ["]["] = "@class.outer",
            -- },
            goto_previous_start = {
                ["<C-]>"] = { query = { "@function.outer" },
                    desc = "Previous class/functon start" },
            },
            -- goto_previous_end = {
            --     ["[M"] = "@function.outer",
            --     ["[]"] = "@class.outer",
            -- },
        },
    },
}
