vim.opt.guicursor = ""

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Split directions
vim.opt.splitright = true
-- vim.opt.splitbelow = true

vim.opt.showmode = false

-- spaces over tabs, use 4 space indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.wrap = false

-- no swapfile or backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- search related options
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

-- always keep 8 lines when scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Make it look good
vim.opt.updatetime = 50
vim.opt.termguicolors = true

-- make % work with "<>" aswell
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"

-- session options
vim.opt.sessionoptions = vim.opt.sessionoptions - "terminal"
vim.opt.sessionoptions = vim.opt.sessionoptions - "buffers"

vim.opt.visualbell = true

-- One global statusline
vim.o.laststatus = 3

-- show cursorcolumn
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.cursorlineopt = 'number'

vim.g.clipboard = {
    name = "OSC 52 copy, Wayland paste",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = { "wl-paste", "--no-newline" },
        ["*"] = { "wl-paste", "--primary", "--no-newline" },
    },
}

require("vim._core.ui2").enable({ enable = true })
