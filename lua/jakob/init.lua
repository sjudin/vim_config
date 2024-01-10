require("jakob.set")
require("jakob.remap")
require("jakob.lazy")

local color = "gruvbox-material"

-- ------------------------------------
-- Custom colorsheme configuration
-- ------------------------------------
-- Enables transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Define colorscheme specific settings here
if color == "gruvbox" or color == "gruvbox-material" then
    vim.o.background = "dark"
end
if color == "gruvbox-material" then
    vim.g.gruvbox_material_foreground = "original"
end

if color == "catppuccin" then
    require("catppuccin").setup {
        flavour = "macchiato"
    }
end

vim.cmd.colorscheme(color)

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

autocmd({ "FileType", "BufNewFile", "BufRead" }, {
    group = augroup("formatoptions_set_group", {}),
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - "o"
    end
}
)

-- Show which buffer is inactive by only displaying the colorcolumn for that
-- buffer
local bg_highlight = augroup("BgHighlight", {})
autocmd('WinEnter',
    {
        group = bg_highlight,
        pattern = "*",
        callback = function()
            vim.opt.colorcolumn = "80"
        end
    })

autocmd('WinLeave',
    {
        group = bg_highlight,
        pattern = "*",
        callback = function()
            vim.opt.colorcolumn = "0"
        end
    })

-- Detect Jenkinsfiles and set the filetype to groovy
autocmd({ 'BufNewFile', 'BufRead' },
    {
        group = augroup("jenkinsfile_set_filetype_group", {}),
        pattern = "Jenkinsfile*",
        callback = function()
            vim.cmd [[set filetype=groovy]]
        end
    })
