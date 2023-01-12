vim.opt.hidden = false

-- vim.opt.iskeyword = vim.opt.iskeyword - "_"

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- spaces over tabs, use 4 space indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- no swapfile
vim.opt.smartindent = true
vim.opt.wrap = false

-- no swapfile or backup
vim.opt.swapfile = false
vim.opt.backup = false

-- search related options
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- always keep 8 lines when scrolling
vim.opt.scrolloff = 8

-- Make it look good
vim.opt.updatetime = 50
vim.opt.termguicolors = true

-- make % work with "<>" aswell
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"

-- session options
vim.opt.sessionoptions = vim.opt.sessionoptions - "terminal"
vim.opt.sessionoptions = vim.opt.sessionoptions - "buffers"

vim.opt.visualbell = true

-- make tab, etc visible
vim.o.list = true
-- vim.o.listchars = "eol:⏎,tab:▸·,trail:×,nbsp:⎵"

-- show cursorcolumn
vim.o.cursorline = true
vim.o.cursorcolumn = false
