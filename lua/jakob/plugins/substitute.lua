return {
    "gbprod/substitute.nvim",
    -- dependencies = { "gbprod/yanky.nvim" },
    opts = {
        highlight_substituted_text = {
            enabled = false,
        },
        exchange = {
            highlight_substituted_text = false,
        }
    },
    keys = {
        { "y",   mode = "n", },
        { "cx",  mode = "n",          desc = "Exchange operator" },
        { "cxx", mode = "n",          desc = "Exchange line" },
        { "X",   mode = "x",          desc = "Exchange visual" },
        { "cxc", mode = "n",          desc = "Exchange cancel" },
        { "x",   mode = { "n", "x" }, desc = "Substitute operator/visual" },
        { "xx",  mode = "n",          desc = "Substitute line" },
        { "X",   mode = "n",          desc = "Substitute to eol" },
    },

    config = function(_, opts)
        opts["on_substitute"] = require("yanky.integration").substitute()
        require('substitute').setup(opts)

        local exchange = require('substitute.exchange')
        local substitute = require('substitute')

        -- Exchange mappings
        vim.keymap.set("n", "cx", exchange.operator, { noremap = true, desc = "Exchange" })
        vim.keymap.set("n", "cxx", exchange.line, { noremap = true, desc = "Exchange line" })
        vim.keymap.set("x", "X", exchange.visual, { noremap = true, desc = "Exchange visual" })
        vim.keymap.set("n", "cxc", exchange.cancel, { noremap = true, desc = "Exchange cancel" })

        -- Substitute mappings
        vim.keymap.set("n", "x", substitute.operator, { noremap = true, desc = "Substitute" })
        vim.keymap.set("n", "xx", substitute.line, { noremap = true, desc = "Substitute line" })
        vim.keymap.set("n", "X", substitute.eol, { noremap = true, desc = "Substitute to eol" })
        vim.keymap.set("x", "x", substitute.visual, { noremap = true, desc = "Substitute visual" })
    end,
}
