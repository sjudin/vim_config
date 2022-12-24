require("jakob.set")
require("jakob.remap")
require("jakob.packer")


-- ------------
-- Autocommands
-- ------------

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("highlight_yank", {})

-- Hightlighted yanks
autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end
})
