vim.g.mapleader = " "

-- keep cursor centered on jump
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "}", "}zzzv")
vim.keymap.set("n", "{", "{zzzv")

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

-- Delete forward in insert mode
vim.keymap.set('i', '<C-L>', '<C-O>x')

vim.keymap.set('n', '<C-s>w', ':%s/<C-r><C-w>//gc<Left><Left><Left>')
vim.keymap.set('v', '<C-s>w', ':s//gc<Left><Left><Left>')

vim.keymap.set('n', '(', ':b#<CR>zz', { silent = true })
vim.keymap.set('n', ')', ':b#<CR>zz', { silent = true })

-- Switch between paren/curly/straight etc
vim.keymap.set('n', '<C-s>({', [[:.s/(\(.*\))/{\1}/c<CR>]])
vim.keymap.set('n', '<C-s>([', [[:.s/(\(.*\))/[\1]/c<CR>]])
vim.keymap.set('n', '<C-s>(<', [[:.s/(\(.*\))/<\1>/c<CR>]])

vim.keymap.set('n', '<C-s>[{', [[:.s/\[\(.*\)\]/{\1}/c<CR>]])
vim.keymap.set('n', '<C-s>[(', [[:.s/\[\(.*\)\]/(\1)/c<CR>]])
vim.keymap.set('n', '<C-s>[<', [[:.s/\[\(.*\)\]/<\1>/c<CR>]])

vim.keymap.set('n', '<C-s>{[', [[:.s/{\(.*\)}/[\1]/c<CR>]])
vim.keymap.set('n', '<C-s>{(', [[:.s/{\(.*\)}/(\1)/c<CR>]])
vim.keymap.set('n', '<C-s>{<', [[:.s/{\(.*\)}/<\1>/c<CR>]])

vim.keymap.set('n', '<C-s><[', [[:.s/<\(.*\)>/[\1]/c<CR>]])
vim.keymap.set('n', '<C-s><(', [[:.s/<\(.*\)>/(\1)/c<CR>]])
vim.keymap.set('n', '<C-s><{', [[:.s/<\(.*\)>/{\1}/c<CR>]])

-- Duplicate current line below and comment out
vim.keymap.set("n", "ycc", "yygccp", { remap = true })
