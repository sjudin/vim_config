return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        vim.keymap.set(
            "n", "m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle harpoon menu" }
        )
        vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
    end
}
