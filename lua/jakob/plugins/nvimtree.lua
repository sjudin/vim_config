return {
{
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
        require("nvim-tree").setup {
            sync_root_with_cwd = true,
            update_focused_file = { enable = true }
        }
        vim.keymap.set("n", "<leader>ne", vim.cmd.NvimTreeToggle, { desc = "(nvim-tree) [n]vim-tree-toggl[e]" })
    end

}
}
