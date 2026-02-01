return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            width = 160
        }
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        { "<leader>z", mode = { "n" }, vim.cmd.ZenMode }
    }
}
