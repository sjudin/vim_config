-- Convert regular print into f-string
vim.keymap.set('n', '<C-s>f', [[:.s/"\(.*\)"/f"\1"<CR>]], { buffer = true, desc = "Make f-string", silent = true })
