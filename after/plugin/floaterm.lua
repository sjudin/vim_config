vim.g.floaterm_autoclose = 2
vim.g.floaterm_width = 0.85
vim.g.floaterm_height = 0.85

vim.keymap.set({"n", "t"}, "<C-t>", vim.cmd.FloatermToggle, { desc = "(floaterm) [tt]oggle" })
