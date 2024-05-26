return {
    "ariel-frischer/bmessages.nvim",
    event = "CmdlineEnter",
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
