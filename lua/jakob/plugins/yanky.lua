return {
    "gbprod/yanky.nvim",
    opts = {
        highlight = {
            on_yank = false,
            on_put = false
        }
    },
    keys = {
        { "p",     mode = { "n", "x" }, "<Plug>(YankyPutAfter)",     desc = "(yanky) Put after" },
        { "P",     mode = { "n", "x" }, "<Plug>(YankyPutBefore)",    desc = "(yanky) Put before" },
        { "gp",    mode = { "n", "x" }, "<Plug>(YankyGPutAfter)",    desc = "(yanky) GPut after" },
        { "gP",    mode = { "n", "x" }, "<Plug>(YankyGPutBefore)",   desc = "(yanky) GPut before" },

        { "<c-e>", mode = { "n" },      "<Plug>(YankyPreviousEntry)" },
        { "<c-n>", mode = { "n" },      "<Plug>(YankyNextEntry)" }
    }
}
