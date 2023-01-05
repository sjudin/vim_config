require("nvim-tree").setup {
    sync_root_with_cwd = true
}
vim.keymap.set("n", "<leader>ne", vim.cmd.NvimTreeToggle, { desc = "(nvim-tree) [n]vim-tree-toggl[e]" })
