require("nvim-tree").setup {
    sync_root_with_cwd = true,
    update_focused_file = { enable = true }
}
vim.keymap.set("n", "<leader>ne", vim.cmd.NvimTreeToggle, { desc = "(nvim-tree) [n]vim-tree-toggl[e]" })
