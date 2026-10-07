return {
    "gbprod/substitute.nvim",
    opts = {
        highlight_substituted_text = {
            enabled = false,
        },
        exchange = {
            highlight_substituted_text = false,
        }
    },
    keys = {
        { "cx", function() require('substitute.exchange').operator() end, desc = "Exchange operator" },
        { "cxx", function() require('substitute.exchange').line() end, desc = "Exchange line" },
        { "X", function() require('substitute.exchange').visual() end, mode = "x", desc = "Exchange visual" },
        { "cxc", function() require('substitute.exchange').cancel() end, desc = "Exchange cancel" },
        { "s", function() require('substitute').operator() end, desc = "Substitute operator" },
        { "s", function() require('substitute').visual() end, mode = "x", desc = "Substitute visual" },
        { "ss", function() require('substitute').line() end, desc = "Substitute line" },
        { "S", function() require('substitute').eol() end, desc = "Substitute to eol" },
    },
}
