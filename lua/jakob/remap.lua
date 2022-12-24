vim.g.mapleader = " "

-- Paste visual selection without overwriting register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Source rc file
vim.keymap.set("n", "<C-s>", ":so ~/.config/nvim/init.lua<CR>")

-- keep cursor centered on jump
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- undo breakpoints
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")

-- moving selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
