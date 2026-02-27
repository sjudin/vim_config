return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        -- Colemak labels
        labels = "arstgmneioqwfpbjluyäzxcdvkh",
        modes = {
            char = {
                enabled = false
            }
        }
    },
    keys = {
        { "<leader><leader>", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
        { "r",                mode = "o",               function() require("flash").remote() end, desc = "Remote Flash" },
    },
}
