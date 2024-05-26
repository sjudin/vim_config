return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup(
            {
                keymaps = {
                    ["q"] = "actions.close",
                }
            }
        )
        vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open parent directory" })
    end
}
