vim.g.floaterm_autoclose = 2
vim.g.floaterm_width = 0.85
vim.g.floaterm_height = 0.85

vim.keymap.set("n", "<leader>tt", vim.cmd.FloatermToggle, { desc = "(floaterm) [tt]oggle" })
vim.keymap.set("t", "<leader>tt", vim.cmd.FloatermToggle, { desc = "(floaterm) [tt]oggle" })
