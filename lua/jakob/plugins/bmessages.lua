return {
    -- original authors repo was removed, use a backup instead
    -- "ariel-frischer/bmessages.nvim",
    "catgoose/bmessages.nvim",
    opts = {
        split_type = "split"
    },
    keys = {
        {
            "<leader>bm",
            mode = "n",
            function()
                require("bmessages").toggle({
                    split_type = "split",
                    split_direction = "botright"
                })
            end
        }
    }
}
