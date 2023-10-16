vim.g.mapleader = " "

-- Paste visual selection without overwriting register
vim.keymap.set("v", "<leader>p", '"_dP')

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

-- keep escape behaviour in terminal
vim.keymap.set("t", "<leader><esc>", [[<c-\><c-n>]])

-- Moving up/down also centers (with slight offset)
vim.keymap.set("n", "<C-d>", "<C-d>zz5j")
vim.keymap.set("n", "<C-u>", "<C-u>zz5k")

vim.keymap.set('v', '<LeftRelease>', '"+y', { desc = 'yank on mouse selection', noremap = true })
