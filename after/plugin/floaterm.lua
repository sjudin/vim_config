vim.g.floaterm_autoclose = 2

vim.keymap.set("n", "<leader>tt", vim.cmd.FloatermToggle, { desc = "(floaterm) [tt]oggle" })
vim.keymap.set("t", "<leader>tt", vim.cmd.FloatermToggle, { desc = "(floaterm) [tt]oggle" })
